//
//  InsideSecondViewController.swift
//  TestPushPopVC
//
//  Created by ysj on 2017/5/31.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class InsideSecondViewController: YSJViewController {
    
    var rootNav: YSJNavigationController? = UIApplication.shared.keyWindow?.rootViewController as? YSJNavigationController
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YSJTabBarController.shared.title = "InsideSecond"
        YSJTabBarController.shared.navigationItem.backBarButtonItem = UIBarButtonItem(title: "pop", style: .plain, target: self, action: #selector(pop))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        YSJTabBarController.shared.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 100))
        label.textAlignment = .center
        label.text = "second"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(label)
    }
    
    func pop() {
        
        YSJTabBarController.shared.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
