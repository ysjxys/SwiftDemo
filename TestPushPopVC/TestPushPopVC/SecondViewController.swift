//
//  secondViewController.swift
//  TestPushPopVC
//
//  Created by ysj on 2017/5/31.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class SecondViewController: YSJViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YSJTabBarController.shared.title = "second"
        YSJTabBarController.shared.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "push", style: .plain, target: self, action: #selector(push))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
    }
    
    func push() {
        print("push")
        YSJTabBarController.shared.navigationController?.pushViewController(InsideSecondViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
