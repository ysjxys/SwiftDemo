//
//  InsideFirstViewController.swift
//  TestPushPopVC
//
//  Created by ysj on 2017/5/31.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class InsideFirstViewController: YSJViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 100))
        label.textAlignment = .center
        label.text = "first"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(label)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "pop", style: .plain, target: self, action: #selector(pop))
    }
    
    func pop() {
//        if let secondVC = tabBarController?.viewControllers?.first {
//            let nav = UIApplication.shared.keyWindow?.rootViewController as? YSJNavigationController
//            nav?.popToViewController(secondVC, animated: true)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
