//
//  ViewController.swift
//  TestComplexEasyAnimation
//
//  Created by ysj on 2017/6/26.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import EasyAnimation

class ViewController: UIViewController {
    
    let label2 = UILabel()
    let leftView = UIView()
    let rightView = UIView()
    
//    let label = UILabel()
    
    let width = CGFloat(50)
    let xOrigin = CGFloat(50)
    
    
    var animationChain: EAAnimationFuture?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        EasyAnimation.enable()
        
        leftView.frame = CGRect(x: xOrigin, y: 100, width: width, height: 50)
        leftView.backgroundColor = UIColor.purple
        view.addSubview(leftView)
        
        let leftCircleLayer = CAShapeLayer()
        leftCircleLayer.path = UIBezierPath(ovalIn: leftView.bounds).cgPath
        leftCircleLayer.fillColor = UIColor.clear.cgColor
        leftCircleLayer.strokeColor = UIColor.red.cgColor
        leftCircleLayer.lineWidth = 5
        
        let leftMaskLayer = CAShapeLayer()
        leftMaskLayer.path = leftCircleLayer.path
        
        leftView.layer.mask = leftMaskLayer
        leftView.layer.addSublayer(leftCircleLayer)
        
        
        
        rightView.frame = CGRect(x: view.frame.width - xOrigin - width, y: 100, width: width, height: 50)
        rightView.backgroundColor = UIColor.purple
        view.addSubview(rightView)
        
        let rightCircleLayer = CAShapeLayer()
        rightCircleLayer.path = UIBezierPath(ovalIn: rightView.bounds).cgPath
        rightCircleLayer.fillColor = UIColor.clear.cgColor
        rightCircleLayer.strokeColor = UIColor.red.cgColor
        rightCircleLayer.lineWidth = 5
        
        let rightMaskLayer = CAShapeLayer()
        rightMaskLayer.path = rightCircleLayer.path
        
        rightView.layer.mask = rightMaskLayer
        rightView.layer.addSublayer(rightCircleLayer)
        
        
        label2.frame = CGRect(x: 300, y: 50, width: leftView.frame.width, height: 100)
        label2.text = "hehe"
        label2.textColor = UIColor.black
        label2.backgroundColor = UIColor.lightGray
//        view.addSubview(label2)
        
        
        
        
        
        
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
//        //平移
//        animationChain = UIView.animateAndChain(withDuration: 3, delay: 0, options: [], animations: {
//            self.leftView.layer.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
//        }, completion: nil).animate(withDuration: 3) { 
//            self.leftView.layer.frame = CGRect(x: 50, y: 100, width: self.view.frame.width - 50 * 2, height: 50)
//        }
//        
//        
////        旋转
//        UIView.animateAndChain(withDuration: 0.3, delay: 0, options: [], animations: {
//            self.leftView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi/8), 0, 0, 1)
//        }, completion: nil).animateAndChain(withDuration: 0.3, delay: 0, options: [.repeat], animations: {
//            self.leftView.layer.transform = CATransform3DMakeRotation(CGFloat(-Double.pi/8), 0, 0, 1)
//        }, completion: nil)
//        
//        
//        
////        关键帧动画， UILabel与UIView无效？
//        UIView.animateKeyframes(withDuration: 6, delay: 0, options: [.calculationModeLinear], animations: {
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.333, animations: {
//                self.leftView.layer.frame = CGRect(x: 50, y: 100, width: 100, height: 50)
//                self.leftView.layer.backgroundColor = UIColor.red.cgColor
//            })
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.333, relativeDuration: 0.333, animations: {
//                self.leftView.layer.backgroundColor = UIColor.yellow.cgColor
//            })
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.666, relativeDuration: 0.333, animations: {
////                self.label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/8))
//                self.leftView.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi/8), 0, 0, 1)
//                self.leftView.layer.backgroundColor = UIColor.lightGray.cgColor
//            })
//            
//        }, completion: nil)
        
        let leftMaskLayer = self.leftView.layer.mask as? CAShapeLayer
        let leftSubLayer = self.leftView.layer.sublayers?.first as? CAShapeLayer
        
        let rightMaskLayer = self.rightView.layer.mask as? CAShapeLayer
        let rightSubLayer = self.rightView.layer.sublayers?.first as? CAShapeLayer
        
        //连续动画
        UIView.animateAndChain(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            
            self.leftView.layer.frame.origin.x = self.view.frame.width/2-self.width
            self.rightView.layer.frame.origin.x = self.view.frame.width/2
            
        }, completion: nil).animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
            
            leftMaskLayer?.path = UIBezierPath(ovalIn: CGRect(x: 10, y: 0, width: self.leftView.frame.width-10, height: self.leftView.frame.height)).cgPath
            leftSubLayer?.path = leftMaskLayer?.path
            
            rightMaskLayer?.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.leftView.frame.width-10, height: self.leftView.frame.height)).cgPath
            rightSubLayer?.path = rightMaskLayer?.path
            
        }, completion: nil).animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .repeat], animations: {
            
            self.leftView.layer.frame.origin.x = self.xOrigin
            leftMaskLayer?.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.leftView.frame.width, height: self.leftView.frame.height)).cgPath
            leftSubLayer?.path = leftMaskLayer?.path
            
            self.rightView.layer.frame.origin.x = self.view.frame.width - self.xOrigin - self.width
            rightMaskLayer?.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.rightView.frame.width, height: self.rightView.frame.height)).cgPath
            rightSubLayer?.path = rightMaskLayer?.path
            
        }, completion: { (_) in
            
            leftSubLayer?.path = UIBezierPath(ovalIn: self.leftView.bounds).cgPath
            leftMaskLayer?.path = leftSubLayer?.path
            
            rightSubLayer?.path = UIBezierPath(ovalIn: self.rightView.bounds).cgPath
            rightMaskLayer?.path = rightSubLayer?.path
        })
    }
    
    func cancelBtnClick() {
//        label.layer.removeAllAnimations()
        animationChain?.cancelAnimationChain({
            self.leftView.layer.frame = CGRect(x: 50, y: 100, width: self.view.frame.width - 50 * 2, height: 50)
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

