//
//  XGAuth.swift
//
//
//  Created by apple on 17/10/2017.
//  Copyright © 2017 XGN. All rights reserved.
//

import Foundation
import SwiftyJSON
import XGConfig

// MARK: - Type
//验证码类型
public enum VerifyCodeType: String {
    case unBindVender = "ub"            //解绑第三方账号
    case bindVender = "b"               //绑定第三方账号
    case findPayPW = "fp"               //找回支付密码
    case findPW = "f"                   //找回密码
    case register = "r"                 //注册
    case login = "l"                    //登录
//    case modify_phone = "modify_phone"  //
}

//注册类型
public enum RegisterType: String {
    case phone = "phone"                //手机号
    case name = "name"                  //用户名
    case email = "email"                //邮箱
}

//登录类型
public enum LoginType: String {
    case phone = "phone"                //手机验证码登录
    case weixin = "wx"                  //微信登录
    case userName = "username"          //用户名密码登录+手机号密码
}

//用户名类型
public enum UserNameType: String {
    case phone = "phone"                //手机号
    case name = "name"                  //用户名
    case email = "email"                //邮箱
    case weixin = "wx"                  //微信
}

public class Auth: NSObject, Codable {
    public var phone: String
    public var password: String
    public var token: String?
    public var refreshToken: String?
    public var expiresIn: String?
    public var scope: String?
    public var tokenType: String?
    
    public init(_ phone: String, password: String, token: String?, refreshToken: String?, expiresIn: String?, scope: String?, tokenType: String?) {
        self.phone = phone
        self.password = password
        self.token = token
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.scope = scope
        self.tokenType = tokenType
    }
}


public typealias Succeeded = () -> Void
public typealias Failed = (Error) -> Void
public typealias LoginSucceeded = (Auth) -> Void

private let kEncodedAuth = "kEncodedAuth"
private let kEncodedHeader = "kEncodedHeader"
private let kEncodedClientSource = "kEncodedClientSource"

private let usernameKey = "username"
private var phoneKey = "phone"
private var passwordKey = "password"
private var typeKey = "type"
private var verifyCodeKey = "verifyCode"
private var defaultClientId = "tubobo:tubobo"

private class HeaderValue: NSObject, Codable {
    var clientSourceValue: String?
    var clientIdAndSecret: String?
    var authorizationValue: String?
    
    init(clientSourceValue: String? = nil, clientIdAndSecret: String? = nil, authorizationValue: String? = nil) {
        self.clientSourceValue = clientSourceValue
        self.clientIdAndSecret = clientIdAndSecret
        self.authorizationValue = authorizationValue
    }
}

//默认值
private var _headerMessage = HeaderValue(clientSourceValue: "tubobo", clientIdAndSecret: defaultClientId, authorizationValue: encryptClientIdAndSecret(str: defaultClientId))

private var headerMessage: HeaderValue
{
    set {
        NSLock().lock()
        _headerMessage = newValue
        saveModel(newValue, forKey: kEncodedHeader)
        NSLock().unlock()
    }
    get {
        return _headerMessage
    }
}

//Authorization value（赋值一次即可）
public var clientIdAndSecret: String? {
    didSet {
        if let newValue = clientIdAndSecret {
            let value = encryptClientIdAndSecret(str: newValue)
            headerMessage.authorizationValue = value
            headerMessage.clientIdAndSecret = newValue
            saveModel(headerMessage, forKey: kEncodedHeader)
        }
    }
}

//app 类型(骑手，商家，司机)
public var clientSourceValue: String? {
    didSet {
        if let newValue = clientSourceValue {
            headerMessage.clientSourceValue = newValue
            saveModel(headerMessage, forKey: kEncodedHeader)
        }
    }
}

//加密后的Authorization value
private var authorizationValue: String {
    return headerMessage.authorizationValue ?? encryptClientIdAndSecret(str: defaultClientId)
}

private var clientValue: String {
    return headerMessage.clientSourceValue ?? "tubobo"
}

//APP版本号
private var appVersion: String {
    return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "ungetable_version_iOS"
}

