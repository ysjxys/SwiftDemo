//
//  PushedVC2.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/18.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation


//"status:T Nav:T -> status:T Nav:F"


class PushedVC2: BasePushedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func popBtnClick() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.popBtnClick()
    }
}
