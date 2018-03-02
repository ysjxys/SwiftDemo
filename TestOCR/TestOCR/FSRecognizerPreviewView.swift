//
//  FSRecognizerPreviewView.swift
//  FastOCR
//
//  Created by 贾宏远 on 2017/8/2.
//  Copyright © 2017年 xinguangnet. All rights reserved.
//

import UIKit
import AVFoundation

public class FSRecognizerPreviewView: UIView {
    
    public var rectOfInterest = CGRect(x: 0.156, y: 0.249, width: 0.688, height: 0.387) {
        didSet {
            guard let metadataOutput = session?.outputs.first as? AVCaptureMetadataOutput else {
                return
            }
            session?.beginConfiguration()
            metadataOutput.rectOfInterest = CGRect(x: rectOfInterest.minY, y: rectOfInterest.minX, width: rectOfInterest.height, height: rectOfInterest.width)
            session?.commitConfiguration()
        }
    }
    
    public var rectOfPreviewInterest: CGRect {
        return CGRect(x: rectOfInterest.minX * bounds.width, y: rectOfInterest.minY * bounds.height, width: rectOfInterest.width * bounds.width, height: rectOfInterest.height * bounds.height)
    }
    
    public var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("viewPreviewLayer 应该是 AVCaptureVideoPreviewLayer 类型，请检查 RecognizerPreviewView.layerClass 的实现")
        }
        return layer
    }
    
    public var session: AVCaptureSession? {
        set {
            videoPreviewLayer.session = newValue
        }
        get {
            return videoPreviewLayer.session
        }
    }
    
    override public class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
