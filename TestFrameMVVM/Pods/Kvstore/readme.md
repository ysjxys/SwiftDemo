## 数据存储持久化模块
采用多种方式持久化数据
### 1.安装数据存储持久化模块

使用Cocoapods来安装文件选择模块，Podfile如下：

	platform :ios, '8.1'
	source 'http://112.124.41.46/yougoods-ios/xgn.git'
	source 'https://github.com/CocoaPods/Specs.git'
	
	target 'YourProjectName' do
	  use_frameworks!
	  pod ’Kvstore’, '~>1.0.0'
	end
	
### 2.数据存储持久化模块介绍
##### 1、UserDefaultKVStore()  
存储地址：存储在library/Preferences 下  
存储类型：用户偏好设置，plist存储，依次存储key value对  


##### 2、persistentStore()  
存储地址：存储在library/Documentation/defaultStore 下  
存储类型：db存储，在单张表格内依次存储key typeName data

##### 3、largePersistentStore()  
存储地址：存储在library/Documentation/defaultStore/fileStore 下  
存储类型：db+文件存储，在db内有2张表格，分别存储key的名称、key类型、value类型、value的加密文件名称，value加密文件放在同目录的文件内  

##### 4、cacheStore() 
存储地址：存储在library/Caches/defaultStore/ 下  
存储类型：db存储，在单张表格内依次存储key typeName data

##### 5、largeCacheStore() 
存储地址：存储在library/Caches/defaultStore/fileStore 下  
存储类型：db+文件存储，在db内有2张表格，分别存储key的名称、key类型、value类型、value的文件名称，value文件放在同目录的文件内

##### 6、largeCacheWithTimeStore() 
存储地址：存储在library/Caches/defaultStore/fileStore 下  
存储类型：db+文件存储，在db内有3张表格，分别存储key的名称、key类型、value类型、value的文件名称、时间标记(timeStamp)，value文件放在同目录的文件内

##### 7、tempStore() 
存储地址：存储在tmp/defaultStore 下  
存储类型：db存储，在单张表格内依次存储key typeName data

##### 8、plistStore() 
存储地址：存储在Documents 下  
存储类型：plist存储，在plist文件内存储key、value

##### 9、securityStore() 
使用第三方SAMKeychain进行存储


### 3.数据存储持久化模块使用

	func objectForKey(_ key: String) -> DataType

    func setObject(_ data : DataType, forKey key: String)

    func valueForKey<T:StringInitable>(_ key: String) -> T?

    func setValue<T>(_ value: T?, forKey key: String)

    func removeForKey(_ key: String)

    func enumerateKeysAndObjectsUsingBlock(block: @escaping(_ key: String, _ data: DataType)->())

    func cleanAll()