private var token: String {
    return authMessage?.token ?? ""
}

private var refreshToken: String {
    return authMessage?.refreshToken ?? ""
}

private var userCenterHost: String {
    return XGConfig.shareInstance().stringValue(forKey: "userCenterHost")
//    return XGConfig.shareInstance().userCenterHost
}

private var customHeader: [String: String] {
    
    //dHVib2JvOnR1Ym9ibw==
    return [
        "Authorization": authorizationValue,
        "device_type": "ios",
        "client_source": clientValue,
        "version": appVersion,
        "client_sn": UIDevice.current.identifierForVendor?.uuidString ?? "ungetable_iOS_uuidString"
    ]
}

private var headerWithToken: [String: String] {
    
    //token = type + token
    let value = token
    return [
        "Authorization": value,
        "device_type": "ios",
        "client_source": clientValue,
        "version": appVersion,
        "client_sn": UIDevice.current.identifierForVendor?.uuidString ?? "ungetable_iOS_uuidString"
    ]
}

public func saveModel<T: Codable>(_ model: T, forKey key: String) {
    let encoded = try? JSONEncoder().encode(model)
    UserDefaults.standard.setValue(encoded, forKey: key)
}

public func decodeModel<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
    guard let encoded = UserDefaults.standard.value(forKey: key) as? Data else {
        return nil
    }
    return try? JSONDecoder().decode(type, from: encoded)
}

//加密
private func encryptClientIdAndSecret(str: String) -> String {
    //默认  clientId:tubobo, clientSecret:tubobo
    let utf8EncodeData = str.data(using: String.Encoding.utf8, allowLossyConversion: true)
    let base64Str = utf8EncodeData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
    var value = ""
    if let base64Value = base64Str {
        value = "Basic " + base64Value
    }
    return value
}

public var authMessage: Auth? {
    set {
        saveModel(newValue, forKey: kEncodedAuth)
    }
    get {
        return decodeModel(Auth.self, forKey: kEncodedAuth)
    }
}

private func cleanToken() {
    if let auth = authMessage {
        auth.token = nil
        authMessage = auth
    }
}

// MARK: - login
public func login(_ phone: String, password: String, type: LoginType, succeeded: @escaping LoginSucceeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/login")
    var encrytedPassword = password
    if type == .userName {
        encrytedPassword = password.aes128Encrypt
    }
    let paras = [usernameKey: phone, passwordKey: encrytedPassword, typeKey: type.rawValue]
    
    request(url: url, method: .post, parameters: paras,  headers: customHeader, succeeded: { json in
        let refreshToken = json["refresh_token"].string
        let expiresIn = json["expires_in"].string
        let scope = json["scope"].string
        let tokenType = json["token_type"].string
        var typeToken = json["access_token"].stringValue
        if let ttype = tokenType {
            typeToken = ttype + " " + json["access_token"].stringValue
        }
        
        let auth = Auth(phone, password: password, token: typeToken, refreshToken: refreshToken, expiresIn: expiresIn, scope: scope, tokenType: tokenType)
        authMessage = auth
        succeeded(auth)
    }) { error in
        failed(error)
    }
}

// MARK: - refresh token
public func refreshTokenEvent(succeeded: @escaping LoginSucceeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/token/refresh")
    let paras = ["refreshToken": refreshToken]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        let refreshToken = json["refresh_token"].string
        let expiresIn = json["expires_in"].string
        let scope = json["scope"].string
        let tokenType = json["token_type"].string
        var typeToken = json["access_token"].stringValue
        if let ttype = tokenType {
            typeToken = ttype + " " + json["access_token"].stringValue
        }
        
        if let auth = authMessage {
            auth.refreshToken = refreshToken
            auth.token = typeToken
            auth.scope = scope
            auth.tokenType = tokenType
            auth.expiresIn = expiresIn
            authMessage = auth
        }
        
        succeeded(authMessage!)
    }) { error in
        failed(error)
    }
}

