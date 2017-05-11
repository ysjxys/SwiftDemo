//
//  Marco.swift
//  TestFDTemplateLayoutCell
//
//  Created by ysj on 2017/5/8.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

private func adjustValue(_ value: CGFloat) -> CGFloat{
    var result = floor(value)
    let interval: CGFloat = 0.5
    let gap = value - result
    if gap >= 0.5 {
        result += interval
    }
    return result
}

public let WidthScreen: CGFloat = UIScreen.main.bounds.size.width
public let HeightScreen: CGFloat = UIScreen.main.bounds.size.height
public let Ratio_Scale: CGFloat = WidthScreen / CGFloat(375)

public func UIScale(_ x: CGFloat) -> CGFloat {
    return adjustValue(x * Ratio_Scale)
}

public func stringFitSize(string: String, font: UIFont, maxSize: CGSize) -> (CGSize) {
    let attributeDic = [NSFontAttributeName: font]
    
    return string.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributeDic, context: nil).size
}


