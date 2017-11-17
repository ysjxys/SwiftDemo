//
//  ViewController.swift
//  TestNSURLSesion
//
//  Created by ysj on 2017/11/8.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 150, y: 200, width: 100, height: 40))
        button.setTitle("我是标题", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func btnClick() {
//        guard let urlStr = "http://tubobo-launcher.qafc.ops.com/dak/order/create".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
//            return
//        }
        let urlStr = "http://tubobo-launcher.qafc.ops.com/dak/order/create"
        guard let url = URL(string: urlStr) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let param = ["userId": 76979,"requestData": "{\"userAppointTime\":null,\"consignor\":{\"addressCity\":\"杭州市\",\"addressDetail\":\"长河街道滨兴小区\",\"addressDistrict\":\"滨江区\",\"addressProvince\":\"浙江省\",\"latitude\":30.267446,\"longitude\":120.152791,\"name\":null,\"telephone\":\"15728009399\"},\"orderRemarks\":null,\"receiver\":{\"addressCity\":\"中山市\",\"addressDetail\":\"东福北路50号 诺斯贝尔化妆品股份有限公司\",\"addressDistrict\":\"南头镇\",\"addressProvince\":\"广东省\",\"latitude\":30.287446,\"longitude\":120.172791,\"name\":null,\"telephone\":\"18022011920\"}}"] as [String : Any]
        request.httpBody = jsonToData(jsonDic: param)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                print(self.dataToDictionary(data: data!))
            } catch _ {
                print("返回值解析错误")
            }
        }
        task.resume()
    }
    
    func dataToDictionary(data: Data) -> Dictionary<String, Any>? {
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as? Dictionary<String, Any>
            return dic
        } catch _ {
            print("失败")
            return nil
        }
    }
    
    func jsonToData(jsonDic: Dictionary<String, Any>) -> Data? {
        if(!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("is not a valid json object")
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        print("Json Str:\(str!)")
        return data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

