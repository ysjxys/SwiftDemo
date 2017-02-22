//
//  BaseViewController.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/17.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: YSJViewController {
    
    var secondVCName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let btnPush = UIButton(frame: CGRect(x: (view.frame.width-100)/2, y: 150, width: 100, height: 100))
        btnPush.setTitle("push", for: .normal)
        btnPush.setTitleColor(UIColor.black, for: .normal)
        btnPush.backgroundColor = UIColor.lightGray
        btnPush.addTarget(self, action: #selector(pushBtnClick), for: .touchUpInside)
        view.addSubview(btnPush)
        
        let btnPop = UIButton(frame: CGRect(x: (view.frame.width-100)/2, y: 300, width: 100, height: 100))
        btnPop.setTitle("返回", for: .normal)
        btnPop.setTitleColor(UIColor.black, for: .normal)
        btnPop.backgroundColor = UIColor.lightGray
        btnPop.addTarget(self, action: #selector(popBtnClick), for: .touchUpInside)
        view.addSubview(btnPop)
        
    }
    
    func pushBtnClick() {
        guard (secondVCName != nil) else {
            print("secondVCName is nil")
            return
        }
        guard let secondVCType = NSClassFromString(secondVCName!) as? BasePushedViewController.Type else {
            print("BasePushedViewController is nil")
            return
        }
        let secondVC = secondVCType.init()
        secondVC.title = self.title
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    func popBtnClick() {
        hidesBottomBarWhenPushed = false
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("ViewController  deinit")
    }
}
