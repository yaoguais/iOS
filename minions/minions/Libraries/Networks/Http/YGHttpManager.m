//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGHttpManager.h"
#import "YGHttpSessionManager.h"


@implementation YGHttpManager

YGSingletonM(YGHttpManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaultManagerKey = @"default";
        _managers = [[NSMutableDictionary alloc] init];
    }

    return self;
}


+ (void)setManger:(YGHttpSessionManager *)manager forKey:(NSString *)key {
    YGHttpManager *httpManager = [YGHttpManager sharedInstance];
    httpManager.managers[key] = manager;
}

+ (void)setDefaultManager:(YGHttpSessionManager *)manager {
    YGHttpManager *httpManager = [YGHttpManager sharedInstance];
    httpManager.managers[httpManager.defaultManagerKey] = manager;
}

+ (YGHttpSessionManager *)managerForKey:(NSString *)key {
    YGHttpManager *httpManager = [YGHttpManager sharedInstance];
    return httpManager.managers[key];
}

+ (YGHttpSessionManager *)defaultManager {
    YGHttpManager *httpManager = [YGHttpManager sharedInstance];
    return httpManager.managers[httpManager.defaultManagerKey];
}

@end