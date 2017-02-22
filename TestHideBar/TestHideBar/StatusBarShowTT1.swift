//
//  StatusBarShowTT1.swift
//  TestHideBar
//
//  Created by ysj on 2017/2/6.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class StatusBarShowTT1: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: .slide)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func pushBtnClick() {
        super.pushBtnClick()
    }
    
    override func popBtnClick() {
        super.popBtnClick()
    }
}
