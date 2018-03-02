//
//  Bool_String.swift
//  Kvstore
//
//  Created by ysj on 2017/8/7.
//  Copyright © 2017年 XGN. All rights reserved.
//

import Foundation

extension Bool{
    public func BoolToString() -> String{
        return self ? "true" : "false"
    }
}

extension String {
    public func StringToBool() -> Bool {
        return self == "true" ? true : false
    }
}
