//
//  UserManager.swift
//  User
//
//  Created by apple on 20/10/2017.
//  Copyright © 2017 XGN. All rights reserved.
//

import Foundation
import SwiftyJSON
import XGAuth
import XGConfig


public var riderUser: User? {
    return UserManager.shared.user
}

public let RiderUser = UserManager.shared

private let kEncodedUser: String = "kEncodedUser"
private let kUserFrozenCode: Int = 20_500
public enum Environment {
    case product
    case test
    case develop
    case testOnLine
    case prepare
}

public enum LogoutType {
    case freewill
    case forced
}

public class UserManager: NSObject {
// MARK: - Property
    public static let shared = UserManager()
    
    private var _user: User?
    private var lock: NSLock = NSLock()
    private var logoutFailed: ((Error) -> Void)?
    private var logoutSucceeded: (() -> Void)?
    
// MARK: - Life Cycle
    private override init() {
        super.init()
        _user = XGAuth.decodeModel(User.self, forKey: kEncodedUser)
        NotificationCenter.default.addObserver(self, selector: #selector(didUnbindCloudPush(_:)), name: Notification.Name.didUnbindCloudPush, object: nil)
        XGAuth.clientSourceValue = "tubobo-rider"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UserManager {
    @objc private func didUnbindCloudPush(_ notification: Notification) {
        let userModel = user
        cleanToken()
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name.didLogout, object: userModel)
        }
        logoutSucceeded?()
    }
    
    private func fetchAuth(_ phone: String, password: String, succeeded: @escaping (Auth) -> Void, failed: @escaping (Error) -> Void) {
        XGAuth.login(phone, password: password, type: .userName, succeeded: { [unowned self] auth in
            self.user = User(auth: auth)
            succeeded(auth)
        }) { error in
            failed(error)
        }
    }
    
    private func updateUser(_ user: User, with json: JSON) -> User {
        
        user.contactPhone = json["phone"].string
        user.userID = json["userId"].string
        user.realName = json["realName"].string
        user.headImage = json["headImage"].string
        user.type = RiderType(rawValue: json["riderType"].stringValue)
        user.status = UserVerifyStatus(rawValue: json["riderStatus"].stringValue)
        user.communityStatus = UserVerifyCommunityStatus(rawValue: json["communityRiderStatus"].stringValue)
        user.bd = json["bd"].string
        user.isInsurance = json["isInsurance"].bool
        user.isOnDuty = json["isOnDuty"].bool
        user.isPushVoiceOn = json["isPushVoiceOn"].bool
        user.bindStatus = BindStatus(rawValue: json["bindStatus"].stringValue)
        user.hasFundAccount = json["hasFundAccount"].bool
        
        return user
    }
    
    private var userCenterHost: String {
        return XGConfig.shareInstance().stringValue(forKey: "userCenterHost")
    }

    private var bussinessHost: String {
        return XGConfig.shareInstance().stringValue(forKey: "bussinessHost")
    }
    
    private var toobobCommonHost: String {
        return XGConfig.shareInstance().stringValue(forKey: "toobobCommonHost")
    }
}

/**
 * 密码：均为未加密的密码
 *
 */
// MARK: - public
extension UserManager {
    public var user: User? {
        set {
            lock.lock()
            _user = newValue
            saveModel(newValue, forKey: kEncodedUser)
            lock.unlock()
        }
        
        get {
            return _user
        }
    }
    
    public var isInsurance: Bool {
        set {
            lock.lock()
            user?.isInsurance = newValue
            saveModel(user, forKey: kEncodedUser)
            lock.unlock()
        }
        
        get {
            return self.user?.isInsurance ?? true
        }
    }
    
    public var isPushVoiceOn: Bool {
        set {
            lock.lock()
            user?.isPushVoiceOn = newValue
            saveModel(user, forKey: kEncodedUser)
            lock.unlock()
        }
        get {
            return self.user?.isPushVoiceOn ?? true
        }
    }
    
    public var phone: String {
        return user?.auth?.phone ?? ""
    }
    
    public var realName: String {
        return user?.realName ?? "兔波波"
    }
    
    public var isOnDuty: Bool {
        set {
            lock.lock()
            user?.isOnDuty = newValue
            saveModel(user, forKey: kEncodedUser)
            lock.unlock()
        }
        
        get {
            return self.user?.isOnDuty ?? true
        }
    }
    
    public var riderType: RiderType {
        set {
            lock.lock()
            user?.type = newValue
            saveModel(user, forKey: kEncodedUser)
            lock.unlock()
        }
        
        get {
            return self.user?.type ?? .crowdSourcing
        }
    }
    
   public var isLogin: Bool {
        guard user?.auth?.token != nil else {
            return false
        }
        return true
    }
    
    public var token: String {
        get {
            return user?.auth?.token ?? ""
        }
    }
    
    public func cleanToken() {
        lock.lock()
        user?.auth?.token = nil
        saveModel(self.user, forKey: kEncodedUser)
        lock.unlock()
    }
    
