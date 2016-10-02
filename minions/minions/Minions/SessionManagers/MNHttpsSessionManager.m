//
// Created by Yao Guai on 16/9/11.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNHttpsSessionManager.h"
#import "YGHttpRequest.h"
#import "YGEnvironment.h"
#import "AFNetworking.h"
#import "MNLoginUserModel.h"
#import "MNUserManager.h"
#import "YGCommonMicro.h"

@implementation MNHttpsSessionManager

- (instancetype)init {
    self = [super init];
    if (self) {
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        policy.allowInvalidCertificates = YES;
        policy.validatesDomainName = NO;

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.securityPolicy = policy;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];

        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [manager setSessionDidBecomeInvalidBlock:^(NSURLSession *_Nonnull session, NSError *_Nonnull error) {
            NSLog(@"setSessionDidBecomeInvalidBlock %@", error);
        }];

        _manager = manager;

        _requestBeforeRequestCallback = ^(YGHttpRequest *httpRequest) {
            YGEnvironment *env = [YGEnvironment sharedInstance];
            httpRequest.queryParams[@"nbid"] = env.nbid;
            httpRequest.queryParams[@"os_version"] = env.osVersion;
            httpRequest.queryParams[@"os_name"] = env.osName;
            httpRequest.queryParams[@"app_version"] = env.appVersion;
            httpRequest.queryParams[@"app_bundle_id"] = env.appBundleId;
            httpRequest.queryParams[@"app_channel"] = env.appChannel;
            httpRequest.queryParams[@"appstore_id"] = env.appStoreId;
            httpRequest.queryParams[@"size"] = env.screenSize;
            httpRequest.queryParams[@"lang"] = env.languageCode;
            httpRequest.queryParams[@"country"] = env.countryCode;
            MNLoginUserModel * loginUserModel = [MNUserManager sharedInstance].loginUser;
            if (YGIsNotNull(loginUserModel)) {
                httpRequest.queryParams[@"uid"] = loginUserModel.uid;
                httpRequest.queryParams[@"token"] = loginUserModel.token;
            }

            return YES;
        };

        _requestBeforeResponseCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
            return YES;
        };
    }

    return self;
}


@end