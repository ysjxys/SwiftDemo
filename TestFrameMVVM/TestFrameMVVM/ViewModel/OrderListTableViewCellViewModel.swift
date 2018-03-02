//
//  OrderListTableViewCellViewModel.swift
//  TestFrameMVVM
//
//  Created by ysj on 2017/12/27.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

struct OrderListTableViewCellViewModel {
    var listModel: MyOrderListModel
    
    var taskNo: String
    
    
    init(listModel: MyOrderListModel) {
        self.listModel = listModel
        
        taskNo = ""
        
        updateListModel()
    }
    
    mutating func updateListModel() {
        taskNo = updateTaskNo()
    }
    
    func updateTaskNo() -> String {
        return "订单id:\(listModel.taskNo ?? "")"
    }
}
