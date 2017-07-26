//
//  BottomBtnsView.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/7/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

protocol BottomBtnsViewDelegate: NSObjectProtocol {
    func btnClicked(index: Int)
}

class BottomBtnsView: UIView {
    let titleArray: [String]
    weak var delegate: BottomBtnsViewDelegate?
    
    private let btnWidth = CGFloat(70)
    private let btnHeight = CGFloat(40)
    private let distance: CGFloat
    private let numberPerLine = CGFloat(4)
    
    init(titleArray: [String]) {
        self.titleArray = titleArray
        self.distance = (UIScreen.main.bounds.width - numberPerLine * btnWidth) / (numberPerLine + 1)
        
        let extNum = (titleArray.count % Int(numberPerLine)) == 0 ? 0 : 1
        let height = CGFloat((titleArray.count / Int(numberPerLine)) + extNum) * (btnHeight + distance)
        let y = UIScreen.main.bounds.height - height
        
        super.init(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: height))
        initBtns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initBtns() {
        for i in 0..<titleArray.count {
            createBtn(title: titleArray[i], index: i)
        }
    }
    
    func createBtn(title: String, index: Int) {
        let xNumber = CGFloat(Int(index) % Int(numberPerLine))
        let yNumber = CGFloat(Int(index) / Int(numberPerLine))
        
        let btn = UIButton(frame: CGRect(x: distance + xNumber * (btnWidth + distance), y: yNumber * (btnHeight + distance), width: btnWidth, height: btnHeight))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle(title, for: .normal)
        btn.setTitle(title, for: .highlighted)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.white, for: .highlighted)
        btn.backgroundColor = UIColor.darkGray
        btn.tag = index
        btn.addTarget(self, action: #selector(btnSelect(btn:)), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    func btnSelect(btn: UIButton) {
        delegate?.btnClicked(index: btn.tag)
    }
    
}
