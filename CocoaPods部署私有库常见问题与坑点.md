<!--
author: 鱼头-俞胜杰
date: 2017-02-22
title: CocoaPods部署私有库常见问题与坑点
tags: Cocoapods 私有库
category: iOS
status: publish
summary: CocoaPods部署私有库过程中常见问题与坑点
-->
1、hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

明显的错误，在push前需进行pull操作，拉取远程可能的更新，保证本地与远程不起冲突

2、The validator for Swift projects uses Swift 3.0 by default, if you are using a different version of swift you can use a `.swift-version` file to set the version for your Pod. For example to use Swift 2.3, run:      `echo "2.3" > .swift-version`. You can use the `--no-clean` option to inspect any issue.

swift版本不兼容，需要使用swift3.0版本，在终端采用以下命令改变swift版本即可  
echo 3.0 > .swift-version

3、ERROR | [iOS] xcodebuild:  /Users/ysj/ysjPodLib/YSJStore/YSJStore/Classes/extensions/Array_String.swift:30:33: error: use of unresolved identifier 'JSONSerialization'

依赖库未导入，导致找不到相关对象
在xxx.podspec配置文件内配置所有的依赖库

4、An unexpected version directory `Assets` was encountered for the `/Users/ysj/.cocoapods/repos/store/testStore` Pod in the `testStore` repository

表层原因是路径下的文件不被库所容，表层解决方法将其删除即可，但深层的原因是之前的搭建私有库的过程中，将项目文件与pod install所依赖的podspec配置文件放在了podspec目录下，最好重新检查之前搭建私有库的过程

5、[!] MediaPicker did not pass validation, due to 1 warning (but you can use `--allow-warnings` to ignore it).
You can use the `--no-clean` option to inspect any issue.

文件内含有编译警告，通过添加 --allow-warnings 来忽略警告可通过