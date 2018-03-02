//
//  HttpRequest.swift
//  VLY
//
//  Created by marui on 16/12/22.
//  Copyright © 2016年 VLY. All rights reserved.
//

import Foundation
/// HTTP Method
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}

/// 请求数据的来源
public enum DataSource {
    /// 从服务端请求数据
    case server
    /// 从本地存储请求数据，除非本地数据过期才会从服务器请求
    case local
    /// 先从本地存储请求数据再从务端请求数据，不管本地数据是否过期都会从服务器请求
    case mix
}

public protocol HttpRequest {
    /// 服务器地址
    var host: String { get }
    /// 请求路径
    var path: String { get }
    /// HTTP Method
    var method: HTTPMethod { get }
    /// 请求参数
    var parameters: [String: Any]? { get }
    /// HTTP headers
    var headers: Result<[String: String]> { get }
    /// 是否需要登录（是否需要token）
    var requireLogin: Bool { get }
    /// 请求数据的来源
    var dataSource: DataSource { get }
    /// 本地缓存响应数据的有效期
    var validPeriod: Double { get }
    /// 模型的类型
    associatedtype Model: Modeling
}
