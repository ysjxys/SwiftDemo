//
//  OrderListTableViewCell.swift
//  TestFrameMVVM
//
//  Created by ysj on 2017/12/27.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    var taskNoLabel = UILabel()
    
    // MARK: - life method
    static func cell(tableView: UITableView) -> OrderListTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCellIdentifier") as? OrderListTableViewCell
        return cell ?? OrderListTableViewCell()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: "OrderListTableViewCellIdentifier")
        
        addSubview(taskNoLabel)
        initTaskNoLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - init Views method
    func initTaskNoLabel() {
        taskNoLabel.textColor = UIColor.black
        taskNoLabel.font = UIFont.systemFont(ofSize: 15)
        taskNoLabel.textAlignment = .left
        taskNoLabel.layer.cornerRadius = CGFloat(5)
        taskNoLabel.layer.borderColor = UIColor.lightGray.cgColor
        taskNoLabel.layer.borderWidth = CGFloat(1)
        taskNoLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(CGFloat(50))
            make.width.equalTo(250)
        }
    }
    
    // MARK: - update ViewModel method
    open func updateViewModel(viewModel: OrderListTableViewCellViewModel) {
        taskNoLabel.text = "\(viewModel.taskNo)"
    }
}
