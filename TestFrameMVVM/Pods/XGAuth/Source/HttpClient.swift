//
//  HttpClient.swift
//  RiderUser
//
//  Created by apple on 13/10/2017.
//  Copyright © 2017 XGN. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public func request(url: String, method: HTTPMethod = .post, parameters: [String:Any]?, headers: [String: String]? = nil, succeeded: @escaping (JSON) -> Void, failed: @escaping (_ error: Error) -> Void)  {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let trueURL = URL(string: url)!
    
    func _succeeded(_ json: JSON) {
        DispatchQueue.main.async {
            succeeded(json)
        }
    }
    
    func _failed(_ error: Error) {
        DispatchQueue.main.async {
            failed(error)
        }
    }
    
    let request = URLRequest(trueURL, method: method, headers: headers)
    do {
        let encodedURLRequest = try encode(request, with: parameters)
        let dataTask = session.dataTask(with: encodedURLRequest) { (data, response, error) in
            
            if let err = error {
                if let nserr = err as? NSError {
                    _failed(XGAuthError.nsError(nserr))
                } else {
                    _failed(err)
                    
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, [204, 205].contains(response.statusCode) {
                _succeeded(JSON(NSNull()))
                return
            }
            
            guard let validData = data, validData.count > 0 else {
                _failed(XGAuthError.responseSerializationFailed(reason: .inputDataNil))
                return
            }
            
            let json =  JSON(data: validData)
            
            guard let resultCode = json["resultCode"].string, let resultDesc = json["resultDesc"].string else {
                _failed(XGAuthError.responseValidationFailed(reason: .dataFileNil))
                return
            }
            
            if resultCode != "0", let resultDesc = json["resultDesc"].string {
                let result = XGAuthError.NonzeroResultCode(code: Int(resultCode)!, desc: resultDesc)
                let err = XGAuthError.breakdownResultSuitFailed(reason: .nonzeroResultCode(result))
                _failed(err)
                return
            }
            let resultData = json["resultData"]
            _succeeded(resultData)
        }
        
        defer{
            dataTask.resume()
        }
    }
    catch {
        _failed(XGAuthError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error)))
    }
}
extension URLRequest {
    public init(_ url: URL, method: HTTPMethod, headers: [String: String]? = nil)  {
        self.init(url: url)
        httpMethod = method.rawValue
        if let headers = headers {
            for (headerField, headerValue) in headers {
                setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
    }
}

public typealias Parameters = [String: Any]

public func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
    var urlRequest = urlRequest
    
    guard let parameters = parameters else { return urlRequest }
    
    do {
        let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
    } catch {
        throw XGAuthError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
    }
    
    return urlRequest
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
