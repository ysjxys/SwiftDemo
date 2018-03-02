//
//  Modeling.swift
//  VLY
//
//  Created by marui on 16/12/25.
//  Copyright © 2016年 VLY. All rights reserved.
//

import Foundation
import HandyJSON

/// 转换为Model的协议
public protocol Modeling {
    static func fromValue(_ value: Any) -> Self?
}

extension Modeling where Self: HandyJSON {
    public static func fromValue(_ value: Any) -> Self? {
        
        if value is String {
            let string = value as? String
            guard let model = JSONDeserializer<Self>.deserializeFrom(json: string) else {
                return nil
            }
            return model
        }
        
        
        if value is NSDictionary {
            let dict = value as? NSDictionary
            guard let model = JSONDeserializer<Self>.deserializeFrom(dict: dict) else {
                return nil
            }
            return model
        }
        
        return nil
    }
}


