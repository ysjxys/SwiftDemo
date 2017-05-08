//
//  ViewController.swift
//  TestAllWebRequest
//
//  Created by ysj on 2017/4/5.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://pub-web.leziyou.com/leziyou-web-new/api/v2/channel!childChannel.action"
        let param = ["appId":"129", "id":"1503312", "appCode":"VLG5CFXZ"]
        
        
        let url2 = "http://pub-web.leziyou.com/leziyou-web-new/api/v2/channel!childChannel.action?appId=129&id=1503312&appCode=VLG5CFXZ"
        
        //get
        let url3 = "http://pub-web.leziyou.com/leziyou-web-new/api/v2/topic!types.action"
        
        let url4 = "https://172.16.14.115:9000/person/json"
        
        let url5 = "https://www.tmall.com/"
        
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 15.0
        
        //组装证书数据set
        let cerUrl = Bundle.main.url(forResource: "https", withExtension: "cer")
        var cerDataArray: Set<Data> = []
        
        if let cerUrl = cerUrl{
            do {
                let cerData = try Data(contentsOf: cerUrl)
                cerDataArray.insert(cerData)
                print(cerData)
            } catch _ {
                print("error")
            }
        }
        
        //.none:代表客户端无条件地信任服务器端返回的证书
        //.publicKey:客户端会将服务器端返回的证书与本地保存的证书PublicKey的部分进行校验,如果正确,才继续进行
        //.certificate:客户端会将服务器端返回的证书和本地保存的证书中的所有内容，包括PublicKey和证书部分，全部进行校验;如果正确，才继续进行
        manager.securityPolicy = AFSecurityPolicy(pinningMode: .none, withPinnedCertificates: cerDataArray)
        
        //客户端是否信任非法证书
        manager.securityPolicy.allowInvalidCertificates = true
        
        //是否在证书域字段中验证域名
        manager.securityPolicy.validatesDomainName = false
        
        
        manager.get(url4, parameters: nil, progress: nil, success: { (dataTask, response) in
            print("\(response)")
        }) { (dataTask, error) in
            print(error.localizedDescription)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

