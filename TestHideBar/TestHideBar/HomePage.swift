//
//  ViewController.swift
//  TestHideBar
//
//  Created by ysj on 2017/1/17.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

struct CellData {
    var title: String
    var firstVCName: String
    var secondVCName: String
}

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    lazy var appName: String = {
        guard let tempName: String = Bundle.main.infoDictionary!["CFBundleName"] as? String else {
            return ""
        }
        return tempName
    }()
    
    var dataArr = [CellData]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.setStatusBarHidden(false, with: .slide)
        UIView.animate(withDuration: 0.4) {
            self.tabBarController?.tabBar.alpha = 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let titleArray = ["StatusBarShowTT",
                          "StatusBarShowTF",
                          "StatusBarShowFT",
                          "StatusBarShowFF",
                          "NavBarShowTT",
                          "NavBarShowTF",
                          "NavBarShowFT",
                          "NavBarShowFF",
                          "TabBarShowTT",
                          "TabBarShowTF",
                          "TabBarShowFT",
                          "TabBarShowFF"]
        
        for i in 0..<titleArray.count {
            dataArr.append(CellData(title: titleArray[i], firstVCName: "\(appName).\(titleArray[i])1", secondVCName: "\(appName).\(titleArray[i])2"))
        }
        
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        
        let cellData = dataArr[indexPath.row]
        cell?.textLabel?.text = cellData.title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellData = dataArr[indexPath.row]
        
        guard let firstVCType = NSClassFromString(cellData.firstVCName) as? BaseViewController.Type else {
            print("BaseViewController is nil")
            return
        }
        let firstVC = firstVCType.init()
        firstVC.title = cellData.title
        firstVC.secondVCName = cellData.secondVCName
        if firstVC.title == "NavBarShowFT" || firstVC.title == "NavBarShowFF" {
//            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        navigationController?.pushViewController(firstVC, animated: true)
    }
}

