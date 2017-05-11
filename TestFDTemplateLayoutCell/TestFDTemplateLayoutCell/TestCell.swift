//
//  TestCell.swift
//  TestFDTemplateLayoutCell
//
//  Created by ysj on 2017/5/8.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TestCell: UITableViewCell {
    
    var model: TestModel = TestModel() {
        didSet {
            headView.image = model.image
            nameLabel.text = model.name
            contextLabel.text = model.content
            
//            nameLabelHeightConstraint?.update(offset: caculateSize(string: nameLabel.text ?? "").height)
//            contextLabelHeightConstraint?.update(offset: caculateSize(string: contextLabel.text ?? "").height)
        }
    }
    
    var cellType: CellType = .showImage {
        didSet {
//            switch cellType {
//            case .showImage:
//                nameLabel.isHidden = true
//                headView.isHidden = false
//            case .showName:
//                nameLabel.isHidden = false
//                headView.isHidden = true
//            }
        }
    }
    
    private let headView = UIImageView()
    private let nameLabel = UILabel()
    private let contextLabel = UILabel()
    private var nameLabelHeightConstraint: Constraint?
    private var contextLabelHeightConstraint: Constraint?
    
    static func cell(tableView: UITableView, model: TestModel, type: CellType) -> TestCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TestCell
        
        if cell == nil {
            cell = TestCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.initView()
        cell?.setData(type: type, model: model)
        
        return cell ?? TestCell()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var totalHeight: CGFloat = 0
        totalHeight += nameLabel.sizeThatFits(size).height
//        totalHeight += UIScale(20)
        print("totalHeight:\(totalHeight)")
        return CGSize(width: size.width, height: totalHeight)
    }
    
    func setData(type: CellType, model: TestModel) {
        self.cellType = type
        self.model = model
    }
    
    func initView() {
        if headView.superview != nil {
            return
        }
        
//        contentView.addSubview(headView)
        contentView.addSubview(nameLabel)
//        contentView.addSubview(contextLabel)
        
//        headView.contentMode = .scaleAspectFit
//        headView.backgroundColor = UIColor.yellow
//        headView.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(UIScale(10))
//            make.top.equalToSuperview().offset(UIScale(10))
////            make.centerY.equalTo(nameLabel)
//            make.width.equalTo(UIScale(40))
//            make.bottom.equalToSuperview().inset(UIScale(10))
////            make.height.equalTo(nameLabel)
////            make.bottom.equalTo(contextLabel.snp.top).inset(UIScale(10))
//        }
        
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.lightGray
        nameLabel.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(UIScale(10))
//            make.right.equalToSuperview().inset(UIScale(10))
//            make.top.equalToSuperview().offset(UIScale(10))
//            make.bottom.equalToSuperview().inset(UIScale(10))
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
//            nameLabelHeightConstraint = make.height.equalTo(UIScale(50)).constraint
        }
        
//        contextLabel.numberOfLines = 0
//        contextLabel.textAlignment = .center
//        contextLabel.backgroundColor = UIColor.purple
//        contextLabel.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(UIScale(10))
//            make.right.equalToSuperview().inset(UIScale(10))
//            make.bottom.equalToSuperview().inset(UIScale(10))
//            make.top.equalTo(nameLabel.snp.bottom).offset(UIScale(10))
//        }
    }
    
    func caculateSize(string: String) -> CGSize {
        return stringFitSize(string: string, font: UIFont.systemFont(ofSize: UIFont.systemFontSize), maxSize: CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude))
    }
}



