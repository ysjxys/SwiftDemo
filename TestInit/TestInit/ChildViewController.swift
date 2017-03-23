//
//  ChildViewController.swift
//  TestInit
//
//  Created by ysj on 2017/3/13.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

class ChildViewController: FatherViewController {
    var paramerChild: String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override init() {
        print("paramerChild   init")
        paramerChild = "paramerChild"
        
        super.init()
//        print("paramerFather   init")
//        paramerFather = "paramerFather"
//        super.init(nibName: nil, bundle: nil)
//        print("FatherViewController   init   over")
        
        print("ChildViewController   init   over")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
