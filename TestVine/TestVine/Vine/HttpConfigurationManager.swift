//
//  HttpConfigurationManager.swift
//  TestVine
//
//  Created by ysj on 2018/2/28.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

struct HttpConfigurationManager {
    
    static let shared = HttpConfigurationManager()
    
    public var errorDescriptions: [Int: String] = [:]
    
    init() {
        guard let path = Bundle.main.path(forResource: "HttpConfiguration", ofType: "plist") else {
            print("HttpConfiguration 配置文件缺失")
            return
        }
        
        let configurationDic = NSDictionary(contentsOfFile: path) ?? [:]
        guard let errorList = configurationDic.value(forKey: "errorDescriptions") as? Array<AnyObject> else {
            print("errorDescriptions 配置项缺失")
            return
        }
        
        for item in errorList {
            if let itemDic = item as? Dictionary<String, Any>,
                let errorCode = itemDic["errorCode"] as? Int,
                let errorDescription = itemDic["errorDescription"] as? String {
                
                errorDescriptions[errorCode] = errorDescription
                
            } else {
                print("errorDescriptions 内值非法")
            }
        }
        
    }
}
