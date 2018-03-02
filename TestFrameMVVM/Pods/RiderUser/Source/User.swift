//
//  User.swift
//  Pods
//
//  Created by apple on 29/09/2017.
//
//

import Foundation
import XGAuth

public typealias UCError = XGAuthError
public typealias VerifyCodeType = XGAuth.VerifyCodeType

extension String {
    public var encrytedByAES128: String {
        return self.aes128Encrypt
    }
}

extension Notification.Name {
        public static let didLogin = NSNotification.Name(rawValue: "UCNotificaitonKey.didLogin")
        public static let didLogout = NSNotification.Name(rawValue: "UCNotificaitonKey.didLogout")
        public static let willLogout = NSNotification.Name(rawValue: "UCNotificaitonKey.willLogout")
        public static let didUnbindCloudPush = NSNotification.Name(rawValue: "UCNotificaitonKey.didUnbindCloudPush")
}

public struct UCKey {
    public static let isUnbindingCloundPush = "kIsUnbindingCloundPush"
    public static let userModel = "kUserModel"
    public static let logoutType = "kLogoutType"
}

public enum RiderType: String, Codable {
    case crowdSourcing = "CROWDSOURCING"
    case stage = "STAGE"
    case other = "OTHER"
    case community = "COMMUNITY"
    case both = "BOTH"
}

public enum UserVerifyStatus: String, Codable {
    case initial = "INIT"
    case apply = "APPLY"
    case success = "SUCCESS"
    case fail = "FAIL"
    case frozen = "FROZEN"
    case nullString = ""
}

public enum UserVerifyCommunityStatus: String, Codable {
    case initial = "INIT"
    case apply = "APPLY"
    case success = "SUCCESS"
    case fail = "FAIL"
    case frozen = "FROZEN"
    case nullString = ""
}

public enum BindStatus: String, Codable {
    case initial = "INIT"           //初始化
    case success = "SUCCESS"        //同意授权
    case reject = "REJECT"          //拒绝授权
    case nooperate = "NOOPERATE"    //未操作
    case unbundle = "UNBUNDLE"      //已解绑
}

public class User: NSObject, Codable {
    
    public var auth: Auth?
    public var bd: String?
    public var bindStatus: BindStatus?              //驿站骑手绑定状态
    public var hasFundAccount: Bool?                //是否已创建资金账户
    public var headImage: String?
    public var isInsurance: Bool?
    public var isOnDuty: Bool?
    public var isPushVoiceOn: Bool?
    public var contactPhone: String?                //
    public var realName: String?
    public var status: UserVerifyStatus?            //骑手认证状态
    public var type: RiderType?                     //骑手类型
    public var userID: String?
    public var communityStatus: UserVerifyCommunityStatus?
    
    public var phone: String? {
        return auth?.phone
    }
    
    public init(auth: Auth? = nil,
                bd: String? = nil,
                bindStatus: BindStatus? = nil,
                hasFundAccount:Bool? = nil,
                headImage: String? = nil,
                isInsurance: Bool? = nil,
                isOnDuty: Bool? = nil,
                isPushVoiceOn: Bool? = nil,
                contactPhone: String? = nil,
                realName: String? = nil,
                status: UserVerifyStatus? = nil,
                communityStatus: UserVerifyCommunityStatus? = nil,
                type: RiderType? = nil,
                userID: String? = nil)
    {
        self.auth = auth
        self.bd = bd
        self.bindStatus = bindStatus
        self.hasFundAccount = hasFundAccount
        self.headImage = headImage
        self.isInsurance = isInsurance
        self.isOnDuty = isOnDuty
        self.isPushVoiceOn = isPushVoiceOn
        self.contactPhone = contactPhone
        self.realName = realName
        self.status = status
        self.communityStatus = communityStatus
        self.type = type
        self.userID = userID
    }
}

