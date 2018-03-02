//
//  HttpAdapterDelegate.swift
//  TestVine
//
//  Created by ysj on 2018/2/26.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

public protocol HttpAdapterDelegate {
    
    func analyseResponseJson<T: HttpRequest>(_ json: Any, request: T, responseHandler: [AnyHashable: Any]?, completionHandler: (Result<T.Model>) -> Void ) -> Result<[String: Any]>?
}
