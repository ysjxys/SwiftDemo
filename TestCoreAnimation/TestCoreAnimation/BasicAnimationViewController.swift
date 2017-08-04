//
//  BasicAnimationViewController.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/7/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class BasicAnimationViewController: UIViewController, BottomBtnsViewDelegate, CAAnimationDelegate {
    
    let layer = CALayer()
    
    let rightView = UIView()
    
    let viewLayer = CALayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let width = CGFloat(100)
        let distance = (view.frame.width - width * 2) / 3
        
        layer.frame = CGRect(x: distance, y: 150, width: width, height: width)
        layer.backgroundColor = UIColor.purple.cgColor
        view.layer.addSublayer(layer)
        
        
        rightView.frame = CGRect(x: distance * 2 + width, y: 150, width: width, height: width)
        rightView.backgroundColor = UIColor.lightGray
        view.addSubview(rightView)
        
        viewLayer.bounds = CGRect(x: 0, y: 0, width: width, height: width)
        viewLayer.position = CGPoint(x: rightView.frame.width/2, y: rightView.frame.height/2)
        viewLayer.backgroundColor = UIColor.red.cgColor
        rightView.layer.addSublayer(viewLayer)
        
        initViews()
    }
    
    func initViews() {
        let bottomView = BottomBtnsView(titleArray: ["位移", "透明度", "缩放", "旋转", "旋转2", "背景色"])
        bottomView.delegate = self
        view.addSubview(bottomView)
    }
    
    func layerBackground() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.purple.cgColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 2
        //CACurrentMediaTime: 图层的当前时间
        animation.beginTime = CACurrentMediaTime() + 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        let viewAnimation = CABasicAnimation(keyPath: "backgroundColor")
        viewAnimation.fromValue = UIColor.red.cgColor
        viewAnimation.toValue = UIColor.purple.cgColor
        viewAnimation.duration = 2
        viewAnimation.isRemovedOnCompletion = false
        viewAnimation.fillMode = kCAFillModeForwards
        viewAnimation.delegate = self
        viewLayer.add(viewAnimation, forKey: "viewAnimation")
    }
    
    func layerRotate2() {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = CATransform3DMakeRotation(0, 0, 0, 1)
        animation.toValue = CATransform3DMakeRotation(CGFloat(-Double.pi), 0, 0, 1)
        animation.duration = 2
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        let viewAnimation = CABasicAnimation(keyPath: "transform")
        viewAnimation.fromValue = CATransform3DMakeRotation(0, 0, 0, 1)
        viewAnimation.toValue = CATransform3DMakeRotation(CGFloat(-Double.pi), 0, 0, 1)
        viewAnimation.duration = 2
        viewAnimation.delegate = self
        viewLayer.add(viewAnimation, forKey: "viewAnimation")
    }
    
    func layerRotate() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = -Double.pi
        animation.duration = 2
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        let viewAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        viewAnimation.fromValue = 0
        viewAnimation.toValue = -Double.pi
        viewAnimation.duration = 2
        viewAnimation.delegate = self
        viewLayer.add(viewAnimation, forKey: "viewAnimation")
    }
    
    func layerZoom() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = 0.5
        animation.duration = 1
        layer.add(animation, forKey: "animation")
        
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.beginTime = CACurrentMediaTime() + 1
//        animation.fromValue = 1.0
//        animation.toValue = 0.5
//        animation.repeatCount = 3
//        animation.repeatDuration = 5
//        animation.duration = 1
//        animation.delegate = self
//        layer.add(animation, forKey: "animation")
        
        let viewAnimation = CABasicAnimation(keyPath: "transform.scale")
        viewAnimation.fromValue = 1.0
        viewAnimation.toValue = 0.5
        viewAnimation.duration = 1
        viewAnimation.delegate = self
        viewLayer.add(viewAnimation, forKey: "viewAnimation")
    }
    
    func layerAlpha() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 1
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        let viewAnimation = CABasicAnimation(keyPath: "opacity")
        viewAnimation.fromValue = 1.0
        viewAnimation.toValue = 0.0
        viewAnimation.duration = 1
        viewAnimation.delegate = self
        viewLayer.add(viewAnimation, forKey: "viewAnimation")
    }
    
    func layerMove() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = layer.position
        animation.toValue = CGPoint(x: layer.position.x, y: layer.position.y + 200)
        animation.duration = 1
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        
        let viewAniamtion = CABasicAnimation(keyPath: "position")
        viewAniamtion.fromValue = viewLayer.position
        viewAniamtion.toValue = CGPoint(x: viewLayer.position.x, y: viewLayer.position.y + 200)
        viewAniamtion.duration = 1
        viewAniamtion.delegate = self
        viewLayer.add(viewAniamtion, forKey: "viewAnimation")
    }
    
    func btnClicked(index: Int) {
        print("\(index)")
        switch index {
        case 0:
            layerMove()
        case 1:
            layerAlpha()
        case 2:
            layerZoom()
        case 3:
            layerRotate()
        case 4:
            layerRotate2()
        case 5:
            layerBackground()
        default:
            print("none")
        }
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("animationDidStart")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
