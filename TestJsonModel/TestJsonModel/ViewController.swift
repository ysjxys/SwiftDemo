//
//  ViewController.swift
//  TestJsonModel
//
//  Created by ysj on 2017/3/8.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import JSONModel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let json: [String : Any] = ["id": "10", "country": "Germany", "dialCode": 49, "isInEurope": true]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

