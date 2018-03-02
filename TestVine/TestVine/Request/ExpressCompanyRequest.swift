//
//  CompressCompanyRequest.swift
//  TestVine
//
//  Created by ysj on 2018/2/28.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

struct ExpressCompanyRequest: HttpRequest {
    
    let type: String
    
    var host: String {
        return "https://test.toobob.com/tbbexpressqafc"
    }
    
    var path: String {
        return "/dictionary/query"
    }
    
    let method: HTTPMethod = .post
    
    let requireLogin: Bool = true
    
    typealias Model = ExpressCompanyListModel
    
    var parameters: [String : Any]? {
        var params = [String: Any]()
        params["type"] = type
        return params
    }
}
