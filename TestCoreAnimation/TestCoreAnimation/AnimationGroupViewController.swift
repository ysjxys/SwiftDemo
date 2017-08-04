//
//  AnimationGroupViewController.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/7/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class AnimationGroupViewController: UIViewController, BottomBtnsViewDelegate {
    
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
        let bottomView = BottomBtnsView(titleArray: ["同时", "连续"])
        bottomView.delegate = self
        view.addSubview(bottomView)
    }
    
    func continuesTime() {
        let animationColor = CABasicAnimation()
        animationColor.keyPath = "backgroundColor"
        animationColor.fromValue = UIColor.purple.cgColor
        animationColor.toValue = UIColor.yellow.cgColor
        animationColor.duration = 2
        animationColor.beginTime = CACurrentMediaTime()
        layer.add(animationColor, forKey: "a")
        
        let animationPosition = CABasicAnimation()
        animationPosition.keyPath = "position"
        animationPosition.fromValue = layer.position
        animationPosition.toValue = CGPoint(x: layer.position.x + 100, y: layer.position.y + 100)
        animationPosition.duration = 2
        animationPosition.beginTime = CACurrentMediaTime() + 1
        layer.add(animationPosition, forKey: "b")
        
        let viewAnimationColor = CABasicAnimation()
        viewAnimationColor.keyPath = "backgroundColor"
        viewAnimationColor.fromValue = UIColor.purple.cgColor
        viewAnimationColor.toValue = UIColor.yellow.cgColor
        viewAnimationColor.duration = 2
        viewAnimationColor.beginTime = CACurrentMediaTime()
        viewLayer.add(viewAnimationColor, forKey: "a")
        
        let viewAnimationPosition = CABasicAnimation()
        viewAnimationPosition.keyPath = "position"
        viewAnimationPosition.fromValue = viewLayer.position
        viewAnimationPosition.toValue = CGPoint(x: viewLayer.position.x + 100, y: viewLayer.position.y + 100)
        viewAnimationPosition.duration = 2
        viewAnimationPosition.beginTime = CACurrentMediaTime() + 1
        viewLayer.add(viewAnimationPosition, forKey: "b")
    }
    
    func sameTime() {
        let animationColor = CABasicAnimation()
        animationColor.keyPath = "backgroundColor"
        animationColor.fromValue = UIColor.purple.cgColor
        animationColor.toValue = UIColor.yellow.cgColor
        animationColor.duration = 2
        
        let animationPosition = CABasicAnimation()
        animationPosition.keyPath = "position"
        animationPosition.fromValue = layer.position
        animationPosition.toValue = CGPoint(x: layer.position.x + 100, y: layer.position.y + 100)
        animationPosition.duration = 2
        animationPosition.beginTime = 1
//        animationPosition.beginTime = CACurrentMediaTime() + 1
        
        let viewAnimationPosition = CABasicAnimation()
        viewAnimationPosition.keyPath = "position"
        viewAnimationPosition.fromValue = viewLayer.position
        viewAnimationPosition.toValue = CGPoint(x: viewLayer.position.x + 100, y: viewLayer.position.y + 100)
        viewAnimationPosition.duration = 2
        
        let group = CAAnimationGroup()
        group.animations = [animationColor, animationPosition]
        group.duration = 3
        layer.add(group, forKey: "group")
        
        let viewGroup = CAAnimationGroup()
        viewGroup.animations = [animationColor, viewAnimationPosition]
        viewGroup.duration = 3
//        viewLayer.add(viewGroup, forKey: "viewGroup")
    }
    
    func btnClicked(index: Int) {
        print("\(index)")
        switch index {
        case 0:
            sameTime()
        case 1:
            continuesTime()
        default:
            print("none")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
