//
//  YSJViewController.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/19.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
struct BarState {
    var isStatusBarHide: Bool = false
    var statusBarAnimation: UIStatusBarAnimation = .slide
    var statusBarStyle: UIStatusBarStyle = .default
    
    var isNavigationBarHide: Bool = false
    var isNavigationBarAnimated: Bool = true
    
    var isTabBarHide: Bool = false
    var tabBarAnimateDuration: TimeInterval = 0.35
    
    init() {
        isStatusBarHide = false
        statusBarAnimation = .none
        statusBarStyle = .default
        isNavigationBarHide = false
        isNavigationBarAnimated = true
        isTabBarHide = false
        tabBarAnimateDuration = 0.35
    }
    
    init(isStatusBarHide: Bool, statusBarAnimation: UIStatusBarAnimation, statusBarStyle: UIStatusBarStyle, isNavigationBarHide: Bool, isNavigationBarAnimated: Bool, isTabBarHide: Bool, tabBarAnimateDuration: TimeInterval) {
        self.isStatusBarHide = isStatusBarHide
        self.statusBarAnimation = statusBarAnimation
        self.statusBarStyle = statusBarStyle
        self.isNavigationBarHide = isNavigationBarHide
        self.isNavigationBarAnimated = isNavigationBarAnimated
        self.isTabBarHide = isTabBarHide
        self.tabBarAnimateDuration = tabBarAnimateDuration
    }
}

class YSJViewController: UIViewController {
    var barState = BarState()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print(barState)
        UIApplication.shared.setStatusBarStyle(barState.statusBarStyle, animated: barState.statusBarAnimation == .none ? false : true)
        UIApplication.shared.setStatusBarHidden(barState.isStatusBarHide, with: barState.statusBarAnimation)
        
        navigationController?.setNavigationBarHidden(barState.isNavigationBarHide, animated: barState.isNavigationBarAnimated)
        
//        UIView.animate(withDuration: 0.35) { 
//            self.navigationController?.navigationBar.alpha = self.barState.isNavigationBarHide == true ? 0 : 1
//        }
        
        guard (tabBarController != nil) else {
            return
        }
        UIView.animate(withDuration: barState.tabBarAnimateDuration) {
            self.tabBarController?.tabBar.alpha = self.barState.isTabBarHide == true ? 0 : 1
        }
        
//        updateBars()
    }
    
    func updateBars() {
        
    }
    
    //基于VC控制statusBar状态的相关方法
    var isStatusBarHidden: Bool = false
    var statusBarAnimation: UIStatusBarAnimation = .fade
    
    override var prefersStatusBarHidden: Bool{
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return statusBarAnimation
    }
    
    func changeStatusBarState(isHidden: Bool) {
        guard (navigationController != nil) else {
            print("---------  changeStatusBarState  --------- : navigationController is nil")
            return
        }
        
        changeStatusBarState(style: navigationController!.preferredStatusBarStyle, isHidden: isHidden, animation:preferredStatusBarUpdateAnimation)
    }

    func changeStatusBarState(style: UIStatusBarStyle) {
        changeStatusBarState(style: style, isHidden: self.prefersStatusBarHidden, animation: self.preferredStatusBarUpdateAnimation)
    }
    
    func changeStatusBarState(style: UIStatusBarStyle, isHidden: Bool, animation: UIStatusBarAnimation) {
        changeStatusBarState(style: style, isHidden: isHidden, animation: animation, duration: 0.3)
    }
    
    func changeStatusBarState(style: UIStatusBarStyle, isHidden: Bool, animation: UIStatusBarAnimation, duration: Double) {
        guard (navigationController != nil) else {
            print("---------  changeStatusBarState  --------- : navigationController is nil")
            return
        }
        if navigationController is YSJNavigationController {
            (navigationController as! YSJNavigationController).statusBarStyle = style
        }
        
        statusBarAnimation = animation
        isStatusBarHidden = isHidden
        UIView.animate(withDuration: duration) {
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
