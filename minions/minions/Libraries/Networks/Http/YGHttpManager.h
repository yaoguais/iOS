//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGSingletonMicro.h"

@class YGHttpSessionManager;

@interface YGHttpManager : NSObject

@property(nonatomic, strong) NSMutableDictionary *managers;
@property(nonatomic, copy) NSString *defaultManagerKey;

YGSingletonH(YGHttpManager);

+ (void)setManger:(YGHttpSessionManager *)manager forKey:(NSString *) key;
+ (void)setDefaultManager:(YGHttpSessionManager *)manager;
+ (YGHttpSessionManager *)managerForKey:(NSString *) key;
+ (YGHttpSessionManager *)defaultManager;

@end