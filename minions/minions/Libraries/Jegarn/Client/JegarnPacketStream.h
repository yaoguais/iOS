//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JegarnSecurityPolicy;


@interface JegarnPacketStream : NSObject <NSStreamDelegate>

@property (strong, nonatomic, readonly) NSStream *stream;
@property(strong, nonatomic) JegarnSecurityPolicy *securityPolicy;
@property (strong, nonatomic) NSString *securityDomain;
@property (nonatomic) BOOL enableSsl;
@property (strong, nonatomic) NSRunLoop *runLoop;
@property (strong, nonatomic) NSString *runLoopMode;
@property (nonatomic) BOOL securityPolicyApplied;

- (BOOL)applySSLSecurityPolicy:(NSStream *)readStream withEvent:(NSStreamEvent)eventCode;
- (void)startup;
- (void)shutdown;

@end