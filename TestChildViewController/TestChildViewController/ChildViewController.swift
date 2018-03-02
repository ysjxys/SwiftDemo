//
//  ChildViewController.swift
//  TestChildViewController
//
//  Created by ysj on 2018/2/22.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation
import UIKit

class ChildViewController: UIViewController {
    
    var superVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        let removeBtn = UIButton(frame: CGRect(x: 200, y: 300, width: 100, height: 60))
        removeBtn.backgroundColor = UIColor.lightGray
        removeBtn.addTarget(self, action: #selector(removeBtnClick), for: .touchUpInside)
        removeBtn.setTitle("去除", for: .normal)
        removeBtn.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(removeBtn)
    }
    
    override func didReceiveMemoryWarning() {
        print("ChildViewController didReceiveMemoryWarning")
    }
    
    deinit {
        print("ChildViewController deinit")
    }
    
    @objc func removeBtnClick() {
        view.removeFromSuperview()
        willMove(toParentViewController: nil)
        removeFromParentViewController()
//        removeFromParentViewController 中已经包含了 didMove(toParentViewController 因此不用再重复调用
//        didMove(toParentViewController: nil)
    }
}
