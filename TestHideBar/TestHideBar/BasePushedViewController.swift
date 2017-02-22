//
//  BasePushedViewController.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/18.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class BasePushedViewController: YSJViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let btnPop = UIButton(frame: CGRect(x: (view.frame.width-100)/2, y: 200, width: 100, height: 100))
        btnPop.setTitle("返回", for: .normal)
        btnPop.setTitleColor(UIColor.black, for: .normal)
        btnPop.backgroundColor = UIColor.lightGray
        btnPop.addTarget(self, action: #selector(popBtnClick), for: .touchUpInside)
        view.addSubview(btnPop)
    }
    
    func popBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("PushedViewController  deinit")
    }
}
