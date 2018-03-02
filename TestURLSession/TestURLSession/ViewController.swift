//
//  ViewController.swift
//  TestURLSession
//
//  Created by ysj on 2018/2/1.
//  Copyright © 2018年 ysj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = CGFloat(1)
        btn.setTitle("连接", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func btnClick() {
        let url = URL(string: "https://test.toobob.com/tbbexpressqafc/user/login")
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = ["phone": "15967176094", "password": "12345678".aes128Encrypt].toData()
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let dic = data?.toDictionary()
            print(dic)
        }
        dataTask.resume()
    }
}

