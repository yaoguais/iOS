//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacketStream.h"
#import "JegarnSecurityPolicy.h"
#import "JegarnLog.h"
#import "JegarnClient.h"


@implementation JegarnPacketStream

- (void)startup {
    [self.stream setDelegate:self];
    [self.stream scheduleInRunLoop:self.client.runLoop forMode:self.client.runLoopMode];
    [self.stream open];
}

- (void)shutdown {
    [self.stream close];
    [self.stream removeFromRunLoop:self.client.runLoop forMode:self.client.runLoopMode];
    [self.stream setDelegate:nil];
}

- (void)dealloc {
    [self shutdown];
}

- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {

}

- (BOOL)applySSLSecurityPolicy:(NSStream *)readStream withEvent:(NSStreamEvent)eventCode{
    if(!self.client.securityPolicy){
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

    self.securityPolicyApplied = [self.client.securityPolicy evaluateServerTrust:serverTrust forDomain:self.client.host];
    return self.securityPolicyApplied;
}

@end