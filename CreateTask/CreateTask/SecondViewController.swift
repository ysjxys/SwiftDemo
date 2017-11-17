//
//  SecondViewController.swift
//  CreateTask
//
//  Created by ysj on 2017/11/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AFNetworking

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let createTaskBtn = UIButton()
        createTaskBtn.setTitleColor(UIColor.black, for: .normal)
        createTaskBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        createTaskBtn.backgroundColor = UIColor.lightGray
        createTaskBtn.addTarget(self, action: #selector(createTaskBtnClick), for: .touchUpInside)
        view.addSubview(createTaskBtn)
        createTaskBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(80)
            make.top.equalToSuperview().offset(180)
        }
    }
    
    @objc func createTaskBtnClick() {
        guard let usrStr = "http://172.16.14.164:8090/wx/express/fast/billV2".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        let param = [
            "deliveryDistance": "1.2",
            "receiverAddrId":"1",
            "senderAddrId":"1",
            "shipment":"柚子",
            "tip":"0",
            "weight":"1",
            "deveryFee":"1.2",
            "deliveryFee":"1.3",
            "diu":"IDFV",
            "receiverInfo": [
                "receiverAddr": "string",
                "receiverDetailAddr": "string",
                "receiverLatitude": 30.231139,
                "receiverLongitude": 120.284289,
                "receiverName": "string",
                "receiverPhone": "15712312312"
            ],
            "senderInfo": [
                "senderAddr": "string1",
                "senderDetailAddr": "string1",
                "senderLatitude": 30.230904,
                "senderLongitude": 120.196409,
                "senderName": "string",
                "senderPhone": "15712312312"
            ]
        ] as [String : Any]
        
        let manager = AFHTTPSessionManager()
        
        let serializer = AFJSONRequestSerializer()
        serializer.setValue("73DC46A3E25041ED16B2DE95255D7B7987AE0A22461FA890CBB984205A898B66D2D195CBC944AC2E63DAAF116C0F0DBA9765A481E8120EC3E09210B390CDB12949E6456521B6E675E590F42905D23BE6C0AFFE49BE6FC59A066B188FA2F35A762D05BC919E6C55E43B65FF80EB942D6A373CF8E5C7B1D5AFE2CCE35268189F94D9C41DD6010DEC1EC458CF007C80182418185354D2F6DB307B98C289D3E4D9ABB8569615D06F4C397E95EADDBECC226791AEB42517DFAD37ED1B9FAA415A4AE8C83EF71C3F371886F15017FF8D75225B8DFA54FA6291EBE977ED87CC175758998067519DBF635A67D695556EC89875F42F79DF067E69079084DBC9AAD2CA681FEEFEE2559C3E16855CDC2D3914DA657764358FF47C22BC924B5A693C8712F29EAD64A933C622FC2B74BF0725AB91EDAD7956B9AE8CC8E61B3E893B5864C4F0DD4D7116E01B549C7DA93E4CD1526CC89D33C8C3D24B2F505F70B1EF3C64023DA85D8F3F576E8E66586C1A0B87A8C74ECA7F9FD7204CB1EC76CDC132412693C5EA4D30BA3C29C4C0F082CDE02D6BD4C6FFF713E66069BD6CB10A63A03A3D931AB4454AD5623FA4526892B98A7B1AA1A3792ED841D9D45CDDC4F1C7C19B76732F9D", forHTTPHeaderField: "token")
        serializer.stringEncoding = String.Encoding.utf8.rawValue
        manager.requestSerializer = serializer
        
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        manager.post(usrStr, parameters: param, progress: nil, success: { (task, response) in
            guard let data = response as? Data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                guard let dic = json as? Dictionary<String, Any> else {
                    return
                }
                print(dic)
            } catch _ {
                print("error")
            }
        }, failure: nil)
    }
}
