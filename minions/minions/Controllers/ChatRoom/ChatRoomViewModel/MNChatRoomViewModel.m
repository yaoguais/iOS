//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNChatRoomViewModel.h"
#import "MNGroupModel.h"
#import "YGHttpRequest.h"
#import "YGHttpResponse.h"
#import "MNHttpRequestUrl.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNErrorCode.h"
#import "NSObject+YYModel.h"
#import "YGCommonMicro.h"
#import "YYCache-prefix.pch"


@implementation MNChatRoomViewModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"code" : @"code",
            @"groups" : @"response"
    };
}

+ (NSDictionary*)modelContainerPropertyGenericClass {
    return @{@"groups" : [MNGroupModel class]};
}

- (NSUInteger)count
{
    return [_groups count];
}

- (MNGroupModel *)groupForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _groups[indexPath.row];
}

- (void)requestGroupsWithCallback:(void (^)(MNChatRoomViewModel *))callback
{
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = MNHttpRequestGroupUrl;
    httpRequest.queryParams = [@{@"type" : @"1", @"status" : @"3"} mutableCopy];
    httpRequest.method = YGHttpRequestMethod_GET;
    httpRequest.timeout = MNHttpRequestTimeout;
    @weakify(self);
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        @strongify(self);
        MNChatRoomViewModel *viewModel;
        if (response.error) {
            viewModel = [[MNChatRoomViewModel alloc] init];
            viewModel.code = [MNErrorCode getNetworkErrorCode];
        } else {
            viewModel = [MNChatRoomViewModel yy_modelWithJSON:response.responseObject];
            if (!YGIsNotNull(viewModel.groups)) {
                viewModel.code = [MNErrorCode getNetworkErrorCode];
            }else{
                self.groups = viewModel.groups;
            }
        }
        callback(viewModel);
    };
    [httpRequest send];
}

@end