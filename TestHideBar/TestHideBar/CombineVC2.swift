//
//  CombineVC2.swift
//  TestHideBar
//
//  Created by ysj on 2017/2/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class CombineVC2: YSJViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

