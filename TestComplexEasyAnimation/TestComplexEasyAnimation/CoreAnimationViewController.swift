//
//  CoreAnimationViewController.swift
//  TestComplexEasyAnimation
//
//  Created by ysj on 2017/7/7.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class CoreAnimationViewController: UIViewController {
    
    let layer = CALayer()
    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
//        button.setBackgroundImage(image, for: .normal)
//        button.setBackgroundImage(image, for: .highlighted)
//        view.addSubview(button)
        
        layer.backgroundColor = UIColor.red.cgColor
        layer.frame = CGRect(x: 25, y: 25, width: 50, height: 50)
        button.layer.addSublayer(layer)
//        layer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
//        layer.position = CGPoint(x: 100, y: 100)
//        view.layer.addSublayer(layer)
        
        
        let image = #imageLiteral(resourceName: "icon_annou_un")
        let imageView = UIImageView(image: image)
        imageView.layer.addSublayer(layer)
        
        
        
        let btn = UIButton(frame: CGRect(x: 100, y: view.frame.height - 100, width: 50, height: 50))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        btn.setTitle("动画", for: .normal)
        btn.addTarget(self, action: #selector(animationBtnClick), for: .touchUpInside)
        view.addSubview(btn)
        
        
        let cancelBtn = UIButton(frame: CGRect(x: 200, y: view.frame.height - 100, width: 50, height: 50))
        cancelBtn.setTitle("停止", for: .normal)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.backgroundColor = UIColor.lightGray
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        view.addSubview(cancelBtn)
    }
    
    func animationBtnClick() {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        layer.position = CGPoint(x: 200, y: 200)
        layer.backgroundColor = UIColor.purple.cgColor
        
        CATransaction.commit()
        
    }
    
    func cancelBtnClick() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("CoreAnimationViewController deinit")
    }
}
