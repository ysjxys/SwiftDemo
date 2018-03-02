//
//  HttpAdapter.swift
//  VLY
//
//  Created by marui on 16/12/23.
//  Copyright © 2016年 VLY. All rights reserved.
//

import Foundation

public protocol HttpAdapter {
    func sendRequest<T: HttpRequest>(_ request: T, completionHandler: @escaping (Result<T.Model>) -> Void)
}
