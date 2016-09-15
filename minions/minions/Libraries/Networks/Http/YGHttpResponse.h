//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YGHttpResponse : NSObject

@property (strong, nonatomic) NSURLResponse *response;
@property (strong, nonatomic) id responseObject;
@property (strong, nonatomic) NSError *error;

- (instancetype)initWithUrlResponse:(NSURLResponse *)response responseObject:(id)responseObject error:(NSError *)error;

@end