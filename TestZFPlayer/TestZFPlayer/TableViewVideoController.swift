//
//  TableViewVideoController.swift
//  TestZFPlayer
//
//  Created by ysj on 2017/3/16.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import ZFPlayer

class TableViewVideoController:  UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView = UITableView()
    var playerView = ZFPlayerView()
    var controlView = ZFPlayerControlView()
    
    
    
    var dataArr: [CellVideoModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initView()
    }
    
    func initData() {
        let oriDataArr = [
            ["title": "标题1", "url": "http://baobab.wdjcdn.com/1456665467509qingshu.mp4"],
            ["title": "标题2", "url": "http://baobab.wdjcdn.com/14571455324031.mp4"],
            ["title": "标题3", "url": "http://baobab.wdjcdn.com/14559682994064.mp4"],
            ["title": "标题4", "url": "http://baobab.wdjcdn.com/1458625865688ONE.mp4"],
            ["title": "标题5", "url": "http://mw5.dwstatic.com/2/4/1529/134981-99-1436844583.mp4"]]
        
        for item in oriDataArr {
            dataArr.append(CellVideoModel(title: item["title"]!, url: item["url"]!))
        }
    }
    
    func initView() {
//        controlView
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoModel = dataArr[indexPath.row]
        
        let cell = TableViewVideoCell.cellView(tableView: tableView, frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200), cellModel: videoModel)
        
        weak var weakSelf = self
        weak var weakCell = cell
        cell.btnSelectClosure = {(cell) in
            let playerModel = ZFPlayerModel()
            playerModel.fatherView = weakCell?.imgView
            playerModel.tableView = weakSelf?.tableView
            playerModel.indexPath = indexPath
            playerModel.title = videoModel.title
            playerModel.videoURL = URL(string: videoModel.url)
            weakSelf?.playerView.playerControlView(weakSelf?.controlView, playerModel: playerModel)
            weakSelf?.playerView.autoPlayTheVideo()
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
