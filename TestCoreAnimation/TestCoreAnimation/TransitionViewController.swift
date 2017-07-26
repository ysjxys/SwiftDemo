//
//  TransitionViewController.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/7/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class TransitionViewController: UIViewController, BottomBtnsViewDelegate {
    
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
        let bottomView = BottomBtnsView(titleArray: ["fade", "moveIn", "push", "reveal"])
        bottomView.delegate = self
        view.addSubview(bottomView)
    }
    
    func layerReveal() {
        layer.backgroundColor = layer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let reveal = CATransition()
        reveal.type = kCATransitionReveal
        reveal.subtype = kCATransitionFromRight
        reveal.duration = 1.5
        layer.add(reveal, forKey: "reveal")
        
        viewLayer.backgroundColor = viewLayer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let viewReveal = CATransition()
        viewReveal.type = kCATransitionReveal
        viewReveal.subtype = kCATransitionFromRight
        viewReveal.duration = 1.5
        viewLayer.add(viewReveal, forKey: "reveal")
    }
    
    func layerPush() {
        layer.backgroundColor = layer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let push = CATransition()
        push.type = kCATransitionPush
        push.subtype = kCATransitionFromBottom
        push.duration = 1.5
        layer.add(push, forKey: "push")
        
        viewLayer.backgroundColor = viewLayer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let viewPush = CATransition()
        viewPush.type = kCATransitionPush
        viewPush.subtype = kCATransitionFromBottom
        viewPush.duration = 1.5
        viewLayer.add(viewPush, forKey: "push")
    }
    
    func layerMoveIn() {
        layer.backgroundColor = layer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let moveIn = CATransition()
        moveIn.type = kCATransitionMoveIn
        moveIn.subtype = kCATransitionFromLeft
        moveIn.duration = 1.5
        layer.add(moveIn, forKey: "moveIn")
        
        viewLayer.backgroundColor = viewLayer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let viewMoveIn = CATransition()
        viewMoveIn.type = kCATransitionMoveIn
        viewMoveIn.subtype = kCATransitionFromLeft
        viewMoveIn.duration = 1.5
        viewLayer.add(viewMoveIn, forKey: "moveIn")
    }
    
    func layerFade() {
        layer.backgroundColor = layer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let fade = CATransition()
        fade.type = kCATransitionFade
        fade.subtype = kCATransitionFromTop
        fade.duration = 1.5
        layer.add(fade, forKey: "fade")
        
        viewLayer.backgroundColor = viewLayer.backgroundColor == UIColor.red.cgColor ? UIColor.purple.cgColor : UIColor.red.cgColor
        
        let viewFade = CATransition()
        viewFade.type = kCATransitionFade
        viewFade.subtype = kCATransitionFromTop
        viewFade.duration = 1.5
        viewLayer.add(viewFade, forKey: "fade")
    }
    
    func btnClicked(index: Int) {
        print("\(index)")
        switch index {
        case 0:
            layerFade()
        case 1:
            layerMoveIn()
        case 2:
            layerPush()
        case 3:
            layerReveal()
        default:
            print("none")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
