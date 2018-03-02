//
//  OrderListDataController.swift
//  TestFrameMVVM
//
//  Created by ysj on 2017/12/29.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

struct OrderListDataController {
    
    static var listArrayModel: MyOrderListArrayModel = MyOrderListArrayModel()
    
    static var orderListModelArray: [MyOrderListModel] = []
    
    
    static func requestListDataWith(pageNo: Int, pageSize: Int, taskStatus: Int, successed: @escaping () -> Void, failed: @escaping (Error) -> Void) {
        HttpAPI.send(res: MyOrderListRequest(pageNo: pageNo, pageSize: pageSize, taskStatus: taskStatus, taskType: "M_SMALL_ORDER")) {
            switch $0 {
            case .success(let arrayModel):
                listArrayModel = arrayModel
                orderListModelArray = arrayModel.list ?? []
                successed()
            case .failure(let error):
                failed(error)
            }
        }
    }
}
