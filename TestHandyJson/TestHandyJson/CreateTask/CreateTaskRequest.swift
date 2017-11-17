//
//  CreateTaskRequest.swift
//  TestHandyJson
//
//  Created by ysj on 2017/10/31.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

struct CreateTaskRequest: YSJHttpRequest {
    
    let userId: String
    let requestData: String
    
    typealias Model = CreateTaskModel
    
    var host: String {
        return "http://tubobo-launcher.qafc.ops.com"
    }
    
    var path: String {
        return "/dak/order/create"
    }
    
    let method: Method = .post
    
    var header: [String : String]? {
        return nil
    }
    
    var param: [String: Any]? {
        return [
            "userId": userId,
            "requestData": requestData
        ]
    }
}
