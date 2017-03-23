//
//  ViewController.swift
//  TestPOP
//
//  Created by ysj on 2017/3/8.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import pop

class ViewController: UIViewController {
    
    var rect = UIView()
    var shapeLayer = CAShapeLayer()
    var percentLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: (view.frame.width-100)/2, y: 500, width: 100, height: 50))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.black
        btn.setTitle("变形", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
        
        
        rect.frame = CGRect(x: (view.frame.width-250)/2, y: 100, width: 250, height: 250)
        rect.backgroundColor = UIColor.white
        rect.layer.borderWidth = 2
        rect.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(rect)
        
        
        let path = UIBezierPath(roundedRect: CGRect(x: rect.frame.width/4, y: rect.frame.width/4, width: 125, height: 125), cornerRadius: rect.frame.width/2)
        
        let bgShapeLayer = CAShapeLayer()
        bgShapeLayer.path = path.cgPath
        bgShapeLayer.lineWidth = 1
        bgShapeLayer.fillColor = nil
        bgShapeLayer.strokeColor = UIColor.lightGray.cgColor
        rect.layer.addSublayer(bgShapeLayer)
        
        
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 4
        shapeLayer.strokeEnd = 0
        
        shapeLayer.backgroundColor = UIColor.red.cgColor
        shapeLayer.borderColor = UIColor.green.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor//填充色
        shapeLayer.strokeColor = UIColor.purple.cgColor//边框色
        shapeLayer.shadowColor = UIColor.blue.cgColor
        
        rect.layer.addSublayer(shapeLayer)
        
        
        percentLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        percentLabel.center = CGPoint(x: rect.frame.width/2, y: rect.frame.height/2)
        percentLabel.text = "0%"
        percentLabel.backgroundColor = UIColor.lightGray
        percentLabel.textAlignment = .center
        percentLabel.textColor = UIColor.black
        percentLabel.font = UIFont.systemFont(ofSize: 20)
        rect.addSubview(percentLabel)
    }
    
    func changeText(label: UILabel, duration: CFTimeInterval, toValue: CGFloat) {
        let popText = POPBasicAnimation()
        popText.duration = duration
        
        let property = POPAnimatableProperty.property(withName: "4") { (prop) in
            prop?.threshold = 0.01
            prop?.writeBlock = {(obj, values) in
                if let values = values {
                    let lb = obj as! UILabel
                    lb.text = "\(String(format: "%.2f", values[0]*100))%"
                }
                
            }
        }
        popText.property = property as! POPAnimatableProperty!
        popText.fromValue = 0
        popText.toValue = toValue
        label.pop_add(popText, forKey: "5")
    }
    
    func changeCircleStrokeEnd(layer: CAShapeLayer, strokeEnd: CGFloat, duration: CFTimeInterval, completeClosure: ((POPAnimation?, Bool) -> ())? ) {
        let stroke = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeEnd)
        //NSNumber(value: Double(strokeEnd))
        stroke?.toValue = strokeEnd
        stroke?.duration = duration
        stroke?.completionBlock = completeClosure
        layer.pop_add(stroke, forKey: "1")
    }
    
    func changeCenter(view: UIView, duration: CFTimeInterval, endPoint: CGPoint, completeClosure: ((POPAnimation?, Bool) -> ())? ) {
        let popMove = POPBasicAnimation(propertyNamed: kPOPViewCenter)
        popMove?.duration = duration
        popMove?.toValue = endPoint
        popMove?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        popMove?.completionBlock = completeClosure
        view.pop_add(popMove, forKey: "3")
    }
    
    func changeScale(view: UIView, duration: CFTimeInterval, scale: Double, completeClosure: ((POPAnimation?, Bool) -> ())? ) {
        let popScale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        popScale?.springSpeed = 12
        popScale?.springBounciness = 10
        popScale?.toValue = NSValue(cgSize: CGSize(width: scale, height: scale))
        popScale?.completionBlock = completeClosure
        view.pop_add(popScale, forKey: "2")
    }
    
    func changeRotate(view: UIView, duration: CFTimeInterval, rotation: Double, completeClosure: ((POPAnimation?, Bool) -> ())? ) {
        let rotate = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        rotate?.duration = duration
        rotate?.toValue = rotation
        view.layer.pop_add(rotate, forKey: "5")
    }
    
    
    func btnClick() {
        //POPDecayAnimation 衰减动画，没有toValue，只有fromValue

        changeText(label: percentLabel, duration: 1, toValue: 1)
        
        
        changeCircleStrokeEnd(layer:shapeLayer, strokeEnd: 1, duration: 1) { (POPAnimation1, isFinish1) in
            
            
            self.changeScale(view: self.rect, duration: 0.5, scale: 0.2) { (POPAnimation2, isFinish2) in
                
                self.changeRotate(view: self.rect, duration: 1, rotation: M_PI*2, completeClosure: nil)
                
                self.changeCenter(view: self.rect, duration: 1, endPoint: CGPoint(x: self.view.frame.width-50, y: 80), completeClosure: {(POPAnimation3, isFinish3) in
                    
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

