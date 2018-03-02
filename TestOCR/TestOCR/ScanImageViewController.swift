//
//  ScanImageViewController.swift
//  TestOCR
//
//  Created by ysj on 2017/12/26.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class ScanImageViewController: UIImagePickerController {
    
    public var scanRect: CGRect = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 20 * 2, height: 60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boundsPath = UIBezierPath(rect: view.bounds)
        let scanPath = UIBezierPath(rect: scanRect)
        boundsPath.append(scanPath)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor(white: 0, alpha: 0.6).cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        shapeLayer.path = boundsPath.cgPath

        view.layer.addSublayer(shapeLayer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //override
//    public func layoutSubviews() {
//
//
//    }
}
