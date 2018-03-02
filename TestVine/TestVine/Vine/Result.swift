//
//  Result.swift
//  TestVine
//
//  Created by ysj on 2018/2/26.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(LocalizedError)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: LocalizedError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
}
