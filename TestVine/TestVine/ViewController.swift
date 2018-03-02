//
//  ViewController.swift
//  TestVine
//
//  Created by ysj on 2018/2/26.
//  Copyright © 2018年 ysj. All rights reserved.
//

import UIKit

var token = ""

class ViewController: UIViewController {
    
    var refreshToken: String = "" {
        didSet {
            token = refreshToken
            getCompany()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 200, y: 300, width: 150, height: 60))
        btn.setTitle("测试", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = CGFloat(1)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)

    }
    
    @objc func btnClick() {
        loginConnect()
    }
    
    func loginConnect() {
        print("login start")
        HttpAPI.send(res: LoginRequest(phone: "15967176094", password: "kH0E7nrw38h5Z6udxUPOFg==")) {
            switch $0 {
            case .success(let model):
                print(model)
                self.refreshToken = model.token ?? ""
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCompany() {
        print("getCompany start")
        
        HttpAPI.send(res: ExpressCompanyRequest(type: "expressCompany")) {
            switch $0 {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

