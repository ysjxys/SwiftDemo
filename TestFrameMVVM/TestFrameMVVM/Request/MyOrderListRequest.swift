//
//  TaskListRequest.swift
//  Rider
//
//  Created by ysj on 2017/4/18.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import Vine

struct MyOrderListRequest: HttpRequest {
    let pageNo: Int
    let pageSize: Int
    let taskStatus: Int
    let taskType: String
    
    var headers: Result<[String: String]> {
        var dict = ["Content-Type": "application/json"]
        let token = "b4a3f7b4-58c4-4693-b7df-2dabb5b9f5e3"
        dict.updateValue(token, forKey: "Authorization")
        return Result.success(dict)
    }
    
    var host: String {
        return "http://tubobo-rider.qafc.ops.com"
    }
    
    var path: String {
        return "/order/list"
    }
    
    let method: HTTPMethod = .post
    
    let requireLogin: Bool = true
    
    typealias Model = MyOrderListArrayModel
    
    var parameters: [String : Any]? {
        var params = [String: Any]()
        params["pageNo"] = pageNo
        params["pageSize"] = pageSize
        params["taskStatus"] = taskStatus
        params["taskType"] = taskType
        return params
    }
}
