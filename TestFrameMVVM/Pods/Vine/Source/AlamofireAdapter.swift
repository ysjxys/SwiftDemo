//
//  AlamofireAdapter.swift
//  VLY
//
//  Created by marui on 16/12/23.
//  Copyright © 2016年 VLY. All rights reserved.
//

import Foundation
import Alamofire
import RiderUser

/// 使用Alamofire来实现的HttpAdapter
public struct AlamofireAdapter: HttpAdapter {
    public static var errorDescriptions: [Int: String] = [:]
    
    private var alamoManager: SessionManager
    
    public init(timeoutForRequest: TimeInterval = 60) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutForRequest
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        self.alamoManager = SessionManager(configuration: configuration)
    }
    
    public func sendRequest<T : HttpRequest>(_ request: T, completionHandler: @escaping (Result<T.Model>) -> Void) {
        
        let urlString = request.host.appending(request.path)
        var headerDict = [String: String]()
        var lastJSON = [String: Any]()
        switch request.headers {
        case .success(let dict):
            headerDict = dict
        case .failure(let error):
            completionHandler(Result.failure(error))
            return
        }
        
        let args = request.parameters
        let dataRequest = alamoManager.request(urlString, method: httpMethod(of: request), parameters: args, encoding: encoding(of: request), headers: headerDict)
        switch request.dataSource {
        case .server:
            break
        case .local:
            break
        case .mix:
            guard dataRequest.request != nil else {
                return
            }
            
            Storage.shared.jsonFromURL(urlString, parameter: args ?? [:], validPeriod: request.validPeriod, callback: { (json) in
                self.handleJSON(json, withReq: request, args: args, respHeaders: nil, lastJSON: lastJSON, completionHandler: completionHandler)
                lastJSON = json
            })
            
        }
        
        dataRequest.responseJSON { (response) in
            switch response.result {
            case .success(let json):
                self.handleJSON(json, withReq: request, args: args, respHeaders: response.response?.allHeaderFields, lastJSON: lastJSON, completionHandler: completionHandler)
            case .failure(let error):
                DispatchQueue.main.async {
                    if let localizedErr = error as? LocalizedError {
                        // TODO: 返回什么样的Error？
                        completionHandler(Result.failure(localizedErr))
                    } else {
                        completionHandler(Result.failure(HCError.nsError(error as NSError)))
                    }
                }
            }            
        }
    }
    
    private func handleJSON<T: HttpRequest>(_ json: Any, withReq req: T, args: [String: Any]?, respHeaders: [AnyHashable : Any]?, lastJSON: [String: Any], completionHandler: @escaping (Result<T.Model>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            guard let currentJSON = json as? [String: Any] else {
                return
            }
            
            if JSON(lastJSON) == JSON(currentJSON) {
                debugLog("跳过成功回调.")
                return
            }
            
            guard let result = self.modelFromJSON(json, withReq: req, args: args, respHeaders: respHeaders, completionHandler: completionHandler) else {
                return
            }
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
    
    private func modelFromJSON<T: HttpRequest>(_ json: Any, withReq req: T, args: [String: Any]?, respHeaders: [AnyHashable : Any]?, completionHandler: @escaping (Result<T.Model>) -> Void) -> Result<T.Model>? {
        var res: Result<T.Model>?
        if let dictResult = breakDownResponseJSON(json, withRequest: req, responseHeader: respHeaders, completionHandler: completionHandler)  {
            switch dictResult {
            case .success(let dict):
                if let model = T.Model.fromValue(dict) {
                    res = Result.success(model)
                } else {
                    res = Result.failure(HCError.modellingFailed)
                }
                
                switch req.dataSource {
                case .server:
                    break
                case .local:
                    fallthrough
                case .mix:
                    let urlString = req.host.appending(req.path)
                    Storage.shared.storeJSON(json, withURL:urlString , parameter: args ?? [:])
                }
                
            case .failure(let error):
                res = Result.failure(error)
            }
        }
        return res
    }
    
    private func httpMethod<T: HttpRequest>(of request: T) -> Alamofire.HTTPMethod {
        var method: Alamofire.HTTPMethod
        switch request.method {
        case .get:
            method = .get
        case .post:
            method = .post
        }
        return method
    }
    
    private func encoding<T: HttpRequest>(of request: T) -> Alamofire.ParameterEncoding {
        switch request.method {
        case .get:
            return Alamofire.URLEncoding.default
        case .post:
            return Alamofire.JSONEncoding.default
        }
    }
    
}

private struct HttpServerCode {
    static let noError = 0
    static let unBindMobile = 99
    static let tokenInvalid = -5 // swiftlint:disable:this number_separator
}

extension AlamofireAdapter {
    // swiftlint:disable:next cyclomatic_complexity
    private func breakDownResponseJSON<T: HttpRequest>(_ json: Any, withRequest request: T, responseHeader: [AnyHashable : Any]?, completionHandler handler: @escaping (Result<T.Model>) -> Void) -> Result<[String: Any]>? {
        guard let dictionary = json as? [String: Any] else {
            return Result.failure(HCError.breakdownResultSuitFailed(reason: .typeCastFailed(desc: "转化为[String: Any]失败")))
        }
        
        guard let codeAny = dictionary["resultCode"] else {
            return Result.failure(HCError.nilFoundIn(["resultCode"]))
        }
        
        let code: Int
        if let codeInt = codeAny as? Int {
            code = codeInt
        } else if let codeString = codeAny as? String, let codeInt = Int(codeString) {
            code = codeInt
        } else {
            return Result.failure(HCError.breakdownResultSuitFailed(reason: .typeCastFailed(desc: "转化为Int失败")))
        }
        
        guard code != HttpServerCode.tokenInvalid else {
            UserManager.shared.refreshToken({_ in
                self.sendRequest(request, completionHandler: handler)
            }, failed: { error in
                handler(Result.failure(error))
            })
            return nil
        }
        
        guard code == HttpServerCode.noError else {
            var err: HCError.NonzeroResultCode!
            if let message = dictionary["resultDesc"] as? String {
                err = HCError.NonzeroResultCode(code: code, desc: message)
            } else {
                err = HCError.NonzeroResultCode(code: code, desc: "错误码\(code)")
            }
            return Result.failure(HCError.nonzeroResultCode(err))
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
