//
//  ViewController.swift
//  TestPushPopVC
//
//  Created by ysj on 2017/5/31.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class FirstViewController: YSJViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YSJTabBarController.shared.title = "first"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "push", style: .plain, target: self, action: #selector(push))
        
        let btn = UIButton(type: .infoDark)
        btn.frame = CGRect(x: 100, y: 200, width: 50, height: 50)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    func btnClick() {
        present(InsideFirstViewController(), animated: true, completion: nil)
    }
    
    func push() {
        navigationController?.pushViewController(InsideFirstViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

