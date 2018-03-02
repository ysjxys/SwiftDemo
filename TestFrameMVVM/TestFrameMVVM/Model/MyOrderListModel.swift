//
//  TaskListModel.swift
//  Rider
//
//  Created by ysj on 2017/4/18.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import HandyJSON

struct MyOrderListArrayModel: HandyJSON, Modeling {
    var list: [MyOrderListModel]?
    var pageNo: Int?
    var pageSize: Int?
    var totalSize: Int?
}

struct MyOrderListModel: HandyJSON, Modeling {
    
//    appointTime	预约取货时间	number
    var appointTime: Double?
    
//    deliveryType     订单配送类型   
//    appoint:  预约配送   immediate:   立即配送
    var deliveryType: String?
    
//    acceptTime	接单时间	number
    var acceptTime: Double?
    
//    costTime	配送用时	number	单位：秒
    var costTime: Double?
    
//    deliveryDistance	配送距离	string    //////////
    var deliveryDistance: Double?
    
//    deliveryFee	配送费	string	单位：分
    var deliveryFee: String?
    
////    deliveryTime	送达时间	number
    var deliveryTime: Double?

////////  expectFinishTime  预计送达时间  number
    var expectFinishTime: Double?
    
//    payAmount	收入金额	number	单位：分
    var payAmount: Double?

//    pickTime	取货时间	number
    var pickTime: Double?
    
///////    pickupDistance   取货距离  number
    var pickupDistance: Double?
    
//    receiverAddressCity	市	string
    var receiverAddressCity: String?
    
//    receiverAddressDetail	详细地址	string
    var receiverAddressDetail: String?
    
//    receiverAddressDistrict	区	string
    var receiverAddressDistrict: String?
    
//    receiverAddressProvince	省	string
    var receiverAddressProvince: String?
    
//    receiverAddressStreet	街道	string
    var receiverAddressStreet: String?
    
//    receiverName	收货人姓名	string
    var receiverName: String?
    
//    receiverPhone	收件人电话	string
    var receiverPhone: String?
    
//    senderAddressCity	市	string
    var senderAddressCity: String?
    
//    senderAddressDetail	详细地址	string
    var senderAddressDetail: String?
    
//    senderAddressDistrict	区	string
    var senderAddressDistrict: String?
    
//    senderAddressProvince	省	string
    var senderAddressProvince: String?
    
//    senderAddressStreet	街道	string
    var senderAddressStreet: String?
    
//    senderAvatarUrl	商家头像	string
    var senderAvatarUrl: String?
    
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
    
//    senderLatitude		number
    var senderLatitude: Double?
    
//    senderLongitude		number
    var senderLongitude: Double?
    
//    receiverLatitude		number
    var receiverLatitude: Double?
    
//    receiverLongitude		number
    var receiverLongitude: Double?
    
//    platformSubsidyFee    number
    var platformSubsidyFee: Double?
    
//    platformCode  平台编号string
    var platformCode: String?
    
//    originOrderViewId    平台订单id
    var originOrderViewId: String?

//    updateDate    操作时间
    var updateDate: Double?

//    orderType     配送类型    兔快送订单/一般订单
    var orderType: String?
    
//    cancelReason      订单取消原因
    var cancelReason: String?
    
//    weight     商品重量
    var weight: Double?
    
//    shipment    商品类型
    var shipment: String?
    
//    overTimeStatus    超时状态 0 未超时、 1 即将超时、 2 已超时
    var overTimeStatus: Int?
    
//    overTime      送达超时时间
    var overTime: Int?
    
//     expectAcceptTime    要求取货时间
    var expectAcceptTime: Double?
    
//      unsettledStatus     未妥投状态 ，""：正常  0：处理中   1：已处理
    var unsettledStatus: String?
    
//      unsettledReason     未妥投原因
    var unsettledReason: String?
    
//      promotionActivity   是否为活动订单
    var promotionActivity: Bool?
    
//      cancelTime      订单取消时间
    var cancelTime: Double?
    
//      unsettledTime   未妥投时间
    var unsettledTime: Double?
    
//      pickUpCode      自提码
    var pickUpCode: String?
    
//      expressCompanyName      快递公司名称
    var expressCompanyName: String?
    
//      expectFinishSectionStartTime      预计送达起始时间
    var expectFinishSectionStartTime: Double?
    
    
}
