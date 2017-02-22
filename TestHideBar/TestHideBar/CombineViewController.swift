//
//  CombineViewController.swift
//  TestHideBar
//
//  Created by ysj on 2017/2/6.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class CombineViewController: YSJViewController {
    
    @IBOutlet weak var statusBarHideSegVC1: UISegmentedControl!
    @IBOutlet weak var statusBarHideSegVC2: UISegmentedControl!
    @IBOutlet weak var statusBarStyleSegVC1: UISegmentedControl!
    @IBOutlet weak var statusBarStyleSegVC2: UISegmentedControl!
    @IBOutlet weak var statusBarAnimatedSeg: UISegmentedControl!
    @IBOutlet weak var navBarHideSegVC1: UISegmentedControl!
    @IBOutlet weak var navBarHideSegVC2: UISegmentedControl!
    @IBOutlet weak var navBarAnimatedSeg: UISegmentedControl!
    @IBOutlet weak var tabBarHideSegVC1: UISegmentedControl!
    @IBOutlet weak var tabBarHideSegVC2: UISegmentedControl!
    @IBOutlet weak var tabBarAnimatedSeg: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "进入VC1", style: .plain, target: self, action: #selector(rightBtnBarClick))
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//    }
    
//    override func updateBars() {
//        UIApplication.shared.setStatusBarStyle(.default, animated: true)
//        UIApplication.shared.setStatusBarHidden(false, with: .slide)
//        
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        
//        guard (tabBarController != nil) else {
//            return
//        }
//        UIView.animate(withDuration: 0.4) {
//            self.tabBarController?.tabBar.alpha = 1
//        }
//    }
    
    func rightBtnBarClick(){
        let vc1 = CombineVC1()
        
        let isStatusBarHideVC1 = statusBarHideSegVC1.selectedSegmentIndex == 0 ? true : false
        let isStatusBarHideVC2 = statusBarHideSegVC2.selectedSegmentIndex == 0 ? true : false
        
        
        var statusBarAnimation: UIStatusBarAnimation = .none
        
        switch statusBarAnimatedSeg.selectedSegmentIndex {
            case 0:
                statusBarAnimation = .slide
            case 1:
                statusBarAnimation = .fade
            case 2:
                statusBarAnimation = .none
            default: break
        }
        
        let statusBarStyleVC1: UIStatusBarStyle = statusBarStyleSegVC1.selectedSegmentIndex == 0 ? .default : .lightContent
        let statusBarStyleVC2: UIStatusBarStyle = statusBarStyleSegVC2.selectedSegmentIndex == 0 ? .default : .lightContent
        
        
        let isNavigationBarHideVC1 = navBarHideSegVC1.selectedSegmentIndex == 0 ? true : false
        let isNavigationBarHideVC2 = navBarHideSegVC2.selectedSegmentIndex == 0 ? true : false
        let isNavigationBarAnimated = navBarAnimatedSeg.selectedSegmentIndex == 0 ? true : false
        print("isNavigationBarAnimated:\(isNavigationBarAnimated)")
        
        let isTabBarHideVC1 = tabBarHideSegVC1.selectedSegmentIndex == 0 ? true : false
        let isTabBarHideVC2 = tabBarHideSegVC2.selectedSegmentIndex == 0 ? true : false
        let tabBarAnimateDuration = tabBarAnimatedSeg.selectedSegmentIndex == 0 ? 0.35 : 0
        
        vc1.barState = BarState(isStatusBarHide: isStatusBarHideVC1, statusBarAnimation: statusBarAnimation, statusBarStyle: statusBarStyleVC1, isNavigationBarHide: isNavigationBarHideVC1, isNavigationBarAnimated: isNavigationBarAnimated, isTabBarHide: isTabBarHideVC1, tabBarAnimateDuration: tabBarAnimateDuration)
        print(vc1.barState)
        vc1.nextBarState = BarState(isStatusBarHide: isStatusBarHideVC2, statusBarAnimation: statusBarAnimation, statusBarStyle: statusBarStyleVC2, isNavigationBarHide: isNavigationBarHideVC2, isNavigationBarAnimated: isNavigationBarAnimated, isTabBarHide: isTabBarHideVC2, tabBarAnimateDuration: tabBarAnimateDuration)
        
        navigationController?.pushViewController(vc1, animated: true)
    }
    
    func popBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
}
