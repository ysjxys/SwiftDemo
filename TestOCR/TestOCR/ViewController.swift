//
//  ViewController.swift
//  TestOCR
//
//  Created by ysj on 2017/12/21.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import XGDigitalRecognize

class ViewController: UIViewController {
    
    // 声明实例变量
    fileprivate var xgDigitalRecognizeService: XGDigitalRecognize?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 对图片进行识别
//        self.xgDigitalRecognizeService?.recognize(self.imgToRecognize!) { recognizedString in
//            if recognizedString.utf16.count >= 11 {
//                DispatchQueue.main.async {
//                    self.viewModel.phoneNumStr = recognizedString
//                    self.resultLablePhoneNum?.text = "手机号: " + self.viewModel.phoneNumStr
//                }
//            }
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

