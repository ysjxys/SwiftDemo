//
//  AlamofireAdapterError.swift
//  TestVine
//
//  Created by ysj on 2018/2/28.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

public enum AlamofireAdapterError: Error {
    case jsonToModelFailed
    case nsError(NSError)
}

extension AlamofireAdapterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .jsonToModelFailed:
            return "Convert json to model failed"
        case .nsError(let nserror):
            if let errDesc = AlamofireAdapter.errorDescriptions[nserror.code] {
                return errDesc
            } else {
                return nserror.localizedDescription
            }
        }
    }
}
