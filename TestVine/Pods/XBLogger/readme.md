##### cocoaPods管理

pod 'XBLogger'

##### 使用方法

```
APPDelegate.swift文件中全局添加 let Logger = XBLogger.default
在didFinishLaunchingWithOptions方法中开始处调用Logger.start方法，传入所需的参数
在需要打印的地方调用Logger.debug("所需打印的信息")，也支持同时打印多个对象
```

##### 功能

1、实现控制台打印信息的规范化

2、日志保存在文件中，方便排查真机运行时代码问题

3、接入bugly，实现应用崩溃时上传最近打印的200条日志，便于排除引起线上崩溃的问题

4、各种级别的日志信息，包括verbose、debug、info、warning、error和severe；便于区分日志信息及过滤

##### 对外接口

```
//初始化配置方法，参数是是否写入文件的bool值和bugly ID
func start(_ isWriteToFile: Bool, withBuglyId buglyID: String)
///以下方法写入文件，打印在控制台，同时会在崩溃时上传最近200条日志，打印的级别不同而已
//verbose level log method
func verbose(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
//debug level log method
func debug(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
//warning level log method
func warning(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
//info level log method
func info(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
//error level log method
func error(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
//severe level log method
func severe(_ message: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
///以下方法不写入文件，打印在控制台，同时会在崩溃时上传最近200条日志，简单的调用print
// printLog方法
func printLog(_ messages: Any..., functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
```

核心方法

封装XCGLogger和Bugly日志模块

```
func logUtil(_ messages: Any, type: BuglyLogLevel, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line)
```



