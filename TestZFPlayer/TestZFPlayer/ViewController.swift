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
    let fatherView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        print(filePath)
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "播放/暂停", style: .plain, target: self, action: #selector(leftBarBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "换一个", style: .plain, target: self, action: #selector(rightBarBtnClicked))
        
        
        let playerModel = ZFPlayerModel()
        playerModel.videoURL = URL(string: "http://mw5.dwstatic.com/2/4/1529/134981-99-1436844583.mp4")
        playerModel.title = "wo shi shi"
        playerModel.placeholderImage = UIImage(named: "发动态(拍摄）_PxCook.png")
        
        view.addSubview(fatherView)
        fatherView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view.snp.left).multipliedBy(1).offset(0)
            make.width.equalTo(view)
            make.height.equalTo(view.snp.width)
        }
        playerModel.fatherView = fatherView
        
        let controllerView = ZFPlayerControlView()
        playerView.delegate = self
        playerView.playerControlView(controllerView, playerModel: playerModel)
        playerView.hasDownload = true
    }
    
    func zf_playerBackAction() {
        print("back action select")
    }
    
    func zf_playerDownload(_ url: String!) {
        print("download url: \(url)")
        let videoName = NSURL(string: url)?.lastPathComponent
        print("videoName: \(videoName)")
    }
    
    func rightBarBtnClicked() {
        let playModel = ZFPlayerModel()
        playModel.title = "新的视频"
        playModel.videoURL = URL(string: "http://baobab.wdjcdn.com/1456665467509qingshu.mp4")
        playModel.fatherView = fatherView
        playerView.reset(toPlayNewVideo: playModel)
    }
    
    func leftBarBtnClick(){
        print(playerView.state)
        if playerView.state == .playing {
            playerView.pause()
        }else{
            playerView.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

