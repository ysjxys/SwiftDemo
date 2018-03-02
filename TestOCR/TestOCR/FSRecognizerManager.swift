//
//  FSRecognizerManager
//  FastOCR
//
//  Created by 贾宏远 on 2017/7/28.
//  Copyright © 2017年 xinguangnet. All rights reserved.
//

import UIKit
import AVFoundation

public enum SessionSetupResult {
    case success
    case notAuthorizated
    case failure
}

public enum ManagerOutputType {
    case QRCodeAndBarCode
    case videoClippingImage
}

@objc public protocol FSRecognizerManagerDelegate {
    // 当使用条码，二维码检测的时候回调
    @objc optional func manager(_ manager: FSRecognizerManager, didRecognizerCode contents: [String])
    // 当使用视频帧图像输出的时候回调
    @objc optional func manager(_ manager: FSRecognizerManager, didOutput image: UIImage)
}

public class FSRecognizerManager: NSObject {
    
    private var deviceInput: AVCaptureDeviceInput?          // 从设备输入，这里默认是后置摄像头
    
    private var metadataOutput = AVCaptureMetadataOutput()  // 输出元数据，主要用于识别二维码
    
    private var videoDataOutput = AVCaptureVideoDataOutput()// 视频帧数据输出
    
    private var session = AVCaptureSession()                // 捕获会话
    
    public var isRunning: Bool {
        return session.isRunning
    }
    // 预览视图
    public var previewView = FSRecognizerPreviewView() {
        didSet {
            previewView.session = session
            let statusBarOrientation = UIApplication.shared.statusBarOrientation
            var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
            if statusBarOrientation != .unknown {
                if let videoOrientation = statusBarOrientation.videoOrientation {
                    initialVideoOrientation = videoOrientation
                }
            }
            self.previewView.videoPreviewLayer.connection?.videoOrientation = initialVideoOrientation
        }
    }
    
    private(set) var sessionSetupResult: SessionSetupResult = .success   // 会话初始化结果
    
    private(set) var outputType: ManagerOutputType = .QRCodeAndBarCode  //输出类型
    
    public var sessionQueue = DispatchQueue(label: "com.recognizerManager.defaultQueue")    // 会话执行所在的队列
    
    public weak var delegate: FSRecognizerManagerDelegate?   //代理对象
    
    override convenience init() {
        self.init(nil, queue: nil, output: nil)
    }
    
    convenience init(_ previewView: FSRecognizerPreviewView?) {
        self.init(previewView, queue: nil, output: nil)
    }
    
    init(_ previewView: FSRecognizerPreviewView?, queue: DispatchQueue?, output type: ManagerOutputType?) {
        super.init()
        if let previewView = previewView {
            self.previewView = previewView
        }
        if let queue = queue {
            sessionQueue = queue
        }
        if let type = type {
            outputType = type
        }
        checkAuthorizationStatus()
        guard sessionSetupResult != .notAuthorizated else {
            return
        }
        sessionQueue.async { [unowned self] in
            self.configureSession()
        }
        self.previewView.session = session
    }
    
