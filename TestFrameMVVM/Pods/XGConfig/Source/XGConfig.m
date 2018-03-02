//
//  XGConfig.m
//  XGConfig
//
//  Created by apple on 2017/10/31.
//  Copyright © 2017年 XinGuang. All rights reserved.
//

#import "XGConfig.h"
#import "FMDB.h"

@interface XGConfig()
    
@property(nonatomic, strong) NSMutableDictionary *configsByEnv;

@property(nonatomic, assign) NSNumber *envFromJson;

@end

@implementation XGConfig

+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    static id XGInstance = nil;
    
    dispatch_once(&p, ^{
        XGInstance = [[[self class] alloc] init];
        if ([XGInstance isKindOfClass:[XGConfig class]]) {
            [((XGConfig *) XGInstance) configsByDb];
            [((XGConfig *) XGInstance) ConfigEnvironmentByJson];
        }
    });
    
    return XGInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configsByEnv = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    
    return self;
}
    
- (NSString* )queryConfigData {
    NSString * configData;
    NSString *filePath = [NSBundle.mainBundle pathForResource:@"ConfigData" ofType:@"db"];
    FMDatabase * db = [FMDatabase databaseWithPath:filePath];
    if ([db open]) {
        [db setKey:@"xghltubobo1011"];
        NSString * sql = @"select * from configData";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            configData = [rs stringForColumn:@"configJsonData"];
        }
        [db close];
    }
    return configData;
}
- (NSMutableDictionary *)configsByDb {
    if (_configsByEnv) {
        NSString* jsonString = [self queryConfigData];
        if (jsonString == nil) {
            return nil;
        }
        NSData *fileData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id configs = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
        _configsByEnv = [[(NSDictionary *)configs valueForKey:@"configs"] mutableCopy];
    }
    XGLog(@"您从数据库读取配置环境字典为：")
    XGLog(@"%@", _configsByEnv);
    return _configsByEnv;
}
    
- (NSInteger) ConfigEnvironmentByJson {
    if (!_envFromJson) {
        NSString *filePath = [NSBundle.mainBundle pathForResource:@"config" ofType:@"json"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
        NSError *error = nil;
        id configs = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
        _envFromJson = [(NSDictionary *)configs valueForKey:@"environment"];
    }
    //XGLog(@"您当前指定配置环境为: %ld", [_envFromJson integerValue]);
    return [_envFromJson integerValue];
}

- (NSString *)currentEnvironmentName;{
    switch ([self getCurrentEnv]) {
        case XGEnvironmentProd:
        return @"生产环境";
        break;
        case XGEnvironmentDev:
        return @"开发环境";
        break;
        case XGEnvironmentTest:
        return @"测试环境";
        break;
        case XGEnvironmentTestOL:
        return @"测试线上环境";
        break;
        case XGEnvironmentStage:
        return @"预发布生产环境";
        break;
        default:
        return @"错误未知环境";
        break;
    }
}
    
- (NSInteger) currentEnvironmentNumber {
    return [self getCurrentEnv];
}
- (void)switchTo: (XGEnvironmentType)environment {
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(environment) forKey:@"environment"];
}

- (NSInteger) getCurrentEnv {
    NSInteger envType;
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    id result = [userDefault objectForKey:@"environment"];
    if (result == nil) {
        envType = [_envFromJson integerValue];
    } else {
        envType = [result integerValue];
    }
    return envType;
}
    
- (nonnull NSString *)stringValueForKey:(nonnull NSString *)key {
    
    switch ([self getCurrentEnv]) {
        case XGEnvironmentProd:
        {
            NSString *value = [[self.configsByEnv valueForKey:@"production"] valueForKey:key];
            NSAssert(value, @"key not found, please check");
            return value;
        }
        break;
        case XGEnvironmentDev:
        {
            NSString *value = [[self.configsByEnv valueForKey:@"development"] valueForKey:key];
            NSAssert(value, @"key not found, please check");
            return value;
        }
        break;
        case XGEnvironmentTest:
        {
            NSString *value = [[self.configsByEnv valueForKey:@"test"] valueForKey:key];
            NSAssert(value, @"key not found, please check");
            return value;
        }
        break;
        case XGEnvironmentTestOL:
        {
            NSString *value = [[self.configsByEnv valueForKey:@"testOnline"] valueForKey:key];
            NSAssert(value, @"key not found, please check");
            return value;
        }
        break;
        case XGEnvironmentStage:
        {
            NSString *value = [[self.configsByEnv valueForKey:@"preannouncement"] valueForKey:key];
            NSAssert(value, @"key not found, please check");
            return value;
        }
        break;
        default:{
            NSAssert(false, @"config userdefault environment is error");
            return @"null";
        }
        break;
    }
}
@end
