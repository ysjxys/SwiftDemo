# XGDigitalRecognize

## 简述

XGDigitalRecognize以 [SwiftOCR](https://github.com/Nirvana-icy/SwiftOCR) 为基础,

1⃣️ 提供0~9印刷体的数字识别服务.

2⃣️ 根据业务需求,将识别过程由拍照识别改造为扫描识别.

另外通过iOS 9提供的API CITextDetector, 判断输入图像中是否有文字, 如果有文字再跑数字识别算法.从而提高识别效率,减少性能消耗.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

XGDigitalRecognize is available through [新光私有库]('http://112.124.41.46/yougoods-ios/xgn.git').

To install it, just need to add below lines to podfile:

First add

source 'http://112.124.41.46/yougoods-ios/xgn.git'

then add

```ruby
pod "XGDigitalRecognize"
```

## 使用

```Swift
import XGDigitalRecognize

// 声明实例变量
fileprivate var xgDigitalRecognizeService: XGDigitalRecognize?  

// 对图片进行识别
self.xgDigitalRecognizeService?.recognize(self.imgToRecognize!) { recognizedString in
  if recognizedString.utf16.count >= 11 {
    DispatchQueue.main.async {
      self.viewModel.phoneNumStr = recognizedString
      self.resultLablePhoneNum?.text = "手机号: " + self.viewModel.phoneNumStr
    }
  }      
```

## 数字识别的基本过程

![数字识别的基本过程](http://112.124.41.46/bijinglong/candyimg/raw/master/DigtalRecognize/digitalRecognize.png)

## More to read

[SwiftOCR改造过程简述](http://112.124.41.46/bijinglong/candyimg/blob/master/DigtalRecognize/readme.md)

## Author

bijl@xinguangnet.com

## License

XGDigitalRecognize is available under the MIT license. See the LICENSE file for more info.
