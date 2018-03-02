//
//  AESExtensionString.swift
//  expressHelper
//
//  Created by ysj on 2018/1/3.
//  Copyright © 2018年 ysj. All rights reserved.
//

import Foundation

extension String {
    public var aes128Encrypt: String {
        let hexString = AESUtils.aes128Encrypt(self, withKey: "dGJiZXhwcmVzcw==")
        guard let string = hexString else {
            return ""
        }
        return string
    }
}
