//
//  RecordVideoViewController.swift
//  TestRecordAndCompress
//
//  Created by ysj on 2017/11/14.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class RecordVideoViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let leftBarButton = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(backBtnClick))
        leftBarButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func backBtnClick() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
