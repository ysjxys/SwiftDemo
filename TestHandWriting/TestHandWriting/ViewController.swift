//
//  ViewController.swift
//  TestHandWriting
//
//  Created by ysj on 2017/11/16.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, SignatureViewDelegate {

    let imageView = UIImageView()
    let signatureView = EasySignatureView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("重写", for: .normal)
        cancelBtn.setTitleColor(UIColor.black, for: .normal)
        cancelBtn.backgroundColor = UIColor.purple
        view.addSubview(cancelBtn)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        cancelBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.size.equalTo(CGSize(width: 160, height: 70))
        }
        
        let sureBtn = UIButton()
        sureBtn.setTitle("确认", for: .normal)
        sureBtn.setTitleColor(UIColor.black, for: .normal)
        sureBtn.backgroundColor = UIColor.purple
        view.addSubview(sureBtn)
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
        sureBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(cancelBtn.snp.top).offset(-50)
            make.size.equalTo(CGSize(width: 160, height: 70))
        }
        
        imageView.backgroundColor = UIColor.purple
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(sureBtn.snp.top).offset(-70)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        signatureView.placehold = "我是说明啦"
        signatureView.backgroundColor = UIColor.lightGray
        signatureView.delegate = self
        view.addSubview(signatureView)
        signatureView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 100))
            make.top.equalToSuperview().offset(100)
        }
    }
    
    @objc func sureBtnClick() {
        signatureView.sure()
        if signatureView.hasSignatureImg {
            imageView.image = signatureView.signatureImg
        } else {
            print("no image")
        }
    }
    
    @objc func cancelBtnClick() {
        signatureView.clear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

