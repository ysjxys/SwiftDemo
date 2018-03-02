//
//  Function.swift
//  Pods
//
//  Created by apple on 17/2/15.
//
//

import Foundation

/// sync lock
public func vn_synchronized(_ lock: Any, _ closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

/// print debug log
public func debugLog(_ items: Any...,
    file: String = #file,
    method: String = #function,
    line: Int = #line)
{
    #if false && DEBUG
        var messageString: String = ""
        for message in items {
            messageString.append("\(message)")
        }
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(messageString)")
    #endif
}
