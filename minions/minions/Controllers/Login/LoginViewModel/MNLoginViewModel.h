//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGHttpRequest.h"

@class MNLoginUserModel;
@class YGHttpRequest;
@class YGHttpResponse;


@interface MNLoginViewModel : NSObject

@property (nonatomic) NSInteger code;
@property (nonatomic, strong) MNLoginUserModel *user;

- (void)loginWithAccount:(NSString *)account password:(NSString *)password callback:(void (^)(MNLoginViewModel *))callback;

@end