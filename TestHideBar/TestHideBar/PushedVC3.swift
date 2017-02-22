//
//  PushedVC3.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/18.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

//"status:T Nav:T -> status:F Nav:T"


class PushedVC3: BasePushedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeStatusBarState(style: .default, isHidden: true, animation: .slide)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        changeStatusBarState(style: .default, isHidden: false, animation: .none)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //不推荐将VC的statusBar的状态改变代码放到viewDidDisappear方法内，原因是当VC通过pop而disappear后，若VC因其他VC的强引用而仍未释放，而VC的NavigationController已经因pop操作而为nil了，无法通过self.navigationController?.setNeedsStatusBarAppearanceUpdate()来改变statusBar的状态，状态改变代码实际上并未成功执行
        //本demo因为没有强引用PusdedVC，每次pop时VC都会被释放，再次进入时又是一个重新创建的VC，因此状态改变代码放在viewDidDisappear也可以执行，甚至根本不需要页面消失时的状态改变代码，将viewWillDisappear内的代码注释掉，依旧有相应的动画效果
        
//        changeStatusBarState(style: .default, isHidden: false, animation: .none)
    }
    
    override func popBtnClick() {
        super.popBtnClick()
    }
}
