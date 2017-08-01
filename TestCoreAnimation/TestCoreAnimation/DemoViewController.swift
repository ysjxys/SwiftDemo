//
//  DemoViewController.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/7/28.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class DemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 100), cornerRadius: 0).cgPath
        
//        let maskLayer = CALayer()
//        maskLayer.contents = #imageLiteral(resourceName: "user_toobob").cgImage
//        maskLayer.bounds = CGRect(x: 0, y: -100, width: 200, height: 100)
//        maskLayer.anchorPoint = CGPoint(x: 0, y: 0)
//        maskLayer.position = CGPoint(x: 0, y: 0)
//        maskLayer.backgroundColor = UIColor.clear.cgColor
        
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        layer.position = view.center
        layer.backgroundColor = UIColor.purple.cgColor
        layer.cornerRadius = CGFloat(10)
        layer.opacity = 0.5
        layer.borderWidth = 4
        layer.borderColor = UIColor.yellow.cgColor
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 5)
        layer.shadowRadius = 5
        view.layer.addSublayer(layer)
        
        
//        layer.mask = maskLayer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("DemoViewController deinit")
    }
}
