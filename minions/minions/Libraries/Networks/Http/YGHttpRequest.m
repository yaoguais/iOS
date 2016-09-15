//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGHttpRequest.h"
#import "YGHttpResponse.h"
#import "AFURLRequestSerialization.h"
#import "YGCommonMicro.h"
#import "YGHttpFile.h"
#import "NSURLSessionTask+YGHttpRequest.h"
#import "YGHttpSessionManager.h"
#import "YGHttpManager.h"
#import "YGWeakifyStrongifyMicro.h"
#import "YGUrl.h"


@implementation YGHttpRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _headerParams = [[NSMutableDictionary alloc] init];
        _queryParams = [[NSMutableDictionary alloc] init];
        _dataParams = [[NSMutableDictionary alloc] init];
        _fileParams = [[NSMutableDictionary alloc] init];
        _url = nil;
        _method = YGHttpRequestMethod_NONE;
        _timeout = MAXFLOAT;
    }

    return self;
}

- (BOOL)sendWithSessionManager:(YGHttpSessionManager *)sessionManager {
    _sessionManager = sessionManager;
    if (sessionManager.requestBeforeRequestCallback && !sessionManager.requestBeforeRequestCallback(self)) {
        return NO;
    }
    BOOL isMultipart = NO;
    NSMutableURLRequest *urlRequest = [YGHttpRequest urlRequestFromYGHttpRequest:self multipart:&isMultipart];
    NSURLSessionTask *sessionTask = nil;
    if (isMultipart) {
        @weakify(self);
        sessionTask = [sessionManager.manager uploadTaskWithStreamedRequest:urlRequest progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            @strongify(self);
            [self request:self BackWithResponse:[[YGHttpResponse alloc] initWithUrlResponse:response responseObject:responseObject error:error]];
        }];
    }
    else {
        @weakify(self);
        sessionTask = [sessionManager.manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            @strongify(self);
            [self request:self BackWithResponse:[[YGHttpResponse alloc] initWithUrlResponse:response responseObject:responseObject error:error]];
        }];
    }

    sessionTask.httpRequestTag = self;
    [sessionTask resume];
    return YES;
}

- (BOOL)send {
    return [self sendWithSessionManager:[YGHttpManager defaultManager]];
}

- (BOOL)cancel {
    NSArray *allWaitingSessionTasks = [_sessionManager.manager tasks];
    for (NSURLSessionTask *sessionTask in allWaitingSessionTasks) {
        YGHttpRequest *httpRequest = sessionTask.httpRequestTag;
        if (httpRequest == self) {
            [sessionTask cancel];
            return YES;
        }
    }
    return NO;
}

- (void)request:(YGHttpRequest *)request BackWithResponse:(YGHttpResponse *)response {
    if (request.sessionManager.requestBeforeResponseCallback && !request.sessionManager.requestBeforeResponseCallback(request, response)) {
        return;
    }
    if (request.requestCompleteCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            request.requestCompleteCallback(request, response);
        });
    }
}

- (NSString *)methodName {
    switch (_method) {
        case YGHttpRequestMethod_GET:
            return @"GET";
        case YGHttpRequestMethod_HEAD:
            return @"HEAD";
        case YGHttpRequestMethod_POST:
            return @"POST";
        case YGHttpRequestMethod_PUT:
            return @"PUT";
        case YGHttpRequestMethod_PATCH:
            return @"PATCH";
        case YGHttpRequestMethod_DELETE:
            return @"DELETE";
        case YGHttpRequestMethod_NONE:
        default:
            return @"NONE";
    }
}

+ (NSMutableURLRequest *)urlRequestFromYGHttpRequest:(YGHttpRequest *)httpRequest multipart:(BOOL *)multipartOrNot {
    NSError *error = nil;
    if (httpRequest.method == YGHttpRequestMethod_NONE) {
        NSLog(@"YGHttpRequest url %@method not defined", httpRequest.url);
        return nil;
    }
    NSMutableURLRequest *urlRequest = nil;
    NSString *urlString = [YGUrl appendQueries:httpRequest.queryParams toUrl:httpRequest.url];
    id dataParams = httpRequest.dataParams;
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];

    if ([httpRequest.fileParams count] > 0) {
        urlRequest = [requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:dataParams constructingBodyWithBlock:^(id <AFMultipartFormData> _Nonnull formData) {
            [self appendFiles:httpRequest.fileParams ToFormData:formData];
        }                                                        error:&error];
        *multipartOrNot = YES;
    } else {
        urlRequest = [requestSerializer requestWithMethod:httpRequest.methodName URLString:urlString parameters:dataParams error:&error];
        *multipartOrNot = NO;
    }

    if (error) {
        NSLog(@"serialize NSMutableURLRequest error: %@ url:%@", error, urlString);
        return nil;
    }
    else {
        [httpRequest.headerParams enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
            [urlRequest addValue:obj forHTTPHeaderField:key];
        }];

        if (httpRequest.timeout) {
            urlRequest.timeoutInterval = httpRequest.timeout;
        }

        return urlRequest;
    }
}

+ (void)appendFiles:(NSMutableDictionary *)fileParams ToFormData:(id <AFMultipartFormData> _Nonnull)formData {
    void (^addImageParamBlock)(id, id) = ^(id key, id obj) {
        if ([obj isKindOfClass:[NSURL class]] && [(NSURL *) obj isFileURL]) {
            [formData appendPartWithFileURL:(NSURL *) obj name:key error:nil];
        } else if ([obj isKindOfClass:[UIImage class]]) {
            NSData *data = UIImageJPEGRepresentation(obj, 1.0);
            NSString *type = [self typeForImageData:data];
            NSString *mimeType = YGIsEmptyString(type) ? @"" : [NSString stringWithFormat:@"image/%@", type];
            [formData appendPartWithFileData:data name:key fileName:[key stringByAppendingPathExtension:type] mimeType:mimeType];
        } else if ([obj isKindOfClass:[YGHttpFile class]]) {
            NSData *data = [[NSFileManager defaultManager] contentsAtPath:((YGHttpFile *) obj).filePath];
            NSString *type = [self typeForImageData:data];
            NSString *mimeType = YGIsEmptyString(type) ? @"" : [NSString stringWithFormat:@"image/%@", type];
            [formData appendPartWithFileData:data name:key fileName:[key stringByAppendingPathExtension:type] mimeType:mimeType];
        }
    };

    [fileParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *valueArray = (NSArray *) obj;
            NSString *paramKey = [NSString stringWithFormat:@"%@[]", key];
            for (id obj in valueArray) {
                addImageParamBlock(paramKey, obj);
            }
        }
        else {
            addImageParamBlock(key, obj);
        }
    }];
}

+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];

    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
            break;
        case 0x42:
            return @"bmp";
        case 0x4D:
            return @"tiff";
        default:
            break;
    }
    return nil;
}


@end