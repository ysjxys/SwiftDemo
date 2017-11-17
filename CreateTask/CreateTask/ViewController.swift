//
//  ViewController.swift
//  CreateTask
//
//  Created by ysj on 2017/10/24.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import AFNetworking
import SnapKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let createBtn = UIButton()
    let codeLable = UILabel()
    let userIdTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
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
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                guard let dic = json as? Dictionary<String, Any> else {
                    weakSelf.codeLable.text = "获取结果转化字典失败"
                    return
                }
                guard let resultCodeAny = dic["resultCode"] else {
                    weakSelf.codeLable.text = "获取查询结果码失败"
                    return
                }
                guard let resultCodeInt = resultCodeAny as? String else {
                    weakSelf.codeLable.text = "获取查询结果码失败"
                    return
                }
                if resultCodeInt != "0" {
                    weakSelf.codeLable.text = "查询失败"
                    return
                }
                guard let resultDic = dic["resultData"] as? Dictionary<String, Any> else {
                    weakSelf.codeLable.text = "获取查询编码字典失败"
                    return
                }
                guard let orderNo = resultDic["orderNo"] as? String else {
                    weakSelf.codeLable.text = "获取查询编码失败"
                    return
                }
                print(orderNo)
                weakSelf.codeLable.text = orderNo
                
                let orderNoData = orderNo.data(using: String.Encoding.ascii)
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
                
            } catch _ {
                weakSelf.codeLable.text = "返回值解析错误"
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

