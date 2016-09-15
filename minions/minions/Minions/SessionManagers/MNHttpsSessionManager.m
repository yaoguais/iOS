//
// Created by Yao Guai on 16/9/11.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNHttpsSessionManager.h"
#import "YGHttpRequest.h"
#import "YGEnvironment.h"


@implementation MNHttpsSessionManager

- (instancetype)init {
    self = [super init];
    if (self) {
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

            return YES;
        };

        _requestBeforeResponseCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
            return YES;
        };
    }

    return self;
}


@end