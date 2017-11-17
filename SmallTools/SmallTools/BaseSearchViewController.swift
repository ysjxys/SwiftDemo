//
//  BaseSearchViewController.swift
//  SmallTools
//
//  Created by ysj on 2017/9/1.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class BaseSearchViewController: UIViewController {
    
    let inputField = CustomTextField()
    let resultLabel = UILabel()
    let searchBtn = UIButton()
    
    var searchBtnClickClosure: ( () -> Void )?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        inputField.keyboardType = .numberPad
        inputField.clearButtonMode = .whileEditing
        inputField.tintColor = UIColor.gray
        inputField.font = UIFont.systemFont(ofSize: 20)
        inputField.layer.cornerRadius = 5
        inputField.layer.borderWidth = 0.5
        inputField.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(inputField)
        inputField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 160, height: 35))
            make.top.equalToSuperview().offset(100)
        }
        inputField.becomeFirstResponder()
        
        let cleanBtn = UIButton()
        cleanBtn.setTitle("清空", for: .normal)
        cleanBtn.setTitle("清空", for: .highlighted)
        cleanBtn.backgroundColor = UIColor.groupTableViewBackground
        cleanBtn.setTitleColor(UIColor
            .black, for: .normal)
        cleanBtn.setTitleColor(UIColor.black, for: .highlighted)
        cleanBtn.addTarget(self, action: #selector(cleanbtnClick), for: .touchUpInside)
        view.addSubview(cleanBtn)
        cleanBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-70)
            make.size.equalTo(CGSize(width: 100, height: 40))
            make.top.equalTo(inputField.snp.bottom).offset(40)
        }
        
        searchBtn.setTitle("查询", for: .normal)
        searchBtn.setTitle("查询", for: .highlighted)
        searchBtn.backgroundColor = UIColor.groupTableViewBackground
        searchBtn.setTitleColor(UIColor
            .black, for: .normal)
        searchBtn.setTitleColor(UIColor.black, for: .highlighted)
        searchBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        view.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(70)
            make.size.equalTo(CGSize(width: 100, height: 40))
            make.top.equalTo(inputField.snp.bottom).offset(40)
        }
        
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        resultLabel.textColor = UIColor.black
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(280)
            make.top.equalTo(searchBtn.snp.bottom).offset(40)
        }
    }
    
    func cleanbtnClick() {
        inputField.text = nil
        resultLabel.text = nil
    }
    
    func searchBtnClick() {
        if let closure = searchBtnClickClosure {
            closure()
        }
    }
}
