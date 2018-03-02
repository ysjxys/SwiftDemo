//
//  ExpressCompany.swift
//  expressHelper
//
//  Created by ysj on 2018/1/15.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation
import HandyJSON

struct ExpressCompanyModel: HandyJSON, Modeling {
    
    //    label      快递公司名称
    var label: String?
    
    //    remark     用来判断输入的运单号是否属于该快递公司的正则表达式
    var remark: String?
    
    //    value      快递公司id
    var value: String?
}

struct ExpressCompanyListModel: HandyJSON, Modeling {
    
    //    list      快递公司数组
    var list: [ExpressCompanyModel]?
    
}
