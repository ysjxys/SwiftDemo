//
//  HomeViewController.swift
//  SmallTools
//
//  Created by ysj on 2017/8/30.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import SnapKit

struct Tool {
    let desc: String
    let vcType : UIViewController.Type
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: [Tool] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        dataArray.append(Tool(desc: "手机号归属地查询", vcType: type(of: MobliePhonePlaceViewController())))
        dataArray.append(Tool(desc: "IP地址查询", vcType: type(of: IPAddressSearchViewController())))
        
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataArray[indexPath.row].desc
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = dataArray[indexPath.row].vcType.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}
