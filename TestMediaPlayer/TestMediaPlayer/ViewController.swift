//
//  ViewController.swift
//  TestMediaPlayer
//
//  Created by ysj on 2017/3/16.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import Photos
import MediaPicker

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "headImage", style: UIBarButtonItemStyle.plain, target: self, action: #selector(headImageBtnClick))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "shareImage", style: .plain, target: self, action: #selector(shareImageBtnClick))
    }
    
    func shareImageBtnClick() {
        
        let imagePickerVC = ImagePickerViewController()
        //shareImageType  照片选择模式进入
        imagePickerVC.themeColor = UIColor.purple
        imagePickerVC.selectBackgroundColor = UIColor.green
        imagePickerVC.selectNumTextColor = UIColor.red
//        imagePickerVC.cameraBtnImage = UIImage(named: "addition_icon")
//        imagePickerVC.selectImage = UIImage(named: "video_icon")
//        imagePickerVC.isUseSelectImageInShareImageType = true
        imagePickerVC.detailType = .imageVideoType
        imagePickerVC.chooseType = .shareImageType
        imagePickerVC.isNewPhotoFront = true
        imagePickerVC.chooseImagesClosure = {(assetArray) in
            for asset in assetArray {
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                option.resizeMode = .fast
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .default, options: option, resultHandler: { (image, info) in
                    print("image:\(image)")
                })
            }
        }
        
        //        imagePickerVC.isShowByPresent = true
        //        let nav = UINavigationController(rootViewController: imagePickerVC)
        //        self.present(nav, animated: true, completion: nil)
        
        imagePickerVC.isShowByPresent = false
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(imagePickerVC, animated: true)
        hidesBottomBarWhenPushed = false
    }
    
    func headImageBtnClick() {
        //headImageType   头像选择模式进入
        let imagePickerVC = ImagePickerViewController()
        imagePickerVC.isNewPhotoFront = false
        imagePickerVC.chooseType = .headImageType
//        imagePickerVC.selectImage = UIImage(named: "video_icon")
//        imagePickerVC.cameraBtnImage = UIImage(named: "addition_icon")
        //返回headImage的闭包处理部分
        imagePickerVC.chooseHeadImageClosure = {(headImage) in
            print("width:\(headImage.size.width)  height:\(headImage.size.height)")
        }
        
        imagePickerVC.isShowByPresent = true
        let nav = UINavigationController(rootViewController: imagePickerVC)
        self.present(nav, animated: true, completion: nil)
        
        //        imagePickerVC.isShowByPresent = false
        //        hidesBottomBarWhenPushed = true
        //        navigationController?.pushViewController(imagePickerVC, animated: true)
        //        hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

