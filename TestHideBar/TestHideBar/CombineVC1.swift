//
//  CombineVC1.swift
//  TestHideBar
//
//  Created by ysj on 2017/2/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class CombineVC1: YSJViewController {
    
    var nextBarState: BarState?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "进入VC2", style: .plain, target: self, action: #selector(rightBtnBarClick))
        
        let btnPush = UIButton(frame: CGRect(x: (view.frame.width-100)/2, y: 150, width: 100, height: 100))
        btnPush.setTitle("push", for: .normal)
        btnPush.setTitleColor(UIColor.black, for: .normal)
        btnPush.backgroundColor = UIColor.lightGray
        btnPush.addTarget(self, action: #selector(rightBtnBarClick), for: .touchUpInside)
        view.addSubview(btnPush)
        
        let btnPop = UIButton(frame: CGRect(x: (view.frame.width-100)/2, y: 300, width: 100, height: 100))
        btnPop.setTitle("返回", for: .normal)
        btnPop.setTitleColor(UIColor.black, for: .normal)
        btnPop.backgroundColor = UIColor.lightGray
        btnPop.addTarget(self, action: #selector(popBtnClick), for: .touchUpInside)
        view.addSubview(btnPop)
    }
    
    func popBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func rightBtnBarClick() {
        let vc2 = CombineVC2()
        if let nbs = nextBarState {
            vc2.barState = nbs
        }
        
        navigationController?.pushViewController(vc2, animated: true)
        
    }
}
