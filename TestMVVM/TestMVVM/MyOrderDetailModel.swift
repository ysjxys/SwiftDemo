//
//  MyOrderDetailModel.swift
//  TestMVVM
//
//  Created by ysj on 2017/8/22.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation

struct MyOrderDetailModel {
    //    appointTime	预约取货时间	number
    var appointTime: Double?
    
    //    deliveryType     订单配送类型
    //    appoint:  预约配送   immediate:   立即配送
    var deliveryType: String?
    
    //    acceptTime	接单时间	number 毫秒
    var acceptTime: Double?
    
    //    costTime	配送用时	number	单位：秒
    var costTime: Double?
    
    //    deliveryDistance	配送距离	string  ////
    var deliveryDistance: Double?
    
    //    deliveryFee	配送费	string	单位：分
    var deliveryFee: String?
    
    //    deliveryTime	送达时间	number
    var deliveryTime: Double?
    
    ///////    expectFinishTime  预计送达时间   number
    var expectFinishTime: Double?
    
    //    payAmount	收入金额	number	单位：分
    var payAmount: Double?
    
    //    pickTime	取货时间	number
    var pickTime: Double?
    
    ///////     pickupDistance   取货距离
    var pickupDistance: Double?
    
    //    receiverAddressCity		string
    var receiverAddressCity: String?
    
    //    receiverAddressDetail		string
    var receiverAddressDetail: String?
    
    //    receiverAddressDistrict		string
    var receiverAddressDistrict: String?
    
    //    receiverAddressProvince		string
    var receiverAddressProvince: String?
    
    //    receiverAddressStreet		string
    var receiverAddressStreet: String?
    
    //    receiverLatitude		number
    var receiverLatitude: Double?
    
    //    receiverLongitude		number
    var receiverLongitude: Double?
    
    //    receiverName	收货人姓名	string
    var receiverName: String?
    
    //    receiverPhone	收件人电话	string
    var receiverPhone: String?
    
    //    senderAddressCity		string
    var senderAddressCity: String?
    
    //    senderAddressDetail		string
    var senderAddressDetail: String?
    
    //    senderAddressDistrict		string
    var senderAddressDistrict: String?
    
    //    senderAddressProvince		string
    var senderAddressProvince: String?
    
    //    senderAddressStreet		string
    var senderAddressStreet: String?
    
    //    senderAvatarUrl	商家头像	string
    var senderAvatarUrl: String?
    
    //    senderLatitude		number
    var senderLatitude: Double?
    
    //    senderLongitude		number
    var senderLongitude: Double?
    
    //    senderName	商家名称	string
    var senderName: String?
    
    //    senderPhone	商家电话	string
    var senderPhone: String?
    
    //    taskNo	任务单号	string
    var taskNo: String?
    
    //    taskStatus	任务状态	string
    var taskStatus: String?
    
    //    tipFee	小费	string	单位：分
    var tipFee: String?
    
    //    商户图片，长连接转换接口特供
    var shopUrls: [String]?
    
    //    高峰溢价
    var peekOverFee: Double?
    
    //    天气溢价
    var weatherOverFee: Double?
    
    //    平台补贴    number
    var platformSubsidyFee: Double?
    
    //    platformCode  平台编号string
    var platformCode: String?
    
    //    originOrderViewId    平台订单id
    var originOrderViewId: String?
    
    //    updateDate    操作时间
    var updateDate: Double?
    
    //    overTime      送达超时时间
    var overTime: Int?
    
    static func fromDictionary(dic: Dictionary<String, Any>) -> MyOrderDetailModel {
        var model = MyOrderDetailModel()
        model.senderAddressDistrict = dic["senderAddressDistrict"] as? String
        model.senderAddressCity = dic["senderAddressCity"] as? String
        model.senderAddressProvince = dic["senderAddressProvince"] as? String
        model.senderAvatarUrl = dic["senderAvatarUrl"] as? String
        model.senderName = dic["senderName"] as? String
        model.senderPhone = dic["senderPhone"] as? String
        model.taskStatus = dic["taskStatus"] as? String
        model.taskNo = dic["taskNo"] as? String
        model.weatherOverFee = dic["weatherOverFee"] as? Double
        model.peekOverFee = dic["peekOverFee"] as? Double
        model.costTime = dic["costTime"] as? Double
        model.updateDate = dic["updateDate"] as? Double
        model.acceptTime = dic["acceptTime"] as? Double
        model.deliveryTime = dic["deliveryTime"] as? Double
        model.pickTime = dic["pickTime"] as? Double
        model.expectFinishTime = dic["expectFinishTime"] as? Double
        model.pickupDistance = dic["pickupDistance"] as? Double
        model.deliveryDistance = dic["deliveryDistance"] as? Double
        model.receiverLatitude = dic["receiverLatitude"] as? Double
        model.receiverLongitude = dic["receiverLongitude"] as? Double
        model.receiverAddressDetail = dic["receiverAddressDetail"] as? String
        model.receiverAddressStreet = dic["receiverAddressStreet"] as? String
        model.receiverAddressDistrict = dic["receiverAddressDistrict"] as? String
        model.receiverAddressCity = dic["receiverAddressCity"] as? String
        model.receiverAddressProvince = dic["receiverAddressProvince"] as? String
        model.receiverPhone = dic["receiverPhone"] as? String
        model.receiverName = dic["receiverName"] as? String
        model.platformSubsidyFee = dic["platformSubsidyFee"] as? Double
        model.payAmount = dic["payAmount"] as? Double
        model.deliveryFee = dic["deliveryFee"] as? String
        model.tipFee = dic["tipFee"] as? String
        model.senderLatitude = dic["senderLatitude"] as? Double
        model.senderLongitude = dic["senderLongitude"] as? Double
        model.senderAddressStreet = dic["senderAddressStreet"] as? String
        return model
    }
    
}
