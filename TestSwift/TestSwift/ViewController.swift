//
//  ViewController.swift
//  TestSwift
//
//  Created by ysj on 16/8/18.
//  Copyright © 2016年 yushengjie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
        
        
        let con = 1
        let hehe2:Double = 1
        //var 作为变量  不重新赋值会报错
        var hehe = "haha"
        hehe = "xxxx"
        //print 近似于java
        print("like java",con,"this",hehe2,"fuck",hehe)
        
        
        let combie = hehe + String(con)
        print(combie)
        let combie2 = "this also can \(hehe) \(con)"
        print(combie2)
        
        
        var varList = ["1","2","3"]
        varList[0] = "change"
        print(varList)
        var varDic = ["key0":"value0","key1":"value1","key2":"value2"]
        varDic["key0"] = "changeValue"
        print(varDic)
        let emptyList = []
        let emp = []
        print(emptyList,emp)
        
        
        for value in varList {
            print("for value:",value)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

