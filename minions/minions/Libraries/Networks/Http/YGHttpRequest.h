//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YGHttpRequest;
@class YGHttpResponse;
@class YGHttpSessionManager;

typedef NS_ENUM(NSInteger, YGHttpRequestMethod) {
    YGHttpRequestMethod_NONE,
    YGHttpRequestMethod_GET,
    YGHttpRequestMethod_HEAD,
    YGHttpRequestMethod_POST,
    YGHttpRequestMethod_PUT,
    YGHttpRequestMethod_PATCH,
    YGHttpRequestMethod_DELETE,
};

typedef void (^YGRequestDidComplete)(YGHttpRequest *request, YGHttpResponse *response);

@interface YGHttpRequest : NSObject

@property (copy, nonatomic) NSString *url;
@property (assign, nonatomic) YGHttpRequestMethod method;
@property (assign, nonatomic) NSTimeInterval timeout;

@property (strong, nonatomic) NSMutableDictionary *headerParams;
@property (strong, nonatomic) NSMutableDictionary *queryParams;
@property (strong, nonatomic) NSMutableDictionary *dataParams;
@property (strong, nonatomic) NSMutableDictionary *fileParams;
@property (strong, nonatomic) YGHttpSessionManager *sessionManager;
@property (copy, nonatomic) YGRequestDidComplete requestCompleteCallback;

- (BOOL) sendWithSessionManager: (YGHttpSessionManager *) sessionManager;
- (BOOL) send;
- (BOOL) cancel;
- (NSString *)methodName;

@end