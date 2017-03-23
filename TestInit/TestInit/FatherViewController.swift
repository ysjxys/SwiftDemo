//
//  ViewController.swift
//  TestInit
//
//  Created by ysj on 2017/3/13.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class FatherViewController: UIViewController {
    
    var paramerFather: String
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    init() {
        print("paramerFather   init")
        paramerFather = "paramerFather"
        super.init(nibName: nil, bundle: nil)
        print("FatherViewController   init   over")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

