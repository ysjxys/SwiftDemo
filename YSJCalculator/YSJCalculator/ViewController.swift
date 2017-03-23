//
//  ViewController.swift
//  YSJCalculator
//
//  Created by ysj on 2017/2/24.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //结果显示栏 或者说 输入显示栏
    @IBOutlet weak var resultLabel: UILabel!
    //过程显示栏
    @IBOutlet weak var contentLabel: UILabel!
    
    var inputValue = "0"
    var showValue = "0"
    
    var num1: Double = 0
    var num2: Double = 0
    var operatorSign = ""
    var result: Double = 0
//    var shouldInputFromStart = true
    var isNum1Init = false
    var isNum2Init = false
    var isContinuousEqual = false
    
    
    
    
    
    //初始化方法
    override func viewDidLoad() {
        super.viewDidLoad()
        clearBtnClick(view)
    }
    
    //按下按钮添加信息
    func inputAppend(newValue: String) {
//        if shouldInputFromStart {
//            inputValue = "0"
//        }
        if newValue == "error" {
            inputValue = "0"
            resultLabel.text = newValue
            info()
            return
        }
        // x/0
        if resultLabel.text == "0" && newValue == "0"{
            return
        }
        //去掉0
        if inputValue == "0" {
            inputValue = newValue
            resultLabel.text = inputValue
            info()
            return
        }
        
        
        //取得结果栏的值，在末尾添加新输入的信息，重新在结果栏上显示
        inputValue = inputValue.appending(newValue)
        resultLabel.text = inputValue
//        shouldInputFromStart = false
        isNum2Init = false
        isContinuousEqual = true
        info()
    }
    
    //内部计算
    func calculate() {
        if operatorSign == "/" && num2 == 0 {
            resultLabel.text = "error"
            return
        }
        switch operatorSign {
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "*":
            result = num1 * num2
        case "/":
            result = num1 / num2
        default:
            resultLabel.text = "error"
        }
        num1 = result
        isNum2Init = false
        resultLabel.text = String(result)
    }
    
    func info() {
        print("---------------------")
        print("inputValue:\(inputValue)")
        print("num1:\(num1)")
        print("num2:\(num2)")
        print("operatorSign:\(operatorSign)")
        print("result:\(result)")
//        print("shouldInputFromStart:\(shouldInputFromStart)")
        print("isNum1Init:\(isNum1Init)")
        print("isNum2Init:\(isNum2Init)")
        print("isContinuousEqual:\(isContinuousEqual)")
        print("---------------------")
    }
    
    func cleanData() {
        inputValue = "0"
        num1 = 0
        num2 = 0
        operatorSign = ""
        result = 0
//        shouldInputFromStart = true
        isNum1Init = false
        isNum2Init = false
        isContinuousEqual = false
    }
    
    func cleanLabels() {
        contentLabel.text = "0"
        resultLabel.text = "0"
    }
    
    //按下0~9的数字
    @IBAction func zeroNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "0")
    }
    @IBAction func oneNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "1")
    }
    @IBAction func twoNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "2")
    }
    @IBAction func threeNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "3")
    }
    @IBAction func fourNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "4")
    }
    @IBAction func fiveNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "5")
    }
    @IBAction func sixNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "6")
    }
    @IBAction func sevenNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "7")
    }
    @IBAction func eightNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "8")
    }
    @IBAction func nineNumBtnClick(_ sender: Any) {
        inputAppend(newValue: "9")
    }
    //按下"."
    @IBAction func dotBtnClick(_ sender: Any) {
        if resultLabel.text!.contains(".") {
            return
        }
        inputAppend(newValue: ".")
    }
    //按下"="
    @IBAction func resultBtnClick(_ sender: Any) {
        if let value = Double(inputValue) {
            if isNum1Init == false {
                num1 = value
                inputValue = "0"
                isNum1Init = true
            }else if isNum2Init == false{
                num2 = value
//                inputValue = "0"
//                isNum2Init = true
                isContinuousEqual = true
                calculate()
            }
        }
        info()
    }
    
    func calculatorSignClick() {
        if isContinuousEqual {
            isContinuousEqual = false
            isNum2Init = false
//            isNum1Init = false
            inputValue = "0"
            num1 = result
            return
        }
//        if let value = Double(inputValue) {
        print(resultLabel.text!)
        if let value = Double(resultLabel.text!) {
            if isNum1Init == false {
                num1 = value
                inputValue = "0"
                isNum1Init = true
            }else if isNum2Init == false{
                num2 = value
                inputValue = "0"
                isNum2Init = true
                calculate()
            }
        }
        info()
    }
    //按下"/"
    @IBAction func divisionBtnClick(_ sender: Any) {
        calculatorSignClick()
        operatorSign = "/"
    }
    //按下"*"
    @IBAction func multipBtnClick(_ sender: Any) {
        calculatorSignClick()
        operatorSign = "*"
    }
    //按下"-"
    @IBAction func subBtnClick(_ sender: Any) {
        calculatorSignClick()
        operatorSign = "-"
    }
    //按下"+"
    @IBAction func plusBtnClick(_ sender: Any) {
        calculatorSignClick()
        operatorSign = "+"
    }
    //按下"-/+"
    @IBAction func minusBtnClick(_ sender: Any) {
    }
    //按下"CA"
    @IBAction func clearBtnClick(_ sender: Any) {
        cleanData()
        cleanLabels()
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

