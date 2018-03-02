//
//  LoginModel.swift
//  expressHelper
//
//  Created by ysj on 2018/1/3.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation
import HandyJSON

struct LoginModel: HandyJSON, Modeling {
    
    //    token
    var token: String?
    
    //    name      用户昵称
    var name: String?
    
    //    storeName     所属门店的名称
    var storeName: String?
    
    //    phone     用户名
    var phone: String?
    
    //    refreshToken      用来刷新 Token 用的
    var refreshToken: String?
}
