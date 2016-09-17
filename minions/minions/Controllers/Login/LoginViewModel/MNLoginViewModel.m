//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <YYModel/NSObject+YYModel.h>
#import "MNLoginViewModel.h"
#import "YGHttpResponse.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNErrorCode.h"
#import "MNHttpRequestUrl.h"
#import "YGCommonMicro.h"
#import "MNLoginUserModel.h"


@implementation MNLoginViewModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"code" : @"code",
            @"user" : @"response"
    };
}

- (void)loginWithAccount:(NSString *)account password:(NSString *)password callback:(void (^)(MNLoginViewModel *))callback {
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = MNHttpRequestLoginUrl;
    httpRequest.dataParams = [@{@"account" : account, @"password" : password} mutableCopy];
    httpRequest.method = YGHttpRequestMethod_POST;
    httpRequest.timeout = MNHttpRequestTimeout;
    @weakify(self);
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        @strongify(self);
        MNLoginViewModel *loginViewModel;
        if (response.error) {
            loginViewModel = [[MNLoginViewModel alloc] init];
            loginViewModel.code = [MNErrorCode getNetworkErrorCode];
        } else {
            loginViewModel = [MNLoginViewModel yy_modelWithJSON:response.responseObject];
            if (!YGIsNotNull(loginViewModel.user)) {
                loginViewModel.code = [MNErrorCode getNetworkErrorCode];
            }else{
                self.user = loginViewModel.user;
            }
        }
        callback(loginViewModel);
    };
    [httpRequest send];
}
@end