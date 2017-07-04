//
//  YSJViewController.swift
//  YSJSwiftLibrary
//
//  Created by ysj on 2016/12/20.
//  Copyright © 2016年 ysj. All rights reserved.
//

import Foundation
import UIKit

class YSJViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YSJTabBarController.shared.navigationItem.leftBarButtonItem = nil
        YSJTabBarController.shared.navigationItem.rightBarButtonItem = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(popVC), name: Notification.Name(rawValue: "popVC"), object: nil)
    }
    
    func popVC() {
        print("popVC")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
