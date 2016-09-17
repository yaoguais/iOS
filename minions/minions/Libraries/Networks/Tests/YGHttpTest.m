//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGHttpTest.h"
#import "YGHttpSessionManager.h"
#import "YGHttpManager.h"
#import "YGHttpRequest.h"
#import "YGHttpsSessionManager.h"
#import "YGHttpResponse.h"
#import "AFHTTPSessionManager.h"
#import "YGHttpFile.h"
#import "MNHttpsSessionManager.h"


@implementation YGHttpTest
+ (void)test {
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSString *p12FilePath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSString *p12Password = @"111111";
    YGHttpsSessionManager *manager = [[YGHttpsSessionManager alloc] initWithCertFilePath:certFilePath andP12FilePath:p12FilePath andP12Password:p12Password];
    [YGHttpManager setDefaultManager:manager];

    NSLog(@"go");
    [[YGHttpManager defaultManager].manager GET:@"https://jegarn.com:7080/index.php" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Data: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    }                                   failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@ operation: %@", error, operation);
    }];
    NSLog(@"\n\n\n");
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = @"https://jegarn.com:7080/index.php?a=b";
    httpRequest.method = YGHttpRequestMethod_GET;
    httpRequest.queryParams[@"c"] = @"d";
    httpRequest.headerParams[@"Content-TTT"] = @"text/html";
    httpRequest.timeout = 3;
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        NSLog(@"Data: %@ Error:%@", [[NSString alloc] initWithData:response.responseObject encoding:NSUTF8StringEncoding], response.error);
    };
    [httpRequest send];
    NSLog(@"\n\n\n");
    httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = @"https://jegarn.com:7080/index.php?a=b";
    httpRequest.method = YGHttpRequestMethod_POST;
    httpRequest.queryParams[@"c"] = @"d";
    httpRequest.dataParams[@"e"] = @[@"f", @"f2"];
    httpRequest.headerParams[@"Content-TTT"] = @"text/html";
    httpRequest.timeout = 3;
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        NSLog(@"Data: %@ Error:%@", [[NSString alloc] initWithData:response.responseObject encoding:NSUTF8StringEncoding], response.error);
    };
    [httpRequest send];
    NSLog(@"\n\n\n");
    httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = @"https://jegarn.com:7080/index.php?a=b";
    httpRequest.method = YGHttpRequestMethod_POST;
    httpRequest.queryParams[@"c"] = @"d";
    httpRequest.dataParams[@"e"] = @[@"f", @"f2"];
    httpRequest.headerParams[@"Content-TTT"] = @"text/html";
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
    NSURL * fileUrl = [[NSBundle mainBundle] URLForResource: @"test" withExtension:@"jpg"];
    httpRequest.fileParams = [@{
            @"file1" : [UIImage imageNamed:@"test.jpg"],
            @"file2" : [[YGHttpFile alloc] initWithFilePath:filePath andMimeType:@"image/jpg"],
            @"file3" : fileUrl,
    } mutableCopy];
    httpRequest.timeout = 3;
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        NSLog(@"Data: %@ Error:%@", [[NSString alloc] initWithData:response.responseObject encoding:NSUTF8StringEncoding], response.error);
    };
    [httpRequest send];

    NSLog(@"done");
}

+ (void) test2
{
    YGHttpsSessionManager *manager = [[MNHttpsSessionManager alloc] init];
    [YGHttpManager setDefaultManager:manager];
    NSLog(@"go");
    YGHttpRequest *httpRequest = [[YGHttpRequest alloc] init];
    httpRequest.url = @"https://jegarn.com/api/user/recommend";
    httpRequest.method = YGHttpRequestMethod_GET;
    httpRequest.timeout = 3;
    httpRequest.requestCompleteCallback = ^(YGHttpRequest *request, YGHttpResponse *response) {
        NSLog(@"Data: %@ Error:%@", [[NSString alloc] initWithData:response.responseObject encoding:NSUTF8StringEncoding], response.error);
    };
    [httpRequest send];
    NSLog(@"done");
}

@end