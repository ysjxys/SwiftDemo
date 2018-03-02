//
//  MyOrderListSummaryView.swift
//  TestFrameMVVM
//
//  Created by ysj on 2017/12/27.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MyOrderListSummaryView: UIView, UITableViewDataSource {
    
    public var tableView = UITableView()
    
    let orderSummaryIncomeLabel = UILabel()
    
    var viewModel: MyOrderListSummaryViewModel = MyOrderListSummaryViewModel(model: MyOrderListArrayModel())
    
    // MARK: - life method
    init() {
        super.init(frame: UIScreen.main.bounds)
        startInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        startInit()
    }
    
    func startInit() {
        backgroundColor = UIColor.lightGray
        
        addSubview(tableView)
        initTableView()
        
        addSubview(orderSummaryIncomeLabel)
        initOrderSummaryIncomeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - update ViewModel method
    public func updateViewModel(viewModel: MyOrderListSummaryViewModel) {
        self.viewModel = viewModel
        orderSummaryIncomeLabel.text = "\(viewModel.orderSummaryIncome)"
        tableView.reloadData()
    }
    
    // MARK: - init Views method
    func initOrderSummaryIncomeLabel() {
        orderSummaryIncomeLabel.textColor = UIColor.black
        orderSummaryIncomeLabel.font = UIFont.systemFont(ofSize: 15)
        orderSummaryIncomeLabel.textAlignment = .center
        orderSummaryIncomeLabel.layer.cornerRadius = CGFloat(5)
        orderSummaryIncomeLabel.layer.borderColor = UIColor.white.cgColor
        orderSummaryIncomeLabel.layer.borderWidth = CGFloat(1)
        orderSummaryIncomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat(200))
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    func initTableView() {
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(self).multipliedBy(0.5)
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - tableView DataSource & Delegate method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderListTableViewCell.cell(tableView: tableView)
        let cellViewModel = OrderListTableViewCellViewModel(listModel: viewModel.orderArray[indexPath.row])
        cell.updateViewModel(viewModel: cellViewModel)
        return cell
    }
    
}