// MARK: - register
public func register(_ phone: String, password: String, verifyCode: String, type: RegisterType, succeeded: @escaping Succeeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/register")
    let paras = [usernameKey: phone, passwordKey: password.aes128Encrypt, typeKey: type.rawValue, verifyCodeKey: verifyCode]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        succeeded()
    }) { error in
        failed(error)
    }
}

// MARK: - 找回密码
public func findPassword(_ phone: String, password: String, varifyCode: String, succeeded: @escaping Succeeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/findPassword")
    let paras = [phoneKey: phone, passwordKey: password.aes128Encrypt, verifyCodeKey: varifyCode]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        if let auth = authMessage {
            auth.password = password
            authMessage = auth
            
        }
        succeeded()
    }) { error in
        failed(error)
    }
}

// MARK: - 发送短信验证码
public func sendVerifyCode(_ phone: String, type: VerifyCodeType, succeeded: @escaping Succeeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/smsAuthCode/send")
    let paras = [phoneKey: phone, typeKey: type.rawValue]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        succeeded()
    }) { error in
        failed(error)
    }
}

// MARK: - 修改密码
public func changePassword(_ newPassword: String, oldPassword: String, succeeded: @escaping Succeeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/modifyPassword")
    let paras = ["newPassword": newPassword.aes128Encrypt, "oldPassword": oldPassword.aes128Encrypt]
    
    request(url: url, method: .post, parameters: paras, headers: headerWithToken, succeeded: { json in
        if let auth = authMessage {
            auth.password = newPassword
            authMessage = auth
        }
        succeeded()
    }) { error in
        failed(error)
    }
}

// MARK: - 校验手机号是否已绑定微信
public func checkPhoneIsBindWeiXin(_ phone: String, type: String, succeeded: @escaping (Bool) -> Void, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/bindInfo")
    let paras = [phoneKey: phone, typeKey: type]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        let isBind = json["isBind"].boolValue
        succeeded(isBind)
    }) { error in
        failed(error)
    }
}

// MARK: - 校验用户名
public func checkUserNameIsExist(_ username: String, type: UserNameType, succeeded: @escaping (Bool) -> Void, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/verifyUsername")
    let paras = [usernameKey: username, typeKey: type.rawValue]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        let isExist = json["isExist"].boolValue
        succeeded(isExist)
    }) { error in
        failed(error)
    }
}

// MARK: - 绑定第三方账号
public func bindingVenderAccount(_ openId: String, phone: String, verifyCode: String, succeeded: @escaping Succeeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/bind")
    let paras = ["openId": openId, phoneKey: phone, verifyCodeKey: verifyCode, typeKey: "wx"]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        succeeded()
    }) { error in
        failed(error)
    }
}

// MARK: - 解绑第三方账号
public func unbindingVenderAccount(_ phone: String, verifyCode: String, succeeded: @escaping Succeeded, failed: @escaping Failed) {
    let url = userCenterHost.appending("/account/unbind")
    let paras = [phoneKey: phone, verifyCodeKey: verifyCode, typeKey: "wx"]
    
    request(url: url, method: .post, parameters: paras, headers: customHeader, succeeded: { json in
        succeeded()
    }) { error in
        failed(error)
    }
}

// MARK: - 获取重置支付密码的操作凭证
public func fetchChangePayPasswordKey(_ phone: String, password: String, verityCode: String, succeeded: @escaping (String) -> Void, failed: @escaping Failed) {
    
    let url = userCenterHost.appending("/account/credential")
    let paras = [phoneKey: phone, passwordKey: password.aes128Encrypt, verifyCodeKey: verityCode]
    
    request(url: url, method: .post, parameters: paras, headers: headerWithToken, succeeded: { json in
        let credential = json["credential"].string
        if let str = credential {
            succeeded(str)
        }
    }) { error in
        failed(error)
    }
}

extension String {
   public var aes128Encrypt: String {
        let hexString = AESUtil.aes128Encrypt(self, withKey: "eGluZ3Vhbmd0YmI=")
        guard let string = hexString else {
            return ""
        }
        return string
    }
}
