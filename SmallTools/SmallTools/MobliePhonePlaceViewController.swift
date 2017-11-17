//
//  MobliePhonePlaceViewController.swift
//  SmallTools
//
//  Created by ysj on 2017/8/30.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class MobliePhonePlaceViewController: BaseSearchViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "手机号归属地查询"
        
        inputField.placeholder = "请输入手机号"
        
        searchBtnClickClosure = { [weak self] in
            guard let weakSelf = self else {
                return
            }
            guard let inputText = weakSelf.inputField.text else {
                return
            }
            //1、忘记了utf8序列化
            guard let usrStr = "http://ws.webxml.com.cn/WebServices/MobileCodeWS.asmx/getMobileCodeInfo".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                return
            }
            //2、忘记了iOS9以来的http请求限制
            //3、xml格式需添加到序列化参数内
            let param = ["mobileCode": inputText, "userID": ""]
            let manager = AFHTTPSessionManager()
            
            //1.1、usrStr 不单独序列化，则必须指定request序列化
            let serializer = AFJSONRequestSerializer()
            serializer.stringEncoding = String.Encoding.utf8.rawValue
            manager.requestSerializer = serializer
            //4、response必须序列化
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
                guard let result = dic["__text"] as? String else {
                    weakSelf.resultLabel.text = "查询结果转化string失败"
                    return
                }
                weakSelf.resultLabel.text = result
                
            }) { (task, error) in
                print("error:\(error.localizedDescription)")
            }
        }
    }
}