    public func saveUser() {
        lock.lock()
        saveModel(user, forKey: kEncodedUser)
        lock.unlock()
    }
    
    public func logout(_ type: LogoutType, succeeded: @escaping () -> Void, failed: @escaping (Error) -> Void) {
        guard let reachability = ReachabilityManager(host: "www.baidu.com"), reachability.isReachable else {
            let error = NSError(domain: "toobob.rider.uc", code: -1_009, userInfo: nil)
            let ucError = UCError.nsError(error)
            failed(ucError)
            return
        }
        
        let userInfo: [String: Any] = [UCKey.userModel: self.user ?? NSNull(),
                                       UCKey.logoutType: type
        ]
        
        DispatchQueue.main.async {
            self.logoutFailed = failed
            self.logoutSucceeded = succeeded
            NotificationCenter.default.post(name: Notification.Name.willLogout, object: self, userInfo: userInfo)
        }
    }

    public func refreshToken(_ succeeded: @escaping (User) -> Void, failed: @escaping (Error) -> Void) {
        guard let phone = user?.auth?.phone, let password = user?.auth?.password else {
            failed(UCError.nilFoundInParameters(["phone", "password"]))
            return
        }
        login(phone, password: password, succeeded: succeeded, failed: failed)
    }
    
    public func login(_ phone: String, password: String, succeeded: @escaping (User) -> Void, failed: @escaping (Error) -> Void) {
        fetchAuth(phone, password: password, succeeded: { [unowned self] auth in
            self.fetchUserProfile(true, needQueryFundAccount: true, succeeded: { user in
                succeeded(user)
                let userInfo: [String: Any] = [UCKey.userModel: user]
                NotificationCenter.default.post(name: Notification.Name.didLogin, object: self, userInfo: userInfo)
            }, failed: { error in
                failed(error)
            })
        }) { error in
            failed(error)
        }
        
    }
    
    public func fetchUserProfile(_ needQueryBindStatus: Bool, needQueryFundAccount: Bool, succeeded: @escaping (User) -> Void, failed: @escaping (Error) -> Void) {
        let url = bussinessHost.appending("/info/query")
        let headers = ["Authorization": token]
        let paras: [String: Any] = ["needQueryBindStatus": needQueryBindStatus, "needQueryFundAccount": needQueryFundAccount]
        request(url: url, parameters: paras, headers: headers, succeeded: { [unowned self] json in
             guard let user = self.user else {
                assertionFailure("get user fail, now user is nil")
                return
            }
            let userModel = self.updateUser(user, with: json)
            self.user = userModel
            succeeded(userModel)
        }) { error in
            failed(error)
            if case let UCError.breakdownResultSuitFailed(reason: .nonzeroResultCode(result)) = error, result.code == kUserFrozenCode {
                self.user?.status = .frozen
                self.user?.communityStatus = .frozen
            }
            saveModel(self.user, forKey: kEncodedUser)
        }
    }
    
    public func fetchVerifyCode(_ phone: String, type: VerifyCodeType, succeeded: @escaping () -> Void, failed: @escaping (Error) -> Void) {
        XGAuth.sendVerifyCode(phone, type: type, succeeded: {
            succeeded()
        }) { error in
            failed(error)
        }
    }
    
    public func register(_ phone: String, verifyCode: String, password: String, succeeded: @escaping () -> Void, failed: @escaping (Error) -> Void) {
        
        XGAuth.register(phone, password: password, verifyCode: verifyCode, type: .phone, succeeded: {
            succeeded()
        }) { error in
            failed(error)
        }
    }
    
    public func findPassword(_ phone: String, verifyCode: String, newPassword password: String, succeeded: @escaping () -> Void, failed: @escaping (Error) -> Void) {
        XGAuth.findPassword(phone, password: password, varifyCode: verifyCode, succeeded: { [unowned self] in
            self.user?.auth?.password = password
            XGAuth.saveModel(self.user, forKey: kEncodedUser)
            succeeded()
        }) { error in
            failed(error)
        }
    }
    
   public func modifyPassword(_ phone: String, oldPassword: String, newPassword: String, repeatNewPassword: String, succeeded: @escaping () -> Void, failed: @escaping (Error) -> Void) {
        XGAuth.changePassword(newPassword, oldPassword: oldPassword, succeeded: { [unowned self] in
            self.user?.auth?.password = newPassword
            XGAuth.saveModel(self.user, forKey: kEncodedUser)
            succeeded()
        }) { error in
            failed(error)
        }
    }
    
    func fetchResetPayPasswordCredential(_ phone: String, verifyCode: String, password: String, succeeded: @escaping (String?) -> Void, failed: @escaping (Error) -> Void) {
        XGAuth.fetchChangePayPasswordKey(phone, password: password, verityCode: verifyCode, succeeded: { str in
            succeeded(str)
        }) { error in
            failed(error)
        }
    }
}
