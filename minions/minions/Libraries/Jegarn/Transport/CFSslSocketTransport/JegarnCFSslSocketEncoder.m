//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnCFSslSocketEncoder.h"
#import "JegarnCFSslSecurityPolicy.h"
#import "JegarnLog.h"

@interface JegarnCFSslSocketEncoder()
@property (nonatomic) BOOL securityPolicyApplied;

@end

@implementation JegarnCFSslSocketEncoder

- (instancetype)init {
    self = [super init];
    self.securityPolicy = nil;
    self.securityDomain = nil;

    return self;
}

- (BOOL)applySSLSecurityPolicy:(NSStream *)writeStream withEvent:(NSStreamEvent)eventCode;
{
    if(!self.securityPolicy){
        return YES;
    }

    if(self.securityPolicyApplied){
        return YES;
    }

    SecTrustRef serverTrust = (__bridge SecTrustRef) [writeStream propertyForKey: (__bridge NSString *)kCFStreamPropertySSLPeerTrust];
    if(!serverTrust){
        return NO;
    }

    self.securityPolicyApplied = [self.securityPolicy evaluateServerTrust:serverTrust forDomain:self.securityDomain];
    return self.securityPolicyApplied;
}

- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {

    if (eventCode & NSStreamEventHasSpaceAvailable) {
        DDLogVerbose(@"[JegarnCFSocketEncoder] NSStreamEventHasSpaceAvailable");
        if(![self applySSLSecurityPolicy:sender withEvent:eventCode]){
            self.state = JegarnCFSocketEncoderStateError;
            self.error = [NSError errorWithDomain:@"Jegarn"
                                             code:errSSLXCertChainInvalid
                                         userInfo:@{NSLocalizedDescriptionKey: @"Unable to apply security policy, the SSL connection is insecure!"}];
        }
    }
    [super stream:sender handleEvent:eventCode];
}

@end