//
//  MainViewController.swift
//  TestMVVM
//
//  Created by ysj on 2017/8/22.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    var model: MyOrderDetailModel = MyOrderDetailModel.fromDictionary(dic: [
        "taskNo": "031708160000246",
        "taskStatus": 4,
        "senderPhone": "13732259026",
        "senderName": "测试新光店铺哦婆婆婆婆行尸走肉我无所谓呀",
        "senderAvatarUrl": "",
        "senderAddressProvince": "浙江省",
        "senderAddressCity": "杭州市",
        "senderAddressDistrict": "上城区",
        "senderAddressStreet": "14路;20路;39路;39路区间;44路;59路;60路;176路;202路;216路;322路;360路;516路;595A路;595路B;597路;新登-杭州九堡(客运中心);杭州九堡(客运中心)-新登;社区微公交1604(M)路",
        "senderAddressDetail": "近江村(公交站)破哦婆婆婆婆哦婆婆坡沟沟坡了婆婆就颇咯啦",
        "senderLongitude": 120.193398,
        "senderLatitude": 30.239019,
        "tipFee": 0,
        "deliveryFee": 300,
        "payAmount": 880,
        "platformSubsidyFee": 250,
        "receiverName": "秘密哦坡哦哦婆婆 Rom哦婆婆",
        "receiverPhone": "15067199246",
        "receiverAddressProvince": "浙江省",
        "receiverAddressCity": "杭州市",
        "receiverAddressDistrict": "上城区",
        "receiverAddressStreet": "14路;20路;39路;39路区间;44路;59路;60路;176路;202路;216路;322路;360路;516路;595A路;595路B;597路;新登-杭州九堡(客运中心);杭州九堡(客运中心)-新登;社区微公交1604(M)路",
        "receiverAddressDetail": "近江村(公交站)当前进度：完成兔波波众包8.17版本各端部分用例编写 今天计划:  兔波波众包8.17版本各端用例编写 需要支持 :无 需要当前进度：完成兔波波众包8.17版本各端部分用例编写 今天资源：无 风险：无",
        "receiverLongitude": 120.193398,
        "receiverLatitude": 30.239019,
        "deliveryDistance": 1.0,
        "pickupDistance": 1243.0,
        "expectFinishTime": 1502860157000,
        "pickTime": 1502876345000,
        "deliveryTime": 1503307353000,
        "acceptTime": 1502860097000,
        "cancelTime": "",
        "cancelReason": "",
        "updateDate": 1503307353000,
        "costTime": 447256,
        "orderType": "",
        "peekOverFee": 212,
        "weatherOverFee": 118,
        "platformCode": "",
        "originOrderViewId": ""])
    
    var mainViewModel: MainViewOrderDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewModel = MainViewOrderDetailModel(model: model)
        
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        view.addSubview(label)
        
        label.text = mainViewModel?.customerAddress
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("MainViewController")
    }
}
