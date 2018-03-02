//
//  HttpAPI.swift
//  TestVine
//
//  Created by ysj on 2018/2/28.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

struct HttpAPI: HttpAdapterDelegate {
    
    internal var adapter: HttpAdapter
    private static let shared: HttpAPI = HttpAPI(adapter: AlamofireAdapter(timeoutForRqeust: 15))
    
    private init(adapter: HttpAdapter) {
        self.adapter = adapter
        self.adapter.delegate = self
    }
    
    static func send<T: HttpRequest>(res: T, handler: @escaping (Result<T.Model>) -> Void) {
        HttpAPI.shared.adapter.sendRequest(res, completionHandler: handler)
    }
    
    func analyseResponseJson<T>(_ json: Any, request: T, responseHandler: [AnyHashable : Any]?, completionHandler: (Result<T.Model>) -> Void) -> Result<[String : Any]>? where T : HttpRequest {
        
        guard let dictionary = json as? [String: Any] else {
            return Result.failure(HttpAPIError.analyseResponseJSONFailed(.asDictionaryFailed))
        }
        
        guard let codeAny = dictionary["resultCode"] else {
            return Result.failure(HttpAPIError.analyseResponseJSONFailed(.codeNotFound))
        }
        
        let code: Int
        if let tempCodeInt = codeAny as? Int {
            code = tempCodeInt
        } else if let tempCodeString = codeAny as? String {
            if let tempCodeInt = Int(tempCodeString) {
                code = tempCodeInt
            } else {
                return Result.failure(HttpAPIError.analyseResponseJSONFailed(.codeToIntFail))
            }
        } else {
            return Result.failure(HttpAPIError.analyseResponseJSONFailed(.codeToIntFail))
        }
        
//        guard code != HttpServerCode.tokenInvalid else {
//            UserManager.shared.refreshToken({ _ in
//                HttpAPI.send(res: request, handler: handler)
//            }, failed: { error in
//                XBLogger.default.debug(error)
//            })
//            return nil
//        }
        
        guard code == HttpServerCode.noError else {
            guard let message = dictionary["resultDesc"] as? String else {
                return Result.failure(HttpAPIError.serverFailed(.message(code, "unknown error")))
            }
            return Result.failure(HttpAPIError.serverFailed(.message(code, message)))
        }
        
        var dict: [String: Any]
        
        if let result = dictionary["resultData"] as? [String: Any] {
            dict = result
        } else {
            dict = [:]
        }
        return Result.success(dict)
    }
}

public extension HttpRequest {
    var headers: Result<[String: String]> {
        return defaultHeaders()
    }
    
    func defaultHeaders() -> Result<[String: String]> {
        var dict = ["Content-Type": "application/json"]
        if requireLogin {
//            let token = UserManager.shared.token
            dict.updateValue(token, forKey: "Authorization")
        }
        return Result.success(dict)
    }
    
    //    var host: String {
    //        return XGConfig.shareInstance().stringValue(forKey: "bussinessHost")
    //    }
}
