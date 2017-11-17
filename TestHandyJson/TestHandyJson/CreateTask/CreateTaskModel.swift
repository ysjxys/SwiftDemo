//
//  CreateTaskModel.swift
//  TestHandyJson
//
//  Created by ysj on 2017/10/30.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import HandyJSON

struct CreateTaskModel: YSJModeling {
    var resultCode: Int?
    var resultDesc: String?
    var resultData: CreateTaskResultDataModel?
}

struct CreateTaskResultDataModel: YSJModeling {
    var orderNo: String?
    var deliverDistance: Double?
    var deliveryFee: Double?
    var overFeeInfo: CreateTaskOverFeeInfoModel?
}

struct CreateTaskOverFeeInfoModel: YSJModeling {
    var peekOverFee: Double?
    var totalOverFee: Double?
    var weatherOverFee: Double?
}
