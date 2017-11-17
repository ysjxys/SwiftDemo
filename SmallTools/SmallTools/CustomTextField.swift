//
//  CustomTextField.swift
//  SmallTools
//
//  Created by ysj on 2017/8/30.
//  Copyright © 2017年 ysj. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
}
