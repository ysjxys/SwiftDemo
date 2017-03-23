//
//  HomePageViewController.swift
//  TestHero
//
//  Created by ysj on 2017/3/13.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import Hero

class HomePageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "push", style: .plain, target: self, action: #selector(rightBarBtnClick))
        
        
        let redView = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        
        tabBarController?.isHeroEnabled = true
        navigationController?.isHeroEnabled = true
        isHeroEnabled = true
        redView.heroID = "redView"
    }
    
    func rightBarBtnClick() {
        print("rightBarBtnClick")
        tabBarController?.heroTabBarAnimationType = .zoom
        navigationController?.heroNavigationAnimationType = .cover(direction: .up)
        
//        navigationController?.hero_replaceViewController(with: DetailViewController())
        
//        navigationController?.hero_presentOnTop(viewController: DetailViewController(), frame: CGRect(x: 100, y: 100, width: view.frame.width/2, height: view.frame.height/2))
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
