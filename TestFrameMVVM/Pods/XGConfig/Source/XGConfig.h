//
//  XGConfig.h
//  XGConfig
//
//  Created by apple on 2017/10/31.
//  Copyright © 2017年 XinGuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XGCommon.h"

/**
 * 0: "生产环境",
 * 1: "开发环境",
 * 2: "测试环境",
 * 3: "测试线上环境",
 * 4: "预发布生产环境"
 */

typedef enum
{
    XGEnvironmentProd = 0,
    XGEnvironmentDev = 1,
    XGEnvironmentTest = 2,
    XGEnvironmentTestOL = 3,
    XGEnvironmentStage = 4
}XGEnvironmentType;

@interface XGConfig : NSObject

// 当前环境名称
@property(nonatomic, strong, nonnull) NSString* currentEnvironmentName;
// 获取当前环境的number
@property(nonatomic, assign) NSInteger currentEnvironmentNumber;

+ (instancetype _Nonnull )shareInstance;
    
- (nonnull NSString *)currentEnvironmentName;
- (NSInteger) currentEnvironmentNumber;

- (void)switchTo: (XGEnvironmentType)environment;

- (nonnull NSString *)stringValueForKey:(nonnull NSString *)key;

@end
