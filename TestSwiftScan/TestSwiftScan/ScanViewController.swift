//
//  ScanViewController.swift
//  TestSwiftScan
//
//  Created by ysj on 2017/3/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import swiftScan

class ScanViewController: LBXScanViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        for result:LBXScanResult in arrayResult{
            print("\(result.strScanned)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
