//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JegarnSecurityPolicy;
@class JegarnClient;


@interface JegarnPacketStream : NSObject <NSStreamDelegate>

@property (weak, nonatomic) JegarnClient * client;
@property (strong, nonatomic, readonly) NSStream *stream;
@property (nonatomic) BOOL securityPolicyApplied;

- (BOOL)applySSLSecurityPolicy:(NSStream *)readStream withEvent:(NSStreamEvent)eventCode;
- (void)startup;
- (void)shutdown;

@end