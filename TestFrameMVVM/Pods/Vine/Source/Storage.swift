//
//  Storage.swift
//  Pods
//
//  Created by apple on 17/2/14.
//
//

import Foundation
import Kvstore

class Storage {
    static let shared = Storage()
    private lazy var jsonStore = Store.largeCacheWithTimeStore()
    
    private init() {}
    
    @discardableResult
    internal func jsonFromURL(_ url: String, parameter: [String: Any], validPeriod: Double, callback: (([String: Any]) -> Void)?) -> Bool {
        var vURL = url
        vURL.append(parameter.DictToString())
        let key = vURL.md5()
        let neData = jsonStore.objectForKey(key)
        guard neData != .null else {
            callback?([:])
            return false
        }
        
        let timeInterval = NSDate().timeIntervalSince1970 - Double(neData.timestamp())!
        guard timeInterval < validPeriod else {
            debugLog("本地json数据已经过期，已经存了\(timeInterval)秒")
            jsonStore.removeForKey(key)
            callback?([:])
            return false
        }
        
        let jsonString = neData.toString()
        guard !jsonString.isEmpty else {
            callback?([:])
            return false
        }
        
        guard let data = jsonString.data(using: String.Encoding.utf8) else {
            return false
        }
        
        let anyObject = try?JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        guard let dictionary = anyObject as? [String: Any] else {
            return false
        }
        if let callback = callback {
            callback(dictionary)
        }
        debugLog("已成功加载本地的json数据")
        return true
        
    }
    
    internal func storeJSON(_ json: Any, withURL url: String, parameter: [String: Any]) -> Void {
        
        // 非第一页数据，不缓存
        guard parameter["from"] == nil else {
            return
        }
        
        var vURL = url
        vURL.append(parameter.DictToString())
        let timestamp = "\(NSDate().timeIntervalSince1970)"
        guard let dictionary = json as? [String: Any] else {
            return
        }
        let data =  DataType(type: "dictionaryWithTime", rawValue: dictionary.DictToString(), timestamp: timestamp)
        jsonStore.setObject(data, forKey: vURL.md5())
    }
    
    private static func stringOfURLRequest(_ urlRequest: URLRequest) -> String? {
        guard let urlString = urlRequest.url?.absoluteString else {
            return nil
        }
        return urlString
    }
    
}


extension String {
    func args() -> [String: Any] {
        var args = [String: Any]()
        
        guard let qIndex = self.index(of: "?")  else {
            return args
        }
        
        let qAfter = self.index(after: qIndex)
        let array = self[qAfter..<endIndex].components(separatedBy: "&")
        for arg in array {
            let arr = arg.components(separatedBy: "=")
            if arr.count == 2 {
                args.updateValue(arr[1], forKey: arr[0])
            }
        }
        return args
    }
}




