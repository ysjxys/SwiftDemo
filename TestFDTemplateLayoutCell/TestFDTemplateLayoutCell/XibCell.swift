//
//  XibCell.swift
//  TestFDTemplateLayoutCell
//
//  Created by ysj on 2017/5/9.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class XibCell: UITableViewCell {
    var model: TestModel?
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
//        let contentViewWidth = UIScreen.main.bounds.width
//        let constraint = NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: contentViewWidth)
//        
//        contentView.addConstraint(constraint)
    }
    
    func setData(model: TestModel) {
        self.model = model
        contentLabel.text = model.name
    }
    
}

