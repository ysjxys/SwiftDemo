//
//  XBLogger.swift
//  TuboboDriver
//
//  Created by apple on 2017/9/11.
//  Copyright © 2017年 XinGuang. All rights reserved.
//

import Foundation
import XCGLogger
import Bugly

public let Logger = XBLogger.default

final public class XBLogger {
    
    //XCGLogger配置
    private let log: XCGLogger = {
        
        // Setup XCGLogger
        let log = XCGLogger.default
        
        // You can also change the labels for each log level, most useful for alternate languages, French, German etc, but Emoji's are more fun
        log.levelDescriptions[.verbose] = "🗯Verbose"
        log.levelDescriptions[.debug] = "🔹Debug"
        log.levelDescriptions[.info] = "ℹ️Info"
        log.levelDescriptions[.warning] = "⚠️Warning"
        log.levelDescriptions[.error] = "‼️Error"
        log.levelDescriptions[.severe] = "💣Severe"
        
        return log
    }()
    
    public static let `default` = XBLogger()
    
    private var isWriteToFile: Bool = true
    
    init() {
        //bugly自定义日志初始化，开始打印的级别，是否打印在控制台
        BuglyLog.initLogger(.debug, consolePrint: false)
    }
    
    /// config bugly and confirm isWriteToFile.
    ///
    /// - Parameters:
    ///     - isWriteToFile:    whether or not write to file and console.
    ///
    /// - Returns:  Nothing.
    ///
    public func start(_ isWriteToFile: Bool, withBuglyId buglyID: String, withBuglyChannel buglyChannel: String? = nil) {
        self.isWriteToFile = isWriteToFile
        let config = BuglyConfig()
        if buglyChannel != nil {
            config.channel = buglyChannel ?? ""
        }
        config.debugMode = false
        config.reportLogLevel = .debug
        Bugly.start(withAppId: buglyID, config: config)
        
        let logPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("XCGLogger_Log\(currentTimeFormatter()).txt")
        //log.setup(level: .debug, showThreadName: false, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: logPath)
        
        let fileDestination = FileDestination(writeToFile: logPath, identifier: "advancedLogger.fileDestination", shouldAppend: true, appendMarker: "---------------------------- Relaunched App --------------------------------")
        fileDestination.outputLevel = .debug
        fileDestination.showLogIdentifier = false
        fileDestination.showFunctionName = true
        fileDestination.showThreadName = false
        fileDestination.showLevel = true
        fileDestination.showFileName = true
        fileDestination.showLineNumber = true
        fileDestination.showDate = true
        fileDestination.logQueue = XCGLogger.logQueue
        if !isWriteToFile{
            fileDestination.writeToFileURL = nil
        }
        log.add(destination: fileDestination)
    }
    
    public func setUserIdentifier(_ UserId: String?) {
        Bugly.setUserIdentifier(UserId ?? "unkown")
    }
    /// Log something at the Verbose log level.
    ///
    /// - Parameters:
    ///     - message:      the objects to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    public func verbose(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, ThreadInfo: String = "{\(Thread.current)}") {
        logUtil(message, type: .verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber, ThreadInfo: ThreadInfo)
    }
    
    /// Log something at the Debug log level.
    ///
    /// - Parameters:
    ///     - message:      the objects to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    public func debug(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, ThreadInfo: String = "{\(Thread.current)}") {
        logUtil(message, type: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber, ThreadInfo: ThreadInfo)
    }
    
    /// Log something at the Warnning log level.
    ///
    /// - Parameters:
    ///     - message:      the objects to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    public func warning(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, ThreadInfo: String = "{\(Thread.current)}") {
        logUtil(message, type: .warn, functionName: functionName, fileName: fileName, lineNumber: lineNumber, ThreadInfo: ThreadInfo)
    }
    
    /// Log something at the Info log level.
    ///
    /// - Parameters:
    ///     - message:      the objects to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    public func info(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, ThreadInfo: String = "{\(Thread.current)}") {
        logUtil(message, type: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber, ThreadInfo: ThreadInfo)
    }
    
    /// Log something at the Error log level.
    ///
    /// - Parameters:
    ///     - message:      the objects to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    public func error(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, ThreadInfo: String = "{\(Thread.current)}") {
        logUtil(message, type: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber, ThreadInfo: ThreadInfo)
    }
    
    /// Log something at the Severe log level.
    ///
    /// - Parameters:
    ///     - message:      the objects to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    public func severe(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, ThreadInfo: String = "{\(Thread.current)}") {
        logUtil(message, type: .silent, functionName: functionName, fileName: fileName, lineNumber: lineNumber, ThreadInfo: ThreadInfo)
    }
    
    /// Log something regularly. only print in console and bugly，not write to file method
    ///
    /// - Parameters:
    ///     - message:      the objects to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    public func printLog(_ messages: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        var messageString: String = ""
        for message in messages {
            messageString.append("\(message)")
        }
        DispatchQueue.global().async {
            BuglyLog.level(.debug, logs: self.formattingMessage(messageString, functionName, fileName, lineNumber))
        }
        
        #if DEBUG
            print(self.formattingMessage(messageString, functionName, fileName, lineNumber))
        #endif
    }
    
    /// main Log function at the all log level.
    ///
    /// - Parameters:
    ///     - message:      the object to be logged.
    ///     - type:         log level: BuglyLogLevel
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  Nothing.
    ///
    private func logUtil(_ messages: Any, type: BuglyLogLevel, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, ThreadInfo: String) {
        guard let messageArr = messages as? [Any] else {
            return
        }
        var message: String = ThreadInfo + "\n"
        for msg in messageArr {
            message.append("\(msg) ")
        }
        
        DispatchQueue.global().async {
            BuglyLog.level(type, logs: self.formattingMessage(message, functionName, fileName, lineNumber))
        }
        if !isWriteToFile {
            return
        }
        switch type {
        case .verbose:
            self.log.verbose(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        case .debug:
            self.log.debug(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        case .info:
            self.log.info(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        case .warn:
            self.log.warning(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        case .error:
            self.log.error(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        default:
            self.log.severe(message, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    /// main Log function at the all log level.
    ///
    /// - Parameters:
    ///     - fileName:     Normally omitted **Default:** *#file*.
    /// - Returns:  fileName actual string, delete prefix of fileName path
    ///
    private func dealWithFileName(_ fileName: StaticString = #file) -> String {
        let result = String(describing: fileName)
        return result.components(separatedBy: "/").last ?? "unknown"
    }
    
    /// format bugly message function
    ///
    /// - Parameters:
    ///     - message:      the object to be logged.
    ///     - functionName: Normally omitted **Default:** *#function*.
    ///     - fileName:     Normally omitted **Default:** *#file*.
    ///     - lineNumber:   Normally omitted **Default:** *#line*.
    ///
    /// - Returns:  bugly format String , add necessary information into result
    ///
    private func formattingMessage(_ message: Any, _ functionName: StaticString = #function, _ fileName: StaticString = #file, _ lineNumber: Int = #line) -> String {
        return "[" + dealWithFileName(fileName) + ":" + String(lineNumber) + "]" + " " + String(describing: functionName) + " " + ">" + " " + "\(message)"
    }
    
}

func currentTimeFormatter() -> String {
    let date = Date()
    let timeFormatter = DateFormatter()
    //日期显示格式，可按自己需求显示,根据日期打印日志
    timeFormatter.dateFormat = "yyyy-MM-dd"
    let strNowTime = timeFormatter.string(from: date) as String
    return strNowTime
}
