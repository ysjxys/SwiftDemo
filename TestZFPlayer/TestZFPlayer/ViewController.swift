//
//  ViewController.swift
//  TestZFPlayer
//
//  Created by ysj on 2017/2/7.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import ZFPlayer
import Masonry
import SnapKit

class ViewController: UIViewController, ZFPlayerDelegate {
    
    let playerView = ZFPlayerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "视频", style: .plain, target: self, action: #selector(rightBarBtnClicked))
        
        
//        view.addSubview(playerView)
//        
//        playerView.snp.makeConstraints { (make) in
//            make.top.equalTo(view).offset(20)
//            make.left.equalTo(view.snp.left).multipliedBy(1).offset(0)
//            make.width.equalTo(view)
//            make.height.equalTo(view.snp.width)
//        }
        playerView.delegate = self
        
        
        let controllerView = ZFPlayerControlView()
        
        
        let playerModel = ZFPlayerModel()
        playerModel.videoURL = URL(string: "http://mw5.dwstatic.com/2/4/1529/134981-99-1436844583.mp4")
        playerModel.title = "wo shi shi"
        
        let fatherView = UIView()
        view.addSubview(fatherView)
        fatherView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.equalTo(view.snp.left).multipliedBy(1).offset(0)
            make.width.equalTo(view)
            make.height.equalTo(view.snp.width)
        }
        playerModel.fatherView = fatherView
        
        
        playerView.playerControlView(controllerView, playerModel: playerModel)
    }
    
    func rightBarBtnClicked() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

