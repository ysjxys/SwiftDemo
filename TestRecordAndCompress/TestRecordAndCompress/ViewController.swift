//
//  ViewController.swift
//  TestRecordAndCompress
//
//  Created by ysj on 2017/11/14.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import SnapKit
import MobileCoreServices
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let button = UIButton()
        button.setTitle("录像", for: .normal)
        button.backgroundColor = UIColor.purple
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 70))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.purple
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.top.equalTo(button.snp.bottom).offset(50)
        }
    }
    
    @objc func btnClick() {
        
        let videoVC = UIImagePickerController()
        //来源，设置为摄像头
        videoVC.sourceType = .camera
        //使用后置摄像头
        videoVC.cameraDevice = .rear
        //设置为录制视频模式 (kUTTypeImage 为图片模式)
        videoVC.mediaTypes = [kUTTypeMovie as String]
        //设置摄像头模式（拍照，录制视频）
        videoVC.cameraCaptureMode = .video
        //设置为高清模式
        videoVC.videoQuality = .typeHigh
        videoVC.videoMaximumDuration = 120.0
        videoVC.allowsEditing = true
        videoVC.delegate = self
        self.present(videoVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let mediaType = info[UIImagePickerControllerMediaType] as? String ?? ""
        if mediaType == "public.movie" {
            //拍摄完后当前文件临时保存路径
            let videoURL = info[UIImagePickerControllerMediaURL] as? URL ?? URL(fileURLWithPath: "")
            
            VideoServer.shared.compressVideo(url: videoURL, name: "test", isSave: true, successHandle: { [weak self] (data, image) in
                guard let weakSelf = self else {
                    return
                }
                print(data)
                DispatchQueue.main.async {
                    weakSelf.imageView.image = image
                    weakSelf.dismiss(animated: true, completion: nil)
                }
                
                }, failHandle: {
                    print("error")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

