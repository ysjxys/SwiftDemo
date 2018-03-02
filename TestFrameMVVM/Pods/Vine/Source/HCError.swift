//
//  HCError.swift
//  Alamofire
//
//  Created by apple on 15/11/2017.
//

import Foundation
import Alamofire
/// HCError

public enum HCError: Error {

    public struct NonzeroResultCode {
        public let code: Int
        public let desc: String
        public init(code: Int, desc: String) {
            self.code = code
            self.desc = desc
        }
    }
    
    public enum BreakdownResultSuitFailureReason {
        case typeCastFailed(desc: String)
        case noResultData
    }
    
    case breakdownResultSuitFailed(reason: BreakdownResultSuitFailureReason)
    case nilFoundIn(_: [String])
    case modellingFailed
    case nsError(_: NSError)
    case nonzeroResultCode(_ : NonzeroResultCode)
    case refreshTokenFailed
    case alamofireFailed(reason: AFError)
}

enum localizedDesc: String {
    case dataError = "数据错误"
    case encodeError = "编码错误"
    case nilFound = "出现空值"
    case modellingFailed = "模型化失败"
    case invalidURL = "无效的URL"
    case refreshTokenFailed = "刷新Token失败"
    case aferror = "Alamofire错误"
}

extension HCError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .breakdownResultSuitFailed(let reason):
            return reason.localizedDescription
        case .nilFoundIn(_):
            return localizedDesc.nilFound.rawValue
        case .modellingFailed:
            return localizedDesc.modellingFailed.rawValue
        case .nsError(let nserror):
            return description(nserror: nserror)
        case .refreshTokenFailed:
            return localizedDesc.refreshTokenFailed.rawValue
        case .nonzeroResultCode(let abnormal):
            return abnormal.desc
        case .alamofireFailed(let aferror):
            return description(aferror: aferror)
        }
    }
    
    private func description(nserror: NSError) -> String {
        if let desc = AlamofireAdapter.errorDescriptions[nserror.code] {
            return desc
        } else {
            return "网络不佳,请稍后再试(\(nserror.code)"//nserror.localizedDescription
        }
    }
    
    private func description(aferror: AFError) -> String {
        switch aferror {
        case .invalidURL(url: _):
            return localizedDesc.invalidURL.rawValue
        case .multipartEncodingFailed(reason: _): fallthrough
        case .parameterEncodingFailed(reason: _):
            return localizedDesc.encodeError.rawValue
        case .responseSerializationFailed(reason: _): fallthrough
        case .responseValidationFailed(reason: _):
            return localizedDesc.dataError.rawValue
        default:
            return localizedDesc.aferror.rawValue
        }
    }
}

extension HCError.BreakdownResultSuitFailureReason {
    var localizedDescription: String {
        switch self {
        default:
            return localizedDesc.dataError.rawValue
        }
    }
}



