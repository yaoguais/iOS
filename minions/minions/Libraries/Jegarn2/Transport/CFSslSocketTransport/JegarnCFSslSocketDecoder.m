//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnCFSslSocketDecoder.h"
#import "JegarnSecurityPolicy.h"
#import "JegarnLog.h"

@interface JegarnCFSslSocketDecoder()
@property (nonatomic) BOOL securityPolicyApplied;

@end

@implementation JegarnCFSslSocketDecoder

- (instancetype)init {
    self = [super init];
    self.securityPolicy = nil;
    self.securityDomain = nil;

    return self;
}

- (BOOL)applySSLSecurityPolicy:(NSStream *)readStream withEvent:(NSStreamEvent)eventCode{
    if(!self.securityPolicy){
        return YES;
    }

    if(self.securityPolicyApplied){
        return YES;
    }

    SecTrustRef serverTrust = (__bridge SecTrustRef) [readStream propertyForKey: (__bridge NSString *)kCFStreamPropertySSLPeerTrust];
    if(!serverTrust){
        DDLogVerbose(@"[JegarnCFSslSocketDecoder] serverTrust failed");
        return NO;
    }

    self.securityPolicyApplied = [self.securityPolicy evaluateServerTrust:serverTrust forDomain:self.securityDomain];
    return self.securityPolicyApplied;
}

- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {

    if (eventCode &  NSStreamEventHasBytesAvailable) {
        DDLogVerbose(@"[JegarnCFSslSocketDecoder] NSStreamEventHasBytesAvailable");
        if (![self applySSLSecurityPolicy:sender withEvent:eventCode]){
            self.state = JegarnCFSocketDecoderStateError;
            self.error = [NSError errorWithDomain:@"Jegarn"
                                             code:errSSLXCertChainInvalid
                                         userInfo:@{NSLocalizedDescriptionKey: @"Unable to apply security policy, the SSL connection is insecure!"}];
            DDLogVerbose(@"[JegarnCFSslSocketDecoder] NSStreamEventHasBytesAvailable error %@", self.error);
        }else{
            [super stream:sender handleEvent:eventCode];
        }
    }else{
        [super stream:sender handleEvent:eventCode];
    }
}

@end