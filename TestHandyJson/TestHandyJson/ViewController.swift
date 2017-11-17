//
//  ViewController.swift
//  TestHandyJson
//
//  Created by ysj on 2017/10/27.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import AFNetworking
import SnapKit
import HandyJSON

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
        ysjProtocolRequest()
//        normalProtocolRequest()
    }
    
    func ysjProtocolRequest() {
        let requestData = "{\"userAppointTime\":null,\"consignor\":{\"addressCity\":\"杭州市\",\"addressDetail\":\"长河街道滨兴小区\",\"addressDistrict\":\"滨江区\",\"addressProvince\":\"浙江省\",\"latitude\":30.267446,\"longitude\":120.152791,\"name\":null,\"telephone\":\"15728009399\"},\"orderRemarks\":null,\"receiver\":{\"addressCity\":\"中山市\",\"addressDetail\":\"东福北路50号 诺斯贝尔化妆品股份有限公司\",\"addressDistrict\":\"南头镇\",\"addressProvince\":\"广东省\",\"latitude\":30.287446,\"longitude\":120.172791,\"name\":null,\"telephone\":\"18022011920\"}}"
        
        YSJHttpAPI.send(request: CreateTaskRequest(userId: "76979", requestData: requestData), successHandle: { [weak self] (response) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.codeLable.text = response?.resultData?.orderNo
            
            let orderNoData = response?.resultData?.orderNo?.data(using: String.Encoding.ascii)
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            filter?.setDefaults()
            filter?.setValue(orderNoData, forKey: "inputMessage")
            
            guard let outputImage = filter?.outputImage else {
                return
            }
            
            let scaleX: CGFloat = 300 / outputImage.extent.size.width
            let scaleY: CGFloat = 80 / outputImage.extent.size.height
            let scaleImage = outputImage.transformed(by: CGAffineTransform.init(scaleX: scaleX, y: scaleY))
            weakSelf.imageView.image = UIImage(ciImage: scaleImage)
            
        }, failHandle: { (error) in
            print("fail")
        }) {
            print("net error")
        }
    }
    
    func normalProtocolRequest() {
        codeLable.text = "请求ing..."
        
        guard let usrStr = "http://tubobo-launcher.qafc.ops.com/dak/order/create".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        guard let userId = userIdTextView.text else {
            codeLable.text = "userId不正确"
            return
        }
        
        let param = ["userId": userId,
                     "requestData": "{\"userAppointTime\":null,\"consignor\":{\"addressCity\":\"杭州市\",\"addressDetail\":\"长河街道滨兴小区\",\"addressDistrict\":\"滨江区\",\"addressProvince\":\"浙江省\",\"latitude\":30.267446,\"longitude\":120.152791,\"name\":null,\"telephone\":\"15728009399\"},\"orderRemarks\":null,\"receiver\":{\"addressCity\":\"中山市\",\"addressDetail\":\"东福北路50号 诺斯贝尔化妆品股份有限公司\",\"addressDistrict\":\"南头镇\",\"addressProvince\":\"广东省\",\"latitude\":30.287446,\"longitude\":120.172791,\"name\":null,\"telephone\":\"18022011920\"}}"]
        let manager = AFHTTPSessionManager()
        
        let serializer = AFJSONRequestSerializer()
        serializer.stringEncoding = String.Encoding.utf8.rawValue
        manager.requestSerializer = serializer
        
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        manager.post(usrStr, parameters: param, progress: nil, success: { [weak self] (task, responseObject) in
            guard let weakSelf = self else {
                return
            }
            guard let data = responseObject as? Data else {
                weakSelf.codeLable.text = "查询结果转化data失败"
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                
                let result = CreateTaskModel.deserialize(from: json)
                weakSelf.codeLable.text = result?.resultDesc
            } catch _ {
                weakSelf.codeLable.text = "返回值解析错误"
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

