//
//  HttpClient.swift
//  VLY
//
//  Created by apple on 16/12/26.
//  Copyright © 2016年 VLY. All rights reserved.
//

import Foundation
import RiderUser
import XGConfig

/// HTTP Client
public struct HttpClient {

    internal var adapter: HttpAdapter
    private static let shared: HttpClient = HttpClient(adapter: AlamofireAdapter(timeoutForRequest: 15))
    
    private init(adapter: HttpAdapter) {
        self.adapter = adapter
        AlamofireAdapter.errorDescriptions = configurationManager.shared.errorDescriptions
    }
    
    public static func send<T: HttpRequest>(res: T, handler: @escaping (Result<T.Model>) -> Void) {
        HttpClient.shared.adapter.sendRequest(res, completionHandler: handler)
    }
}

public extension HttpRequest {
    var dataSource: DataSource {
        return configurationManager.shared.dataSource
    }
    
    var validPeriod: Double {
        return configurationManager.shared.validPeriod
    }
}

public extension HttpRequest {
    var headers: Result<[String: String]> {
        return defaultHeaders()
    }
    
    func defaultHeaders() -> Result<[String: String]> {
        var dict = ["Content-Type": "application/json"]
        let token = UserManager.shared.token
        dict.updateValue(token, forKey: "Authorization")
        return Result.success(dict)
    }
}

public extension HttpRequest {
    var host: String {
        return requireLogin ? XGConfig.shareInstance().stringValue(forKey: "bussinessHost") : XGConfig.shareInstance().stringValue(forKey: "userCenterHost")
    }
}
