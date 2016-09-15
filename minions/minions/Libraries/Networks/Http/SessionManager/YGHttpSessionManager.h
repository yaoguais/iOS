//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;
@class YGHttpRequest;
@class YGHttpResponse;

typedef BOOL (^YGRequestBeforeRequest)(YGHttpRequest *request);
typedef BOOL (^YGRequestBeforeResponse)(YGHttpRequest *request, YGHttpResponse *response);

@interface YGHttpSessionManager : NSObject {
@public
    AFHTTPSessionManager * _manager;
    YGRequestBeforeRequest _requestBeforeRequestCallback;
    YGRequestBeforeResponse _requestBeforeResponseCallback;
}

@property(strong, nonatomic) AFHTTPSessionManager *manager;
@property (copy, nonatomic) YGRequestBeforeRequest requestBeforeRequestCallback;
@property (copy, nonatomic) YGRequestBeforeResponse requestBeforeResponseCallback;

@end