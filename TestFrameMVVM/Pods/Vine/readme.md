
[demo下载](https://pan.baidu.com/s/1miuhSYO)

### 一、配置Vine模块

### 1、 安装

使用CocoaPods安装,Podfile文件内容如下:

```
# Uncomment the next line to define a global platform for your project
platform :ios, '8.1'
source 'http://112.124.41.46/yougoods-ios/xgn.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'VLY' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for VLY
  pod 'Vine'
end
```

### 2、在工程中添加一个HttpClient目录

后面所建的文件都统一放到此目录下

### 3、定义类型别名

为了避免在每一个具体请求中都导入Vine模块，可以通过类型别名来解决这个问题。 在项目加入一个文件，这里名字为 VineAlias.swift，内容如下

```
import Foundation
import Vine

typealias HttpRequest = Vine.HttpRequest
typealias HTTPMethod = Vine.HTTPMethod
typealias Modeling = Vine.Modeling
typealias DataSource = Vine.DataSource
typealias NothingModel = Vine.NothingModel
```

### 4. 单例HttpClient

这个单例的功能有

1. 封装Vine模块中AlamofireAdapter所提供的发送请求功能

2. 实现AlamofireAdapterDelegate协议，作为AlamofireAdapter的代理。

   > 上述第二条使用了代理模式，是为了解决后端所返回JSON数据的三件套名称不一样，以及token处理方式不一样的问题。目的是把这些变化的部分放到Vine模块外处理。

```
struct HttpClient {
    
    internal var adapter: HttpAdapter
    private static let shared: HttpClient = HttpClient(adapter: AlamofireAdapter())
    private  init(adapter: HttpAdapter) {
        self.adapter = adapter
        self.adapter.delegate = self
    }
    
    static func sendRequest<T: HttpRequest>(_ request: T, completionHandler: @escaping (Result<T.Model>) -> Void) {
        HttpClient.shared.adapter.sendRequest(request, completionHandler: completionHandler)
    }
}


extension HttpClient: HttpAdapterDelegate {
    func breakDownResponseJSON<T: HttpRequest>(_ json: Any, withRequest request: T, responseHeader: [AnyHashable : Any]?, completionHandler: @escaping (Result<T.Model>) -> Void) -> Result<[String: Any]>? {
        guard let dictionary = json as? [String: Any] else {
            return Result.failure(HttpClientError.breakDownResponseJSONFailed(.asDictionaryFailed))
        }
        
        guard let codeString = dictionary["code"] as? String else {
            return Result.failure(HttpClientError.breakDownResponseJSONFailed(.codeNotFound))
        }
        
        guard let code =  Int(codeString) else {
            return Result.failure(HttpClientError.breakDownResponseJSONFailed(.codeToIntFail))
            
        }
        
        guard code == HttpServerCode.noError else {
            guard let message = dictionary["message"] as? String else {
                return Result.failure(HttpClientError.serverFailed(.message(code, "unknown error")))
            }
            return Result.failure(HttpClientError.serverFailed(.message(code, message)))
        }
        
        var dict: [String: Any]
        
        if let result = dictionary["result"] as? [String: Any] {
            dict = result
        } else {
            dict = [:]
        }
        return Result.success(dict)
    }
}
```

```
import Foundation

// MARK: - Server code
struct HttpServerCode {
    static let noError = 0
    static let unBindMobile = 99
    static let tokenInvalid = 101000
}

```

### 5、HttpClientError,HttpServerCode

这里是定义HTTP请求过程中和业务相关的错误和服务端返回的Code，代码参见Demo中的HttpClientError.swift

```
import Foundation

// MARK: - Error Definition
public enum HttpClientError: Error {
    public enum ServerReason {
        case message(Int, String)
        case tokenNotFound
    }
    
    public enum RunEnvReason {
        case tokenNotFound
        case appIdNotFound
        case appKeyNotFound
        case encryptUserFailed
    }
    
    public enum BreakDownResponseJSONReason {
        case asDictionaryFailed
        case codeNotFound
        case resultNotFound
        case messageNotFound
        case codeToIntFail
        case convertToModelFail
    }
    
    case serverFailed(ServerReason)
    case runEnvFailed(RunEnvReason)
    case breakDownResponseJSONFailed(BreakDownResponseJSONReason)
}

// MARK: - Error Descriptions
extension HttpClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverFailed(let reason):
            return reason.localizedDescription
        case .runEnvFailed(let reason):
            return reason.localizedDescription
        case .breakDownResponseJSONFailed(let reason):
            return reason.localizedDescription
        }
    }
}

extension HttpClientError.RunEnvReason {
    var localizedDescription: String {
        switch self {
        case .tokenNotFound:
            return "RunEnvReason: token not found"
        case .appIdNotFound:
            return "RunEnvReason: appId Not Found"
        case .appKeyNotFound:
            return "RunEnvReason: app Key Not Found"
        case .encryptUserFailed:
            return "RunEnvReason: encrypt User Failed"
        }
    }
}

extension HttpClientError.ServerReason {
    var localizedDescription: String {
        switch self {
        case .message(_, let msg):
            return msg
        case .tokenNotFound:
            return "token Not Found"
        }
    }
}

extension HttpClientError.BreakDownResponseJSONReason {
    var localizedDescription: String {
        switch self {
        default:
            return "BreakDownResponseJSONReason: \(self)"
        }
    }
}
```

```
import Foundation

// MARK: - Server code
struct HttpServerCode {
    static let noError = 0
    static let unBindMobile = 99
    static let tokenInvalid = 101000
}
```

### 6、HttpRequest协议说明

为了接着往下进行，先有必要对Vine模块里的HttpRequest协议进行说明

```
/
//  HttpRequest.swift
//  VLY
//
//  Created by marui on 16/12/22.
//  Copyright © 2016年 VLY. All rights reserved.
//

import Foundation
/// HTTP Method
public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}

/// 请求数据的来源
public enum DataSource {
    // 从服务端请求数据
    case server
    // 从本地缓存请求数据，除非本地数据过期才会从服务器请求
    case local
    // 先从本地缓存请求数据再从务端请求数据，不管本地数据是否过期都会从服务器请求，若数据无变化不会回调控制器中的处理逻辑
    case mix
}

public protocol HttpRequest {
    // 服务器地址
    var host: String { get }
    // 请求路径
    var path: String { get }
    // HTTP Method
    var method: HTTPMethod { get }
    // 请求参数
    var parameters: [String: Any]? { get }
    // HTTP headers
    var headers: Result<[String: String]> { get }
    // 是否需要登录（是否需要token）
    var requireLogin: Bool { get }
    // 请求数据的来源
    var dataSource: DataSource { get }
    // 本地缓存响应数据的有效期
    var validPeriod: Double { get }
    // 请求所返回的Json转Model时，所对应的Model
    associatedtype Model: Modeling
}
```



### 7、添加HttpRequest默认实现

对HttpRequest协议中通用的属性可以通过扩展的方式来提供默认实现，如：

HttpRequest+Cache.swift文件对网路数据缓存做了默认设置：

```
//
//  HttpRequest+Headers.swift

import Foundation
import Vine

extension HttpRequest {
    var dataSource: DataSource {
        return .server
    }
    
    var validPeriod: Double {
        return 60
    }
}
```

 HttpRequest+Headers.swift设置了HttpRequest中headers的默认部分

```
//
//  HttpRequest+Headers.swift

import Foundation
import Vine

extension HttpRequest {
    var headers: Result<[String: String]> {
        return vlyHeaders()
    }
    
    private func vlyHeaders() -> Result<[String: String]> {
        let dict = ["Content-Type" : "application/json"]
        return Result.success(dict)
    }
    
}

```

HttpRequest+Host.swift设置了默认的主机地址

```

import Foundation

extension HttpRequest {
    var host: String {
        return httpBusinessHost
    }
}
```

## 二、发送请求与Model解析

下面以未来域项目中的获取房源列表为例，演示一个发送网络请求并解析成Model的完整过程

#### 1、定义请求所对应的model

```
//
//  HousingResourceListModel.swift
//  VLY
//
//  Created by apple on 17/1/16.
//  Copyright © 2017年 VLY. All rights reserved.
//

import Foundation
import HandyJSON

struct HousingResourceListModel: HandyJSON, Modeling {
    var pageList: [HousingResourceCellModel]?
    var pageNum: Int?
    var pageSize: Int?
    var total: Int?
}

struct HousingResourceCellModel: HandyJSON, Modeling {
    var address: String?
    var id: String?
    var img: String?
    var name: String?
    var price: String?
    var storeid: String?
    var storename: String?
}
```



#### 2、定义请求

```
//
//  HousingResourceListRequest.swift
//  VLY
//
//  Created by apple on 17/1/16.
//  Copyright © 2017年 VLY. All rights reserved.
//

import Foundation

struct HousingResourceListRequest: HttpRequest {
    /// 这里是请求的参数部分
    let citycode: Int
    let pageNum: Int
    let pageSize: Int
    
    /// 下面是对HttpRequest协议的实现
    var path: String {
        return "/resource/getHouseList"
    }
    
    let method: HTTPMethod = .post
    
    var parameters: [String: Any]? {
        return  ["citycode": citycode, "pageNum": pageNum, "pageSize":pageSize]
    }
    
    let requireLogin: Bool = false
    
    typealias Model = HousingResourceListModel
    
}
```



#### 3、发送请求

```
HttpClient.sendRequest(HousingResourceListRequest(citycode: 320100, pageNum: 0, pageSize: 0)) { (result) in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                guard let apiError = error as? LocalizedError else {
                    return
                }
                print(apiError.errorDescription ?? "")
            }
        }
```

请求成功后，返回解析好的model。

 