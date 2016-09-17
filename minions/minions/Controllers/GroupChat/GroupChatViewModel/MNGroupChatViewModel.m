//
// Created by Yao Guai on 16/9/18.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNGroupChatViewModel.h"
#import "MNGroupModel.h"
#import "YGHttpRequest.h"
#import "YGHttpResponse.h"
#import "MNHttpRequestUrl.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNErrorCode.h"
#import "NSObject+YYModel.h"
#import "YGCommonMicro.h"
#import "YYCache-prefix.pch"


@implementation MNGroupChatViewModel

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

- (void)requestGroupsWithCallback:(void (^)(MNGroupChatViewModel *))callback
{
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = MNHttpRequestGroupUrl;
    httpRequest.queryParams = [@{@"type" : @"0", @"status" : @"3"} mutableCopy];
    httpRequest.method = YGHttpRequestMethod_GET;
    httpRequest.timeout = MNHttpRequestTimeout;
    @weakify(self);
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        @strongify(self);
        MNGroupChatViewModel *viewModel;
        if (response.error) {
            viewModel = [[MNGroupChatViewModel alloc] init];
            viewModel.code = [MNErrorCode getNetworkErrorCode];
        } else {
            viewModel = [MNGroupChatViewModel yy_modelWithJSON:response.responseObject];
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