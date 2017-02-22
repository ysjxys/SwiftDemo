//
//  NavBarShowFT1.swift
//  TestHideBar
//
//  Created by ysj on 2017/2/6.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

class NavBarShowFT1: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func pushBtnClick() {
//        navigationController?.setNavigationBarHidden(false, animated: true)
        super.pushBtnClick()
    }
    
    override func popBtnClick() {
//        navigationController?.setNavigationBarHidden(false, animated: true)
        super.popBtnClick()
    }
}
