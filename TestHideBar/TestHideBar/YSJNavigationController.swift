//
//  YSJNavigationController.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/19.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class YSJNavigationController: UINavigationController {
    
    var statusBarStyle: UIStatusBarStyle = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return statusBarStyle
    }
}


