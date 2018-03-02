//
//  AlamofireAdapter.swift
//  TestVine
//
//  Created by ysj on 2018/2/27.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation
import Alamofire

public struct AlamofireAdapter: HttpAdapter {
    
    public static var errorDescriptions: [Int: String] = HttpConfigurationManager.shared.errorDescriptions
    
    public var delegate: HttpAdapterDelegate?
    
    private var sessionManager: SessionManager
    
    
    public init(timeoutForRqeust: TimeInterval = 60) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutForRqeust
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        sessionManager = SessionManager(configuration: configuration)
    }
    
    public func sendRequest<T: HttpRequest>(_ request: T, completionHandler: @escaping (Result<T.Model>) -> Void) where T : HttpRequest {
        
        let urlString = request.host.appending(request.path)
        
        var headerDic = [String: String]()
        switch request.headers {
        case .success(let dic):
            headerDic = dic
        case .failure(let error):
            completionHandler(Result.failure(error))
        }
        
        let dataRequest = sessionManager.request(urlString, method: httpMethod(request: request), parameters: request.parameters ?? [:], encoding: encoding(request: request), headers: headerDic)
        
        dataRequest.responseJSON { (response) in
            switch response.result {
            case .success(let json):
                self.handleJSON(json: json, request: request, responseHeader: response.response?.allHeaderFields, completionHandler: completionHandler)
            case .failure(let error):
                DispatchQueue.main.async {
                    if let localizedError = error as? LocalizedError {
                        completionHandler(Result.failure(localizedError))
                    } else {
                        completionHandler(Result.failure(AlamofireAdapterError.nsError(error as NSError)))
                    }
                }
            }
        }
    }
    
    private func handleJSON<T: HttpRequest>(json: Any, request: T, responseHeader: [AnyHashable: Any]?, completionHandler: @escaping (Result<T.Model>) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            var result: Result<T.Model>?
            
            if let dicResult = self.delegate?.analyseResponseJson(json, request: request, responseHandler: responseHeader, completionHandler: completionHandler) {
                
                switch dicResult {
                case .success(let dic):
                    if let model = T.Model.fromValue(dic) {
                        result = Result.success(model)
                    } else {
                        result = Result.failure(AlamofireAdapterError.jsonToModelFailed)
                    }
                    
                case .failure(let error):
                    result = Result.failure(error)
                }
            }
            if let result = result {
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            }
        }
    }
    
    private func httpMethod<T: HttpRequest>(request: T) -> Alamofire.HTTPMethod {
        
        switch request.method {
        case .get:
            return Alamofire.HTTPMethod.get
        case .post:
            return Alamofire.HTTPMethod.post
        }
    }
    
    private func encoding<T: HttpRequest>(request: T) -> Alamofire.ParameterEncoding {
        
        switch request.method {
        case .get:
            return Alamofire.URLEncoding.default
        case .post:
            return Alamofire.JSONEncoding.default
        }
    }
}
