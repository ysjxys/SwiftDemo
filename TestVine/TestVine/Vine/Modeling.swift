//
//  Modeling.swift
//  TestVine
//
//  Created by ysj on 2018/2/27.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation
import HandyJSON

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
            let dic = value as? NSDictionary
            guard let model = JSONDeserializer<Self>.deserializeFrom(dict: dic) else {
                return nil
            }
            return model
        }
        
        return nil
    }
}
