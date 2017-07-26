//
//  KeyFrameAnimationViewController.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/7/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class KeyFrameAnimationViewController: UIViewController, BottomBtnsViewDelegate, CAAnimationDelegate {
    
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
        let bottomView = BottomBtnsView(titleArray: ["关键帧", "贝塞尔", "抖动"])
        bottomView.delegate = self
        view.addSubview(bottomView)
    }
    
    func layerShake() {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = [
            CATransform3DMakeRotation(0, 0, 0, 1),
            CATransform3DMakeRotation(CGFloat(Double.pi/16), 0, 0, 1),
            CATransform3DMakeRotation(0, 0, 0, 1),
            CATransform3DMakeRotation(CGFloat(-Double.pi/16), 0, 0, 1),
            CATransform3DMakeRotation(0, 0, 0, 1)]
        animation.duration = 0.5
        animation.repeatCount = MAXFLOAT
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        let viewAniamtion = CAKeyframeAnimation(keyPath: "transform")
        viewAniamtion.values = [
            CATransform3DMakeRotation(0, 0, 0, 1),
            CATransform3DMakeRotation(CGFloat(Double.pi/16), 0, 0, 1),
            CATransform3DMakeRotation(0, 0, 0, 1),
            CATransform3DMakeRotation(CGFloat(-Double.pi/16), 0, 0, 1),
            CATransform3DMakeRotation(0, 0, 0, 1)]
        viewAniamtion.duration = 0.5
        viewAniamtion.repeatCount = MAXFLOAT
        viewAniamtion.delegate = self
        viewLayer.add(viewAniamtion, forKey: "viewAnimation")
    }
    
    func layerBezier() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = UIBezierPath(arcCenter: view.center, radius: CGFloat(50), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true).cgPath
        animation.duration = 3
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        let viewAnimation = CAKeyframeAnimation(keyPath: "position")
        viewAnimation.path = UIBezierPath(arcCenter: CGPoint(x: rightView.frame.width / 2, y: rightView.frame.height / 2), radius: CGFloat(50), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false).cgPath
        viewAnimation.duration = 3
        viewAnimation.delegate = self
        viewLayer.add(viewAnimation, forKey: "viewAnimation")
    }
    
    func layerKeyFrame() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.values = [
            CGPoint(x: layer.position.x, y: layer.position.y),
            CGPoint(x: layer.position.x, y: layer.position.y + 200),
            CGPoint(x: layer.position.x + 100, y: layer.position.y + 200),
            CGPoint(x: layer.position.x + 100, y: layer.position.y),
            CGPoint(x: layer.position.x, y: layer.position.y)]
        animation.keyTimes = [0.0, 0.2, 0.6, 0.9, 1.0]
        animation.duration = 4
        animation.delegate = self
        layer.add(animation, forKey: "animation")
        
        let viewAnimation = CAKeyframeAnimation(keyPath: "position")
        viewAnimation.values = [
            CGPoint(x: viewLayer.position.x, y: viewLayer.position.y),
            CGPoint(x: viewLayer.position.x, y: viewLayer.position.y + 200),
            CGPoint(x: viewLayer.position.x - 100, y: viewLayer.position.y + 200),
            CGPoint(x: viewLayer.position.x - 100, y: viewLayer.position.y),
            CGPoint(x: viewLayer.position.x, y: viewLayer.position.y)]
        viewAnimation.keyTimes = [0.0, 0.2, 0.6, 0.9, 1.0]
        viewAnimation.duration = 4
        viewAnimation.delegate = self
        viewLayer.add(viewAnimation, forKey: "viewAnimation")
    }
    
    func btnClicked(index: Int) {
        switch index {
        case 0:
            layerKeyFrame()
        case 1:
            layerBezier()
        case 2:
            layerShake()
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
