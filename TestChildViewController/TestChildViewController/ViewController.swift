//
//  ViewController.swift
//  TestChildViewController
//
//  Created by ysj on 2018/2/22.
//  Copyright © 2018年 ysj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let addBtn = UIButton(frame: CGRect(x: 200, y: 300, width: 100, height: 60))
        addBtn.backgroundColor = UIColor.lightGray
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        addBtn.setTitle("添加", for: .normal)
        addBtn.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(addBtn)
        
    }
    
    @objc func addBtnClick() {
        let childVC = ChildViewController()
        childVC.superVC = self
        
        view.addSubview(childVC.view)
        //addChildViewController 已经包含了 willMove(toParentViewController， 因此不用再重复调用
//        childVC.willMove(toParentViewController: self)
        self.addChildViewController(childVC)
        childVC.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("ViewController deinit")
    }
}

