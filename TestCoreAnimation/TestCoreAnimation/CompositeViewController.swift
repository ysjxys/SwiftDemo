//
//  CompositeViewController.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/8/16.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class CompositeViewController: UIViewController {
    
    let btnWidth = CGFloat(40)
    let sumBtn = UIButton()
    let maskView = UIView()
    let childBtnClickDuration: CFTimeInterval = 0.3
    let sumBtnClickDuration: CFTimeInterval = 0.3
    
    var btnArray: [UIButton] = []
    
    var isExpand = false
    
    // MARK: - init Method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        maskView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        maskView.alpha = 0
        maskView.backgroundColor = UIColor.black
        maskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap(tap:))))
        view.addSubview(maskView)
        
        //总控制btn
        sumBtn.frame = CGRect(x: 200, y: 400, width: btnWidth, height: btnWidth)
        sumBtn.setBackgroundImage(#imageLiteral(resourceName: "icon_add"), for: .normal)
        sumBtn.setBackgroundImage(#imageLiteral(resourceName: "icon_add"), for: .highlighted)
        sumBtn.backgroundColor = UIColor.clear
        sumBtn.layer.cornerRadius = btnWidth / 2
        sumBtn.clipsToBounds = true
        sumBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(sumBtn)
        
        let imageArr = [#imageLiteral(resourceName: "icon_annou_un"), #imageLiteral(resourceName: "icon-eleme"), #imageLiteral(resourceName: "icon-meituan"), #imageLiteral(resourceName: "icon-refresh")]
        for index in 0..<imageArr.count {
            let btn = createBtn(image: imageArr[index])
            btn.tag = index + 10
            btnArray.append(btn)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("CompositeViewController deinit")
    }
    
    // MARK: - 按下父按钮后，父按钮与子按钮分别的动画
    func btnClick() {
        sumBtn.isEnabled = false
        
        let sumBtnRotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        sumBtnRotateAnimation.duration = sumBtnClickDuration
        sumBtnRotateAnimation.fillMode = kCAFillModeBoth
        sumBtnRotateAnimation.isRemovedOnCompletion = false
        
        for index in 0..<btnArray.count {
            addChildrenBtnAnimation(index: index)
        }
        
        if isExpand {
            UIView.animate(withDuration: sumBtnClickDuration, animations: {
                self.maskView.alpha = 0
            })
            sumBtnRotateAnimation.fromValue = Double.pi / 4
            sumBtnRotateAnimation.toValue = 0
        } else {
            UIView.animate(withDuration: sumBtnClickDuration, animations: {
                self.maskView.alpha = 0.4
            })
            sumBtnRotateAnimation.fromValue = 0
            sumBtnRotateAnimation.toValue = Double.pi / 4
        }
        
        sumBtn.layer.add(sumBtnRotateAnimation, forKey: "sumBtnRotateAnimation")
        
        isExpand = !isExpand
        sumBtn.isEnabled = true
    }
    
    // MARK: - 点击页面，判断是否在子按钮内，按情况进入不同动画
    func addChildrenBtnAnimation(index: Int) {
        let yDistance = CGFloat(70)
        let originX = sumBtn.frame.origin.x
        let originY = sumBtn.frame.origin.y
        
        let btnOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        btnOpacityAnimation.fromValue = 1
        btnOpacityAnimation.toValue = 1
        btnOpacityAnimation.duration = 0.1
        btnOpacityAnimation.isRemovedOnCompletion = false
        btnOpacityAnimation.fillMode = kCAFillModeBoth
        
        let btnRotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        btnRotateAnimation.duration = sumBtnClickDuration
//        btnRotateAnimation.isRemovedOnCompletion = false
//        btnRotateAnimation.fillMode = kCAFillModeBoth
        
        let btnPositionAnimation = CABasicAnimation(keyPath: "position")
        btnPositionAnimation.duration = sumBtnClickDuration
        btnPositionAnimation.isRemovedOnCompletion = false
        btnPositionAnimation.fillMode = kCAFillModeBoth
        
        let btnScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        btnScaleAnimation.duration = sumBtnClickDuration
        btnScaleAnimation.isRemovedOnCompletion = false
        btnScaleAnimation.fillMode = kCAFillModeBoth
        
        if isExpand {
            btnRotateAnimation.fromValue = 0
            btnRotateAnimation.toValue = Double.pi * -2
            
            btnPositionAnimation.fromValue = CGPoint(x: originX + btnWidth / 2, y: originY + btnWidth / 2 - yDistance * CGFloat(index + 1))
            btnPositionAnimation.toValue = CGPoint(x: originX + btnWidth / 2, y: originY + btnWidth / 2)
            
            btnScaleAnimation.fromValue = 1
            btnScaleAnimation.toValue = 0.3
        } else {
            btnRotateAnimation.fromValue = 0
            btnRotateAnimation.toValue = Double.pi * 2
            
            btnPositionAnimation.fromValue = CGPoint(x: originX + btnWidth / 2, y: originY + btnWidth / 2)
            btnPositionAnimation.toValue = CGPoint(x: originX + btnWidth / 2, y: originY + btnWidth / 2 - yDistance * CGFloat(index + 1))
            
            btnScaleAnimation.fromValue = 0.3
            btnScaleAnimation.toValue = 1
        }
        
        let group = CAAnimationGroup()
        group.animations = [btnOpacityAnimation, btnRotateAnimation, btnPositionAnimation, btnScaleAnimation]
        group.duration = sumBtnClickDuration
        group.fillMode = kCAFillModeBoth
        group.isRemovedOnCompletion = false
        btnArray[index].layer.add(group, forKey: "group")
    }
    
    func viewTap(tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        var isInSubviews = false
        for view in view.subviews {
            if view == maskView {
                continue
            }
            if view.tag == 0 {
                continue
            }
            if ((view.layer.presentation()?.hitTest(point)) != nil) {
                if view.tag - 10 >= btnArray.count && view.tag - 10 < 0 {
                    continue
                }
                if let btn = view as? UIButton {
                    isInSubviews = true
                    childBtnClick(btn: btn)
                }
                break
            }
        }
        if !isInSubviews {
            btnClick()
        }
    }
    
    // MARK: - 按下子按钮后动画
    func childBtnClick(btn: UIButton) {
        let selectScaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        selectScaleAnimation.values = [1, 2.5, 1]
        selectScaleAnimation.keyTimes = [0.0, 0.5, 1.0]
        selectScaleAnimation.duration = childBtnClickDuration
        selectScaleAnimation.isRemovedOnCompletion = false
        selectScaleAnimation.fillMode = kCAFillModeBoth
        
        let selectOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        selectOpacityAnimation.fromValue = 1
        selectOpacityAnimation.toValue = 0.3
        selectOpacityAnimation.duration = childBtnClickDuration
        selectOpacityAnimation.isRemovedOnCompletion = false
        selectOpacityAnimation.fillMode = kCAFillModeBoth
        
        let selectGroup = CAAnimationGroup()
        selectGroup.animations = [selectScaleAnimation, selectOpacityAnimation]
        selectGroup.duration = childBtnClickDuration
        selectGroup.isRemovedOnCompletion = false
        selectGroup.fillMode = kCAFillModeBoth
        
        btn.layer.add(selectGroup, forKey: "selectGroup")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + childBtnClickDuration) {
            self.btnClick()
        }
        
    }
    
    // MARK: - 创建子按钮
    func createBtn(image: UIImage) -> UIButton {
        let btn = UIButton()
        btn.frame.size = CGSize(width: btnWidth * 0.7, height: btnWidth * 0.7)
        btn.center = sumBtn.center
        btn.setBackgroundImage(image, for: .normal)
        btn.setBackgroundImage(image, for: .highlighted)
        btn.layer.cornerRadius = btn.frame.size.width / 2
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(childBtnClick(btn:)), for: .touchUpInside)
        view.insertSubview(btn, belowSubview: sumBtn)
        return btn
    }
}
