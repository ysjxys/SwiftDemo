//
//  IPAddressSearchViewController.swift
//  SmallTools
//
//  Created by ysj on 2017/9/1.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class IPAddressSearchViewController: BaseSearchViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "IP地址查询"
        
        inputField.placeholder = "请输入IP"
        
        searchBtnClickClosure = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            guard let inputText = weakSelf.inputField.text else {
                return
            }
            guard let usrStr = "http://ws.webxml.com.cn/WebServices/IpAddressSearchWebService.asmx/getCountryCityByIp".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return
            }
            
            let param = ["theIpAddress": inputText]
            let manager = AFHTTPSessionManager()
            
            let serializer = AFJSONRequestSerializer()
            serializer.stringEncoding = String.Encoding.utf8.rawValue
            manager.requestSerializer = serializer
            
            manager.responseSerializer = AFHTTPResponseSerializer()
            
            manager.get(usrStr, parameters: param, progress: nil, success: { (task, responseObject) in
                
                guard let data = responseObject as? Data else {
                    weakSelf.resultLabel.text = "查询结果转化data失败"
                    return
                }
                guard let dic = XMLDictionaryParser.sharedInstance().dictionary(with: data) else {
                    weakSelf.resultLabel.text = "查询结果序列化失败"
                    return
                }
                guard let resultArray = dic["string"] as? NSArray else {
                    weakSelf.resultLabel.text = "查询结果转化array失败"
                    return
                }
                var result = ""
                for index in 0..<resultArray.count {
                    let string = resultArray[index] as? String ?? ""
                    result.append(" \(string)")
                }
                weakSelf.resultLabel.text = result
                
            }) { (task, error) in
                print("error:\(error.localizedDescription)")
            }
        }
    }
}
