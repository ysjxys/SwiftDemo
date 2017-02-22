//
//  NavBarShowFF1.swift
//  TestHideBar
//
//  Created by ysj on 2017/2/6.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

class NavBarShowFF1: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func pushBtnClick() {
        super.pushBtnClick()
    }
    
    override func popBtnClick() {
//        navigationController?.setNavigationBarHidden(false, animated: true)
        super.popBtnClick()
    }
}
