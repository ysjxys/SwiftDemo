//
//  ViewController3.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/18.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

//"status:T Nav:T -> status:F Nav:T"


class ViewController3: BaseViewController {
    
    var isGotoPurposeVC = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeStatusBarState(style: .default, isHidden: false, animation: .slide)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //statusBar基于控制器控制后，每个VC的statusBar都是一个独立的个体，而statusBar的动画效果仅仅在前后有变化时才显现，因此为了保证每次进入VC都有动画效果，需要在VC的每次消失时将statusBar置于相反的状态
        changeStatusBarState(style: .default, isHidden: true, animation: .none)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func pushBtnClick() {
        isGotoPurposeVC = true
        super.pushBtnClick()
    }
}
