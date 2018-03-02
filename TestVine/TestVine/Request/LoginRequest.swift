//
//  LoginRequest.swift
//  expressHelper
//
//  Created by ysj on 2018/1/2.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

struct LoginRequest: HttpRequest {
    
    let phone: String
    let password: String
    
    var host: String {
        return "https://test.toobob.com/tbbexpressqafc"
    }
    
    var path: String {
        return "/user/login"
    }
    
    let method: HTTPMethod = .post
    
    let requireLogin: Bool = false
    
    typealias Model = LoginModel
    
    var parameters: [String : Any]? {
        var params = [String: Any]()
        params["phone"] = phone
        params["password"] = password
        return params
    }
}
