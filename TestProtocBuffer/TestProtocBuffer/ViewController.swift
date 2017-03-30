//
//  ViewController.swift
//  TestProtocBuffer
//
//  Created by ysj on 2017/3/24.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import ProtocolBuffers

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //组装PB格式数据
        let personBuilder = PersonProto().getBuilder()
        personBuilder.setAge(12)
        personBuilder.setFirstName("hehe")
        personBuilder.setSecondName("haha")
        let aeraNum = try! PersonProto.PhoneNumber.getBuilder().setAreaCode(123).build()
        let photoNum = try! PersonProto.PhoneNumber.getBuilder().setAreaCode(223).build()
        personBuilder.setPhoneNumbers([aeraNum, photoNum])
        
        let person = try! personBuilder.build()
        print(person)
        //数据data化，此时可用于网络传输
        let data = person.data()
        //大小为 23 bytes
        print(data)
        //data数据PB化，相当于从服务器获取数据并解析
        let personFromData = try! PersonProto.parseFrom(data: data)
        print(personFromData)
        
        
        //组装传统的json类似数据，输出大小为 132 bytes
        let json = ["age": 12, "firstName": "hehe", "secondName":"haha", "photoNum": ["photoNum1": 123, "photoNum2": 223]] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        print(jsonData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

