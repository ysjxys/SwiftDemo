//
//  ViewController.swift
//  TestFDTemplateLayoutCell
//
//  Created by ysj on 2017/5/8.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import SnapKit
import UITableView_FDTemplateLayoutCell

enum CellType {
    case showName
    case showImage
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: [TestModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //每增加146个字符，会增加一层留白
        
        let model1 = TestModel()
        model1.image = #imageLiteral(resourceName: "about_icon")
        model1.name = "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题1"//145--0
        
        let model2 = TestModel()
        model2.image = #imageLiteral(resourceName: "about_icon")
        model2.name = "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题11"//146--1
        
        let model3 = TestModel()
        model3.image = #imageLiteral(resourceName: "about_icon")
        model3.name = "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题11我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标1"//289--1
        
        let model4 = TestModel()
        model4.image = #imageLiteral(resourceName: "about_icon")
        model4.name = "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题11我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标11"//290--2
        
        let model5 = TestModel()
        model5.image = #imageLiteral(resourceName: "about_icon")
        model5.name = "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题11"//434
        
        let model6 = TestModel()
        model6.image = #imageLiteral(resourceName: "about_icon")
        model6.name = "我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题111111111111题我是标题题我是标题题我是标题题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题111111111111题我是标题题我是标题题我是标题题我是标题"//484
        
        dataArray.append(model1)
        dataArray.append(model2)
        dataArray.append(model3)
        dataArray.append(model4)
        dataArray.append(model5)
        dataArray.append(model6)
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TestCell.self, forCellReuseIdentifier: "cell")
        tableView.fd_debugLogEnabled = true
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.fd_heightForCell(withIdentifier: "cell", cacheBy: indexPath, configuration: { (make) in
            let cell = make as! TestCell
            cell.initView()
            cell.setData(type: indexPath.row%2 == 0 ? .showName : .showImage, model: self.dataArray[indexPath.row])
        })

        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TestCell
        cell.initView()
        cell.setData(type: indexPath.row%2 == 0 ? .showName : .showImage, model: self.dataArray[indexPath.row])
        return cell
    }

}

