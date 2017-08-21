//
//  ViewController.swift
//  TestCoreAnimation
//
//  Created by ysj on 2017/7/10.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArr: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr.append("基础动画")
        dataArr.append("关键帧动画")
        dataArr.append("组合动画")
        dataArr.append("过渡动画")
        dataArr.append("综合")
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = dataArr[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var vc: UIViewController = UIViewController()
        
        switch indexPath.row {
        case 0:
            print("0")
            vc = BasicAnimationViewController()
        case 1:
            print("1")
            vc = KeyFrameAnimationViewController()
        case 2:
            print("2")
            vc = AnimationGroupViewController()
        case 3:
            print("3")
            vc = TransitionViewController()
        case 4:
            print("4")
            vc = CompositeViewController()
        default:
            return
        }
        
        vc.navigationItem.title = dataArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

