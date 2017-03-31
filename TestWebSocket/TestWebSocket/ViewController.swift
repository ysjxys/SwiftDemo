//
//  ViewController.swift
//  TestWebSocket
//
//  Created by ysj on 2017/3/30.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, WebSocketDelegate {

    //ws://172.16.14.115:20000/
    var socket = WebSocket(url: URL(string: "ws://127.0.0.1:20000/webSocket")!, protocols: ["chat", "superchat"])
    var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.delegate = self
        socket.connect()
        print("start")
        
        textView.frame = CGRect(x: 100, y: 150, width: (view.frame.width-100*2), height: 200)
        textView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        textView.layer.borderWidth = 0.5
        textView.textColor = UIColor.black
        view.addSubview(textView)
        
        let btnSend = UIButton()
        btnSend.frame = CGRect(x: 100, y: 400, width: (view.frame.width-100*2), height: 50)
        btnSend.setTitle("发送", for: .normal)
        btnSend.setTitleColor(UIColor.black, for: .normal)
        btnSend.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(btnSend)
        btnSend.addTarget(self, action: #selector(sendBtnClick), for: .touchUpInside)
        
        let btnClean = UIButton(frame: CGRect(x: 100, y: 500, width: btnSend.frame.width, height: 50))
        btnClean.setTitle("清空", for: .normal)
        btnClean.setTitleColor(UIColor.black, for: .normal)
        btnClean.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(btnClean)
        btnClean.addTarget(self, action: #selector(cleanBtnClick), for: .touchUpInside)
    }
    
    func sendBtnClick() {
        print("text:\(textView.text)")
        socket.write(string: textView.text)
    }
    
    func cleanBtnClick() {
        textView.text = ""
    }
    
    func websocketDidConnect(socket: WebSocket) {
        print("websocketDidConnect")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocketDidDisconnect")
        print("\(error?.localizedDescription)")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("websocketDidReceiveMessage")
        print("text:\(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("websocketDidReceiveData")
        print("data:\(data)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

