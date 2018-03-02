//
//  Configuration.swift
//  Vine
//
//  Created by apple on 2017/12/6.
//  Copyright © 2017年 XGN. All rights reserved.
//

import Foundation
import XBLogger

struct configurationManager {
    
    static let shared = configurationManager()
    private var configurationDict: NSDictionary
    private var errorDescriptionsDict: [Int: String] = [:]
    private var dataSourceValue: DataSource?
    private var validPeriodValue: Double?
    
    private init() {
        guard let configurationListPath = Bundle.main.path(forResource: "HttpClientConfiguration", ofType:"plist") else {
            XBLogger.default.error("HttpClient plist配置文件找不到")
            configurationDict = [:]
            return
        }
        configurationDict = NSDictionary(contentsOfFile: configurationListPath) ?? [:]
        var list = [AnyObject]()
        if let description = configurationDict.value(forKey: "errorDescriptions") as? Array<AnyObject> {
            list = description
        } else {
            XBLogger.default.error("HttpClient plist配置文件errorDescriptions不合法")
        }
        //let list = configurationDict.value(forKey: "errorDescriptions")! as! Array<AnyObject>
        
        for item in list {
            if let itemDict = item as? Dictionary<String, Any>, let errorCode = itemDict["errorCode"] as? Int, let errorDescription = itemDict["errorDescription"] as? String {
                errorDescriptionsDict[errorCode] = errorDescription
            } else {
                XBLogger.default.error("HttpClient plist配置文件errorDescriptions中值不合法")
            }
        }
        
        if let code = configurationDict["dataSource"] as? Int {
            switch code {
            case 0:
                dataSourceValue = .server
            case 1:
                dataSourceValue = .local
            case 2:
                dataSourceValue = .mix
            default:
                dataSourceValue = .server
                XBLogger.default.error("HttpClient plist配置文件dataSource值不存在 ")
            }
        } else {
            XBLogger.default.error("HttpClient plist配置文件找不到 dataSource ")
        }
        
        if let value = configurationDict["validPeriod"] as? Double {
            validPeriodValue = value
        } else {
            XBLogger.default.error("HttpClient plist配置文件找不到 validPeriod ")
        }
    }
    
    public var errorDescriptions: [Int: String] {
        return errorDescriptionsDict
    }
    
    public var dataSource: DataSource {
        return dataSourceValue ?? .server
    }
    
    public var validPeriod: Double {
        return validPeriodValue ?? 60
    }
    
}
