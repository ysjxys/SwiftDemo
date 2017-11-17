//
//  ViewController.swift
//  TestKingfisher
//
//  Created by ysj on 2017/9/30.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
        
        imageView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        imageView.backgroundColor = UIColor.purple
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let btn = UIButton(type: .infoDark)
        btn.frame = CGRect(x: 100, y: 450, width: 80, height: 80)
        btn.addTarget(self, action: #selector(btnClickHandle), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    func btnClickHandle() {
        let str = "http://tubobo-qa.oss-cn-shanghai.aliyuncs.com/merchant/76979/1504683543222?Expires=1506757429&OSSAccessKeyId=LTAIIGYrkYZR9f2b&Signature=kCphR8mstBqGMW%2F%2FY7m9bPNlSjs%3D"
        imageView.kf.setImage(with: URL(string: str), placeholder: #imageLiteral(resourceName: "icon-QR"), options: nil, progressBlock: { (receivedSize, totalSize) in
            print("size:\(Double(receivedSize) / Double(totalSize))")
        }) { (image, error, catchType, url) in
            print("finish")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

