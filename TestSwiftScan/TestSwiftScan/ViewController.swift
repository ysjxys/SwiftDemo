//
//  ViewController.swift
//  TestSwiftScan
//
//  Created by ysj on 2017/3/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import swiftScan

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "二维码扫描", style: .plain, target: self, action: #selector(scan))
    }
    
    func scan() {
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44
        
        //扫码框周围4个角的类型设置为在框的上面
        style.photoframeAngleStyle = .Outer
        //扫码框周围4个角绘制线宽度
        style.photoframeLineW = 6
        //扫码框周围4个角的宽度
        style.photoframeAngleW = 24
        //扫码框周围4个角的高度
        style.photoframeAngleH = 24
        //显示矩形框
        style.isNeedShowRetangle = true
        //动画类型：网格形式，模仿支付宝
        style.anmiationStyle = .NetGrid
        //网格图片
        style.animationImage = UIImage(named: "timg.jpeg")
        //码框周围4个角的颜色
        style.colorAngle = UIColor(red: 65.0/255.0, green: 174.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        //矩形框颜色
        style.colorRetangleLine = UIColor(red: 247.0/255.0, green: 202.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        //非矩形框区域颜色
        style.red_notRecoginitonArea = 247.0/255.0
        style.green_notRecoginitonArea = 202.0/255.0
        style.blue_notRecoginitonArea = 15.0/255.0
        style.alpa_notRecoginitonArea = 0.2
        
        
        
        let scanVC = ScanViewController()
        scanVC.scanStyle = style
        //开启只识别矩形框内图像功能
        scanVC.isOpenInterestRect = true
        
        _ = navigationController?.pushViewController(scanVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

