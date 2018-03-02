//
//  AuthError.swift
//  Pods
//
//  Created by CC on 2017/11/13.
//

import UIKit

// MArk: - Error
public enum XGAuthError: Error {
    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
    }
    
    public enum ResponseValidationFailureReason {
        case dataFileNil
        case dataFileReadFailed(at: URL)
        case missingContentType(acceptableContentTypes: [String])
        case unacceptableContentType(acceptableContentTypes: [String], responseContentType: String)
        case unacceptableStatusCode(code: Int)
    }
    
    public enum ResponseSerializationFailureReason {
        case inputDataNil
        case inputDataNilOrZeroLength
        case inputFileNil
        case inputFileReadFailed(at: URL)
        case stringSerializationFailed(encoding: String.Encoding)
        case jsonSerializationFailed(error: Error)
    }
    
    public struct NonzeroResultCode {
        public let code: Int
        public let desc: String
        public init(code: Int, desc: String) {
            self.code = code
            self.desc = desc
        }
    }
    
    public enum BreakdownResultSuitFailureReason {
        case nonzeroResultCode(_ : NonzeroResultCode)
        case typeCastFailed(desc: String)
        case noResultData
    }
    
    case invalidURL(url: URL)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)
    case breakdownResultSuitFailed(reason: BreakdownResultSuitFailureReason)
    case nilFoundInParameters(_: [String])
    case unBindCloundPushFailed
    case nsError(_: NSError)
}

extension XGAuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL(url: _):
            return "请求地址无效"
        case .parameterEncodingFailed(reason: let reason):
            return reason.localizedDescription
        case .responseValidationFailed(let reason):
            return reason.localizedDescription
        case .responseSerializationFailed(let reason):
            return reason.localizedDescription
        case .breakdownResultSuitFailed(let reason):
            return reason.localizedDescription
        case .nilFoundInParameters:
            return "参数为空"
        case .unBindCloundPushFailed:
            return "解绑推送失败"
        case .nsError(let nserror):
            return description(nserror: nserror)
        }
    }
    
    private func description(nserror: NSError) -> String {
        switch nserror.code {
        case -1_009:
            return "网络错误,请检查网络"
        case -1_001:
            return "网络超时,请稍后再试"
        case -1_003, -1_004:
            return "系统繁忙"
        default:
            return nserror.localizedDescription
        }
    }
}

extension XGAuthError.ParameterEncodingFailureReason {
    var localizedDescription: String {
        switch self {
        default:
            return "编码失败"
        }
    }
}

extension XGAuthError.ResponseValidationFailureReason {
    var localizedDescription: String {
        switch self {
        default:
            return "数据格式错误"
        }
    }
}

extension XGAuthError.ResponseSerializationFailureReason {
    var localizedDescription: String {
        switch self {
        default:
            return "数据格式错误"
        }
    }
}

extension XGAuthError.BreakdownResultSuitFailureReason {
    var localizedDescription: String {
        switch self {
        case .nonzeroResultCode(let res):
            return res.desc
        default:
            return "数据格式错误"
        }
    }
}
