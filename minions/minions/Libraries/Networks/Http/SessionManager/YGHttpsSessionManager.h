//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGHttpSessionManager.h"

@class AFHTTPSessionManager;


@interface YGHttpsSessionManager : YGHttpSessionManager

@property(nonatomic, copy) NSString *certFilePath;
@property(nonatomic, copy) NSString *p12FilePath;
@property(nonatomic, copy) NSString *p12Password;

- (YGHttpsSessionManager *)initWithCertFilePath:(NSString *)certFilePath andP12FilePath:(NSString *)p12FilePath andP12Password:(NSString *)p12Password;

@end