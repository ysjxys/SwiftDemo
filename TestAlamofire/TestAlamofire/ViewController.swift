//
//  ViewController.swift
//  TestAlamofire
//
//  Created by ysj on 2017/11/1.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {

    let imageView = UIImageView()
    let createBtn = UIButton()
    let codeLable = UILabel()
    let userIdTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = #imageLiteral(resourceName: "1489485242539Git常用操作")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.purple
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalToSuperview().offset(150)
            make.height.equalTo(80)
        }
        
        userIdTextView.text = "76979"
        userIdTextView.keyboardType = .numberPad
        userIdTextView.font = UIFont.systemFont(ofSize: 20)
        userIdTextView.textColor = UIColor.black
        userIdTextView.textAlignment = .center
        view.addSubview(userIdTextView)
        userIdTextView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(80)
            make.height.equalTo(40)
        }
        
        codeLable.text = "在上方输入userId"
        codeLable.font = UIFont.systemFont(ofSize: 20)
        codeLable.textColor = UIColor.black
        codeLable.textAlignment = .center
        view.addSubview(codeLable)
        codeLable.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(userIdTextView.snp.bottom).offset(80)
        }
        
        createBtn.setTitle("生成", for: .normal)
        createBtn.setTitleColor(UIColor.black, for: .normal)
        createBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        createBtn.backgroundColor = UIColor.lightGray
        createBtn.addTarget(self, action: #selector(createBtnClick), for: .touchUpInside)
        view.addSubview(createBtn)
        createBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(80)
            make.top.equalTo(codeLable.snp.bottom).offset(80)
        }
        
    }
    
    @objc func createBtnClick() {
        
        do {
            let url = try "http://tubobo-launcher.qafc.ops.com/dak/order/create".asURL()
            
            let param = ["userId": "76979",
            "requestData": "{\"userAppointTime\":null,\"consignor\":{\"addressCity\":\"杭州市\",\"addressDetail\":\"长河街道滨兴小区\",\"addressDistrict\":\"滨江区\",\"addressProvince\":\"浙江省\",\"latitude\":30.267446,\"longitude\":120.152791,\"name\":null,\"telephone\":\"15728009399\"},\"orderRemarks\":null,\"receiver\":{\"addressCity\":\"中山市\",\"addressDetail\":\"东福北路50号 诺斯贝尔化妆品股份有限公司\",\"addressDistrict\":\"南头镇\",\"addressProvince\":\"广东省\",\"latitude\":30.287446,\"longitude\":120.172791,\"name\":null,\"telephone\":\"18022011920\"}}"]
            
            Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                print(response)
            })
            
        } catch  {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