    // MARK: 摄像头授权认证
    public func authorizationStatus() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    }
    
    private func checkAuthorizationStatus() {
        switch authorizationStatus() {
        case .authorized:
            break
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {[unowned self] (granted) in
                if !granted {
                    self.sessionSetupResult = .notAuthorizated
                }
                self.sessionQueue.resume()
            })
        default:
            sessionSetupResult = .notAuthorizated
        }
    }
    
    // MARK: 配置会话
    private func configureSession() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            sessionSetupResult = .failure
            print("获取输入设备失败！")
            return
        }
        session.beginConfiguration()
        if session.canSetSessionPreset(AVCaptureSession.Preset.high) {
            session.sessionPreset = AVCaptureSession.Preset.high
        } else if session.canSetSessionPreset(AVCaptureSession.Preset.medium) {
            session.sessionPreset = AVCaptureSession.Preset.medium
        }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
                DispatchQueue.main.async {
                    let statusBarOrientation = UIApplication.shared.statusBarOrientation
                    var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
                    if statusBarOrientation != .unknown {
                        if let videoOrientation = statusBarOrientation.videoOrientation {
                            initialVideoOrientation = videoOrientation
                        }
                    }
                    self.previewView.videoPreviewLayer.connection?.videoOrientation = initialVideoOrientation
                }
            } else {
                print("添加视频输入到会话失败！")
                sessionSetupResult = .failure
                session.commitConfiguration()
                return
            }
            
        } catch {
            print("创建视频输入失败：\(error)")
            sessionSetupResult = .failure
            session.commitConfiguration()
            return
        }
        switch outputType {
        case .QRCodeAndBarCode:
            addMetadataOutput()
        case .videoClippingImage:
            addVideoDataOutput()
        }
        session.commitConfiguration()
    }
    
    @discardableResult
    private func addMetadataOutput() -> Bool {
        guard session.canAddOutput(metadataOutput) else {
            print("添加元数据输出失败！")
            sessionSetupResult = .failure
            return false
        }
        session.addOutput(metadataOutput)
        metadataOutput.metadataObjectTypes = [.code128, .code39, .code39Mod43, .code93, .ean13, .ean8, .interleaved2of5, .upce]
        // metadaOutput 默认的方向是 AVCaptureVideoOrientation.landscapeRight, 并且不支持方向修改，所以设置 rectOfInterest 的时候要把x和y轴对换
        metadataOutput.rectOfInterest = CGRect(x: previewView.rectOfInterest.minY, y: previewView.rectOfInterest.minX, width: previewView.rectOfInterest.height, height: previewView.rectOfInterest.width)
        metadataOutput.setMetadataObjectsDelegate(self, queue: sessionQueue)
        sessionSetupResult = .success
        return true
    }
    
    @discardableResult
    private func addVideoDataOutput() -> Bool {
        guard self.session.canAddOutput(videoDataOutput) else {
            print("添加帧数据输出失败！")
            sessionSetupResult = .failure
            return false
        }
        self.session.addOutput(videoDataOutput)
        videoDataOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        let statusBarOrientation = UIApplication.shared.statusBarOrientation
        if statusBarOrientation != .unknown, let videoOrientation = statusBarOrientation.videoOrientation {
            if let connection = videoDataOutput.connection(with: AVMediaType.video), connection.isVideoOrientationSupported {
                connection.videoOrientation = videoOrientation
            }
        }
        sessionSetupResult = .success
        return true
    }
    
    public func changeOutput(_ type: ManagerOutputType) {
        guard type != outputType else {
            return
        }
        outputType = type
        sessionQueue.async { [unowned self] in
            switch type {
            case .QRCodeAndBarCode:
                self.session.beginConfiguration()
                self.session.removeOutput(self.videoDataOutput)
                self.addMetadataOutput()
                self.session.commitConfiguration()
            case .videoClippingImage:
                self.session.beginConfiguration()
                self.session.removeOutput(self.metadataOutput)
                self.addVideoDataOutput()
                self.session.commitConfiguration()
            }
        }
    }
    
    public func startRunning() {
        sessionQueue.async {
            self.session.startRunning()
        }
    }
    
    public func stopRunning() {
        sessionQueue.async {
            self.session.stopRunning()
        }
    }
    
    // MARK: 图片处理
    fileprivate func imageFromSampleBuffer(_ sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        CVPixelBufferLockBaseAddress(imageBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) else {
            return nil
        }
        guard let quarzImage = context.makeImage() else {
            CVPixelBufferUnlockBaseAddress(imageBuffer, .readOnly)
            return nil
        }
        CVPixelBufferUnlockBaseAddress(imageBuffer, .readOnly)
        let xScale = CGFloat(1080) / CGFloat(375)
        let yScale = CGFloat(1920) / CGFloat(667)
        let clipFrame = previewView.rectOfPreviewInterest
        guard let croppingImage = quarzImage.cropping(to: CGRect(x: clipFrame.minX * xScale, y: clipFrame.minY * yScale, width: clipFrame.width * xScale, height: clipFrame.height * yScale)) else {
            return nil
        }
        let image = UIImage(cgImage: croppingImage)
        return image
    }

}

// MARK: 代理方法
extension FSRecognizerManager: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        var contents = [String]()
        metadataObjects.forEach { (object) in
            guard let readableCodeObj = object as? AVMetadataMachineReadableCodeObject else {
                return
            }
            contents.append(readableCodeObj.stringValue ?? "")
        }
        DispatchQueue.main.async {
            self.delegate?.manager?(self, didRecognizerCode: contents)
        }
    }
}

extension FSRecognizerManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ captureOutput: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
    public func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let image = imageFromSampleBuffer(sampleBuffer) else {
            return
        }
        DispatchQueue.main.async {
            self.delegate?.manager?(self, didOutput: image)
        }
    }
}

// MARK: 设备方向扩展
extension UIDeviceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        default:
            return nil
        }
    }
}

extension UIInterfaceOrientation {
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        default:
            return nil
        }
    }
}
