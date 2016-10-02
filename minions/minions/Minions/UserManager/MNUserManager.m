//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNUserManager.h"
#import "MNLoginUserModel.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNErrorCode.h"
#import "MNHttpRequestUrl.h"
#import "YGHttpResponse.h"
#import "NSObject+YYModel.h"
#import "YGCommonMicro.h"


@implementation MNUserInfoViewModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"code" : @"code",
            @"user" : @"response"
    };
}
@end

@implementation MNUserManager

YGSingletonM(MNLoginUserManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        _users = [[NSMutableDictionary alloc] init];
        _fakeUser = [[MNLoginUserModel alloc] init];
        _fakeUser.uid = @"12";
        _fakeUser.account = @"yaoguai";
        _fakeUser.avatar = @"/upload/avatar/default/b7.jpg";
        _fakeUser.token = @"a03231805fb703d159dbc71633c72b86";
        [self addUser:_fakeUser];
    }

    return self;
}

- (void)fetchUser:(NSString *)uid callback:(void (^)(MNUserInfoViewModel *))callback
{
    if (_users[uid]) {
        MNUserInfoViewModel *viewModel = [[MNUserInfoViewModel alloc] init];
        viewModel.code = SUCCESS;
        viewModel.user = _users[uid];
        callback(viewModel);
        return;
    }
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = MNHttpRequestUserInfoUrl;
    httpRequest.queryParams = [@{@"user_id" : uid} mutableCopy];
    httpRequest.method = YGHttpRequestMethod_GET;
    httpRequest.timeout = MNHttpRequestTimeout;
    @weakify(self);
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        @strongify(self);
        MNUserInfoViewModel *viewModel = nil;
        if (response.error) {
            viewModel = [[MNUserInfoViewModel alloc] init];
            viewModel.code = [MNErrorCode getNetworkErrorCode];
        } else {
            viewModel = [MNUserInfoViewModel yy_modelWithJSON:response.responseObject];
            if (!YGIsNotNull(viewModel.user)) {
                viewModel.code = [MNErrorCode getNetworkErrorCode];
            }
        }
        callback(viewModel);
    };
    [httpRequest send];
}

- (void)addUser:(MNUserModel *)user
{
    if(user.uid){
        _users[user.uid] = user;
    }
}


@end