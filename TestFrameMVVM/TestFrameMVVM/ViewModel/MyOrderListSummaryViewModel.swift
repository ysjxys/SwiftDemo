//
//  MyOrderListSummaryViewModel.swift
//  TestFrameMVVM
//
//  Created by ysj on 2017/12/27.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

struct MyOrderListSummaryViewModel {
    //外部传入model
    var listArrayModel: MyOrderListArrayModel
    //内部抽取方便调用的数组
    var orderArray: [MyOrderListModel] = []
    
    //viewModel内部参数
    var orderSummaryIncome: Double
    var orderCount: Int
    
    init(model: MyOrderListArrayModel) {
        listArrayModel = model
        orderArray = model.list ?? []
        
        orderSummaryIncome = 0.0
        orderCount = 0
        
        updateListModel(model: model)
    }
    
    mutating func updateListModel(model: MyOrderListArrayModel) {
        listArrayModel = model
        orderArray = model.list ?? []
        
        orderSummaryIncome = updateOrderSummaryIncome()
        orderCount = updateOrderCount()
        
    }
    
    func updateOrderCount() -> Int {
        return orderArray.count
    }
    
    func updateOrderSummaryIncome() -> Double {
        var summary: Double = 0.0
        for model in orderArray {
            summary = summary + (model.payAmount ?? 0.0)
        }
        return summary
    }
}
