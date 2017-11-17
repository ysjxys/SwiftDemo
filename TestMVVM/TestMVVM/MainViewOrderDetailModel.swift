//
//  MainViewOrderDetailModel.swift
//  TestMVVM
//
//  Created by ysj on 2017/8/22.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

struct MainViewOrderDetailModel {
    var model: MyOrderDetailModel
    var customerAddress: String
    
    init(model: MyOrderDetailModel) {
        self.model = model
        
        let customDistrict = model.receiverAddressDistrict ?? ""
        let customStreet = model.receiverAddressStreet ?? ""
        let customDetail = model.receiverAddressDetail ?? ""
        customerAddress = customDistrict + customStreet + customDetail
    }
}
