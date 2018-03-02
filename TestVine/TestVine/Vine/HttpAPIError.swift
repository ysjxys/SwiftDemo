//
//  HttpAPIError.swift
//  TestVine
//
//  Created by ysj on 2018/2/28.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

public enum HttpAPIError: Error {
    public enum ServerReason {
        case message(Int, String)
        case tokenNotFound
    }
    
    public enum AnalyseResponseJSONReason {
        case asDictionaryFailed
        case codeNotFound
        case resultNotFound
        case messageNotFound
        case codeToIntFail
        case convertToModelFail
    }
    
    case serverFailed(ServerReason)
    case analyseResponseJSONFailed(AnalyseResponseJSONReason)
}

// MARK: - Error Descriptions
extension HttpAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverFailed(let reason):
            if let errorCode = errorCode {
                return "错误码\(errorCode), \(reason.localizedDescription)"
            }
            return reason.localizedDescription
        case .analyseResponseJSONFailed(let reason):
            return reason.localizedDescription
        }
    }
}

extension HttpAPIError.ServerReason {
    var localizedDescription: String {
        switch self {
        case .message(_, let msg):
            return msg
        case .tokenNotFound:
            return "token Not Found"
        }
    }
}

extension HttpAPIError.AnalyseResponseJSONReason {
    var localizedDescription: String {
        switch self {
        default:
            return "AnalyseResponseJSONReason: \(self)"
        }
    }
}

extension HttpAPIError {
    public var errorCode: Int? {
        switch self {
        case .serverFailed(let reason):
            switch reason {
            case .message(let code, _):
                return code
            default:
                return nil
            }
        case .analyseResponseJSONFailed:
            return nil
        }
    }
}
