//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGHttpResponse.h"


@implementation YGHttpResponse

- (instancetype)initWithUrlResponse: (NSURLResponse *) response  responseObject:(id) responseObject error:(NSError *) error
{
    self = [super init];
    if (self) {
        _response = response;
        _responseObject = responseObject;
        _error = error;
    }

    return self;
}

@end