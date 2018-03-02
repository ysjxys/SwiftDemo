//
//  ViewController.swift
//  TestFrameMVVM
//
//  Created by ysj on 2017/12/27.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    var summaryView = MyOrderListSummaryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(summaryView)
        summaryView.tableView.delegate = self
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        OrderListDataController.requestListDataWith(pageNo: 1, pageSize: 10, taskStatus: 2, successed: {
            self.renderViews()
        }) { (error) in
            print("error")
        }
    }
    
    func renderViews() {
        let viewModel = MyOrderListSummaryViewModel(model: OrderListDataController.listArrayModel)
        summaryView.updateViewModel(viewModel: viewModel)
    }
    
}

