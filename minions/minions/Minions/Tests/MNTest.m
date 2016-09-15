//
// Created by Yao Guai on 16/9/11.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNTest.h"
#import "MNHttpsSessionManager.h"
#import "YGHttpManager.h"
#import "YGHttpResponse.h"
#import "YGHttpRequest.h"


@implementation MNTest

+(void) test
{
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSString *p12FilePath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSString *p12Password = @"111111";
    YGHttpsSessionManager *manager = [[MNHttpsSessionManager alloc] initWithCertFilePath:certFilePath andP12FilePath:p12FilePath andP12Password:p12Password];
    [YGHttpManager setDefaultManager:manager];

    NSLog(@"go");
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = @"https://jegarn.com:7080/index.php?a=b";
    httpRequest.method = YGHttpRequestMethod_GET;
    httpRequest.queryParams = [@{@"c" : @"d"} mutableCopy];
    httpRequest.timeout = 3;
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        NSLog(@"Data: %@ Error:%@", [[NSString alloc] initWithData:response.responseObject encoding:NSUTF8StringEncoding], response.error);
    };
    [httpRequest send];
    NSLog(@"done");
}

@end