//
//  AESUtils.h
//  AES
//
//  Created by shade on 2017/4/19.
//  Copyright © 2017年 shade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESUtils : NSObject

+(NSString*) AES128Encrypt:(NSString *)plainText withKey:(NSString *)key;

+(NSString*) AES128Decrypt:(NSString *)encryptText;


@end
