//
//  HttpRequest.swift
//  TestVine
//
//  Created by ysj on 2018/2/26.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol HttpRequest {
    
    /// HTTP headers
    var headers: Result<[String: String]> { get }
    /// 服务器地址
    var host: String { get }
    /// 请求路径
    var path: String { get }
    /// HTTP Method
    var method: HTTPMethod { get }
    /// 请求参数
    var parameters: [String: Any]? { get }
    /// 是否需要登录（是否需要token）
    var requireLogin: Bool { get }
    /// 模型的类型
    associatedtype Model: Modeling
}


