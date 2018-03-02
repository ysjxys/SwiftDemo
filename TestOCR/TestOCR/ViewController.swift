//
//  ViewController.swift
//  TestOCR
//
//  Created by ysj on 2017/12/21.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import XGDigitalRecognize
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 声明实例变量
    fileprivate var xgDigitalRecognizeService: XGDigitalRecognize = XGDigitalRecognize()
    
    let imageView = UIImageView()
    
    let label = UILabel()
    
//    let cameraVC = ScanImageViewController()
    let cameraVC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width
        let height = view.frame.height
        
        imageView.image = #imageLiteral(resourceName: "image")
        imageView.backgroundColor = UIColor.purple
        imageView.contentMode = .scaleAspectFit
        imageView.frame =  CGRect(x: (width - 250)/2, y: 100, width: 250, height: 250)
        view.addSubview(imageView)
        
        label.frame = CGRect(x: 0, y: imageView.frame.maxY + 50, width: width, height: 20)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "识别内容"
        view.addSubview(label)
        
        let btn = UIButton()
        btn.setTitle("辨别", for: .normal)
        btn.frame = CGRect(x: (width - 100)/2, y: height - 200, width: 100, height: 50)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
        
        let scanBtn = UIButton()
        scanBtn.setTitle("拍照", for: .normal)
        scanBtn.frame = CGRect(x: (width - 100)/2, y: btn.frame.maxY + 50, width: 100, height: 50)
        scanBtn.setTitleColor(UIColor.black, for: .normal)
        scanBtn.layer.borderWidth = 1
        scanBtn.layer.borderColor = UIColor.lightGray.cgColor
        scanBtn.addTarget(self, action: #selector(scanBtnClick), for: .touchUpInside)
        view.addSubview(scanBtn)
        
        cameraVC.sourceType = .camera
        cameraVC.allowsEditing = true
        cameraVC.delegate = self
    }
    
    @objc func scanBtnClick() {
        self.present(cameraVC, animated: true, completion: nil)
    }
    
    @objc func btnClick() {
        guard let image = imageView.image else {
            label.text = "获取图片失败"
            return
        }
        // 对图片进行识别
        self.xgDigitalRecognizeService.recognize(image, { (recognizedString, originImage) in
            DispatchQueue.main.async {
                self.label.text = "识别内容为：\(recognizedString)"
            }
        })
//        self.xgDigitalRecognizeService?.recognize(#imageLiteral(resourceName: "image")) { recognizedString in
//            if recognizedString.utf16.count >= 11 {
//                DispatchQueue.main.async {
//                    self.viewModel.phoneNumStr = recognizedString
//                    self.resultLablePhoneNum?.text = "手机号: " + self.viewModel.phoneNumStr
//                }
//            }
//        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            self.dismiss(animated: true, completion: {
                DispatchQueue.main.async {
                    self.label.text = "获取照片失败"
                }
            })
            return
        }
        
        self.dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                self.imageView.image = image
//                self.imageView.image = self.imageFromImage(imageFromImage: image, inRext: self.cameraVC.scanRect)
            }
        })
        
    }
    
    func imageFromImage(imageFromImage: UIImage, inRext: CGRect) -> UIImage{
        
        //将UIImage转换成CGImageRef
        let sourceImageRef:CGImage = imageFromImage.cgImage!
        
        //按照给定的矩形区域进行剪裁
        let newImageRef:CGImage = sourceImageRef.cropping(to: inRext)!
        
        //将CGImageRef转换成UIImage
        let img:UIImage = UIImage.init(cgImage: newImageRef)
        
        //返回剪裁后的图片
        return img
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

