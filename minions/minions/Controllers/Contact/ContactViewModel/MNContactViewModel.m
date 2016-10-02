//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <YYModel/NSObject+YYModel.h>
#import "MNContactViewModel.h"
#import "MNUserModel.h"
#import "YYCache-prefix.pch"
#import "YGHttpRequest.h"
#import "MNHttpRequestUrl.h"
#import "YGWeakifyStrongifyMicro.h"
#import "YGHttpResponse.h"
#import "MNErrorCode.h"
#import "YGCommonMicro.h"
#import "MNUserManager.h"


@implementation MNContactViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _users = [[NSMutableArray alloc] init];
    }

    return self;
}


- (NSUInteger) count
{
    return [_users count];
}

- (MNUserModel *)userForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _users[indexPath.row];
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"code" : @"code",
            @"groups" : @"response"
    };
}

- (void)requestForUsersForCallback:(void (^)(MNContactViewModel *))callback
{
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = MNHttpRequestRosterUrl;
    httpRequest.method = YGHttpRequestMethod_GET;
    httpRequest.timeout = MNHttpRequestTimeout;
    @weakify(self);
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        @strongify(self);
        MNContactViewModel * contactViewModel;
        if (response.error) {
            contactViewModel = [[MNContactViewModel alloc] init];
            contactViewModel.code = [MNErrorCode getNetworkErrorCode];
        } else {
            contactViewModel = [MNContactViewModel yy_modelWithJSON:response.responseObject];
            if (!YGIsNotNull(contactViewModel.groups)) {
                contactViewModel.code = [MNErrorCode getNetworkErrorCode];
            } else {
                for (id group in contactViewModel.groups) {
                    if([group isKindOfClass:[NSDictionary class]]){
                        id rosters = [group objectForKey:@"rosters"];
                        if ([rosters isKindOfClass:[NSArray class]]) {
                            for (id roster in rosters) {
                                if ([roster isKindOfClass:[NSDictionary class]]) {
                                    id userDic = [roster objectForKey:@"user"];
                                    if([userDic isKindOfClass:[NSDictionary class]]){
                                        MNUserModel * userModel = [[MNUserModel alloc] init];
                                        userModel.uid = [userDic objectForKey:@"uid"];
                                        userModel.account = [userDic objectForKey:@"account"];
                                        userModel.avatar = [userDic objectForKey:@"avatar"];
                                        [_users addObject:userModel];
                                        [[MNUserManager sharedInstance] addUser:userModel];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        callback(contactViewModel);
    };
    [httpRequest send];
}

@end