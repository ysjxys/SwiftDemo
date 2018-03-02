//
//  HttpAdapter.swift
//  TestVine
//
//  Created by ysj on 2018/2/26.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

public protocol HttpAdapter {
    var delegate: HttpAdapterDelegate? { set get }
    
    func sendRequest<T: HttpRequest>(_ request: T, completionHandler: @escaping (Result<T.Model>) -> Void)
}
