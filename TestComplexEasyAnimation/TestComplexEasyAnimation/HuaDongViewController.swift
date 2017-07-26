//
//  HuaDongViewController.swift
//  TestComplexEasyAnimation
//
//  Created by ysj on 2017/7/4.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class HuaDongViewController:  UIViewController{
    
    let gradientLayer = CAGradientLayer()
    let label = UILabel()
    let specLabel = YSJGradientLabel(frame: CGRect(x: 50, y: 400, width: 300, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
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
        
        
        label.text = "> 滑动来解锁"
        label.textColor = UIColor.black
        label.frame = CGRect(x: 0, y: 100, width: 300, height: 100)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        view.addSubview(label)
        
        gradientLayer.backgroundColor = UIColor.clear.cgColor
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 0, 0.2]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
//        gradientLayer.position = view.center
        
//        gradientLayer.mask = label.layer
//        label.layer.mask = gradientLayer
        
//        view.layer.addSublayer(gradientLayer)

        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        UIGraphicsBeginImageContextWithOptions(label.frame.size, false, 2.0)
//        UIGraphicsBeginImageContext(label.frame.size)
        label.text?.draw(in: label.bounds, withAttributes: [NSFontAttributeName: label.font, NSParagraphStyleAttributeName: style])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
//        let imageView = UIImageView(frame: CGRect(x: 100, y: 200, width: 300, height: 100))
//        imageView.backgroundColor = UIColor.clear
//        imageView.image = image
//        view.addSubview(imageView)
        
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame = CGRect(x: 0, y: 0, width: label.bounds.size.width, height: label.bounds.size.height)
        maskLayer.contents = image?.cgImage
//        maskLayer.contents = #imageLiteral(resourceName: "home_head_portrait").cgImage
        
        gradientLayer.mask = maskLayer
        
        
//        view.layer.addSublayer(maskLayer)
        label.layer.addSublayer(gradientLayer)
        label.text = ""
        label.backgroundColor = UIColor.lightGray
        
        
        
        specLabel.backgroundColor = UIColor.darkGray
        specLabel.iFlashTextOn = true
        specLabel.flashText = "啊啊啊啊啊啊啊啊啊"
        specLabel.flashTextVerticalAlignment = .bottom
        specLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(specLabel)
    }
    
    func animationBtnClick() {
        UIView.animateAndChain(withDuration: 3, delay: 0, options: [], animations: {
            self.gradientLayer.locations = [0.7, 1, 1]
        }, completion: nil).animate(withDuration: 3, delay: 0, options: [.repeat], animations: {
            self.gradientLayer.locations = [0, 0, 0.3]
        }) { (_) in
            
        }
        
//        UIView.animate(withDuration: 3, delay: 0, options: [.repeat], animations: {
//            self.gradientLayer.locations = [0.7, 0.9, 1]
//        }, completion: nil)
    }
    
    func cancelBtnClick() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("HuaDongViewController is deinit")
    }
}
