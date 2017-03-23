//
//  DetailViewController.swift
//  TestHero
//
//  Created by ysj on 2017/3/13.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import Hero

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let btn = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 50))
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
        
        isHeroEnabled = true
        
        let redView2 = UIView(frame: CGRect(x: 200, y: 200, width: view.frame.width/2, height: view.frame.height/2))
        redView2.backgroundColor = UIColor.purple
        view.addSubview(redView2)
        
        redView2.heroID = "redView"
//        redView2.heroModifiers = [.rotate(0.5), .scale(0.5), .cornerRadius(5)]
    }
    
    func btnClick() {
        navigationController?.hero_dismissViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
