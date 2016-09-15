//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGHttpSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "YGHttpRequest.h"
#import "YGHttpResponse.h"


@implementation YGHttpSessionManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
    }

    return self;
}

@end