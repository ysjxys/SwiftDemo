//
//  PushedVC4.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/18.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation


//"status:T Nav:T -> status:F Nav:F"


class PushedVC4: BasePushedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        changeStatusBarState(style: .default, isHidden: true, animation: .slide)
        changeStatusBarState(isHidden: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        changeStatusBarState(style: .default, isHidden: false, animation: .slide)
        changeStatusBarState(isHidden: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func popBtnClick() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.popBtnClick()
    }
}
