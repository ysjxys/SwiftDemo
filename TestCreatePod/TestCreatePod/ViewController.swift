//
//  ViewController.swift
//  TestCreatePod
//
//  Created by ysj on 2017/2/9.
//  Copyright © 2017年 ysj. All rights reserved.
//

import UIKit
import store

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        testLargePersistentKVStore()
        testKeychain()
    }
    
    func testKeychain() {
        //set arr
        let dataTypeArr = DataType.array(["value1", "value2", "value3"])
        Store.securityStore().setObject(data: dataTypeArr, forKey: "key1")
        print(Store.securityStore().objectForKey("key1"))
        
//        // set dic   enum
//        let dataTypeDic = DataType.dictionary(["key1":"value1","key2":["1","2"]])
//        Store.keychainKVStore.setObject(data: dataTypeDic, forKey: "key2")
//        Store.keychainKVStore.enumerateKeysAndObjectsUsingBlock { (key, dataType) in
//            print(" key:\(key)  \n typeString:\(dataType.typeString()) \n toString:\(dataType.toString())")
//        }
//        
//        //remove
//        Store.keychainKVStore.removeForKey("key1")
//        print(Store.keychainKVStore.objectForKey("key1"))
//        
//        //clean
//        Store.keychainKVStore.cleanAll()
//        print(Store.keychainKVStore.objectForKey("key2"))
    }
    
    func testLargePersistentKVStore() {
        //set arr
        let dataTypeArr = DataType.array(["value1", "value2", "value3"])
        Store.largePersistentStore().setObject(data: dataTypeArr, forKey: "key1")
        print(Store.largePersistentStore().objectForKey("key1"))
        
//        // set dic   enum
//        let dataTypeDic = DataType.dictionary(["key1":"value1","key2":["1","2"]])
//        StoreLayer.defaultStore().largePersistentStore().setObject(data: dataTypeDic, forKey: "key2")
//        StoreLayer.defaultStore().largePersistentStore().enumerateKeysAndObjectsUsingBlock { (key, dataType) in
//            print(" key:\(key)  \n typeString:\(dataType.typeString()) \n toString:\(dataType.toString())")
//        }
//        
//        //remove
//        StoreLayer.defaultStore().largePersistentStore().removeForKey("key1")
//        print(StoreLayer.defaultStore().largePersistentStore().objectForKey("key1"))
//        
//        
//        //clean all
//        StoreLayer.defaultStore().largePersistentStore().cleanAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

