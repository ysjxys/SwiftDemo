//
//  TableViewVideoCell.swift
//  TestZFPlayer
//
//  Created by ysj on 2017/3/16.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class TableViewVideoCell: UITableViewCell {
    
    var cellModel: CellVideoModel? = nil
    
    var imgView = UIImageView()
    var playBtn = UIButton()
    var btnSelectClosure: ( (TableViewVideoCell) -> () )?
    
    
    static func cellView(tableView: UITableView, frame: CGRect, cellModel: CellVideoModel) -> TableViewVideoCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var videoCell: TableViewVideoCell
        
        if cell == nil {
            videoCell = TableViewVideoCell(style: .default, reuseIdentifier: "cell")
        }else{
            videoCell = cell as! TableViewVideoCell
        }
        videoCell.frame = frame
        videoCell.cellModel = cellModel
        videoCell.initView()
        return videoCell
    }
    
    func initView() {
        if imgView.superview == nil {
            imgView.isUserInteractionEnabled = true
            print("width:\(self.frame.width)   height:\(self.frame.height)")
            imgView.frame = CGRect(x: 50, y: 50, width: self.frame.width-50*2, height: self.frame.height-50)
            imgView.image = UIImage(named: "Photo_album_icon")
            self.addSubview(imgView)
        }
        
        if playBtn.superview == nil {
            playBtn.frame = CGRect(x: (imgView.frame.width-100)/2, y: (imgView.frame.height-50)/2, width: 100, height: 50)
            playBtn.addTarget(self, action: #selector(playBtnSelect), for: .touchUpInside)
            playBtn.setImage(UIImage(named: "play_button_icon"), for: .normal)
            imgView.addSubview(playBtn)
        }
    }
    
    func playBtnSelect() {
        print("btn select")
        guard (btnSelectClosure != nil) else {
            return
        }
        btnSelectClosure!(self)
    }
    
}
