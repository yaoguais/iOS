//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnClient.h"
#import "JegarnListener.h"
#import "JegarnPacketReader.h"
#import "JegarnPacketWriter.h"
#import "JegarnStringUtil.h"
#import "JegarnLog.h"
#import "JegarnSecurityPolicy.h"
#import "JegarnAuthPacket.h"
#import "JegarnAuthPacketContent.h"


@implementation JegarnClient {
    NSTimeInterval _reconnectInterval;
}

- (BOOL)checkConfig {
    if ([JegarnStringUtil isEmptyString:self.account]) {
        DDLogError(@"[JegarnClient] empty account");
        return NO;
    }
    if ([JegarnStringUtil isEmptyString:self.password]) {
        DDLogError(@"[JegarnClient] empty password");
        return NO;
    }
    if ([JegarnStringUtil isEmptyString:self.host]) {
        DDLogError(@"[JegarnClient] empty host");
        return NO;
    }

    if (self.port <= 0) {
        DDLogError(@"[JegarnClient] port error");
        return NO;
    }

    if (!self.listener) {
        DDLogError(@"[JegarnClient] empty listener");
        return NO;
    }

    if (!self.runLoop) {
        DDLogError(@"[JegarnClient] empty runLoop");
        return NO;
    }

    if ([JegarnStringUtil isEmptyString:self.runLoopMode]) {
        DDLogError(@"[JegarnClient] empty runLoopMode");
        return NO;
    }

    if (self.enableSsl && !self.securityPolicy) {
        DDLogError(@"[JegarnClient] empty securityPolicy");
        return NO;
    }

    return YES;
}

- (BOOL)initSocket {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;

    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef) self.host, self.port, &readStream, &writeStream);
    CFReadStreamSetProperty(readStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
    CFWriteStreamSetProperty(writeStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);

    if (self.enableSsl) {
        NSMutableDictionary *sslOptions = [[NSMutableDictionary alloc] init];
        sslOptions[(NSString *) kCFStreamSSLLevel] = (NSString *) kCFStreamSocketSecurityLevelNegotiatedSSL;
        sslOptions[(NSString *) kCFStreamSSLValidatesCertificateChain] = @NO;

        if (self.certificates) {
            sslOptions[(NSString *) kCFStreamSSLCertificates] = self.certificates;
        }

        if (!CFReadStreamSetProperty(readStream, kCFStreamPropertySSLSettings, (__bridge CFDictionaryRef) (sslOptions))) {
            DDLogError(@"[JegarnClient] Fail to init ssl input stream!");
            return NO;
        }

        if (!CFWriteStreamSetProperty(writeStream, kCFStreamPropertySSLSettings, (__bridge CFDictionaryRef) (sslOptions))) {
            DDLogError(@"[JegarnClient] Fail to init ssl output stream!");
            return NO;
        }
    }

    self.packetReader = [[JegarnPacketReader alloc] init];
    self.packetReader.client = self;
    self.packetReader.stream = CFBridgingRelease(readStream);

    self.packetWriter = [[JegarnPacketWriter alloc] init];
    self.packetWriter.client = self;
    self.packetWriter.stream = CFBridgingRelease(writeStream);

    return YES;
}

- (BOOL)connect {
    if (self.running) {
        return NO;
    }
    if (![self checkConfig]) {
        return NO;
    }
    if (![self initSocket]) {
        [self disconnect];
        return NO;
    }
    [self.packetReader startup];
    [self.packetWriter startup];
    self.uid = @"";
    self.sessionId = @"";
    self.authorized = NO;
    self.reconnectTimer = nil;
    self.running = YES;
    DDLogVerbose(@"[JegarnClient] connect");

    return YES;
}

- (void)disconnect {
    self.running = NO;
    if (self.reconnectTimer) {
        [self.reconnectTimer invalidate];
        self.reconnectTimer = nil;
    }
    if (self.packetReader) {
        [self.packetReader shutdown];
    }
    if (self.packetWriter) {
        [self.packetWriter shutdown];
    }
    DDLogVerbose(@"[JegarnClient] disconnect");
    [self.listener disconnectListener:self];
}

- (void)reconnect {
    DDLogVerbose(@"[JegarnClient] reconnect");
    [self disconnect];
    [self connect];
}

- (void)reconnectDelayInterval {
    self.running = NO;
    if (self.reconnectInterval > 0 && !self.reconnectTimer) {
        self.reconnectTimer = [NSTimer timerWithTimeInterval:self.reconnectInterval
                                                      target:self
                                                    selector:@selector(reconnect)
                                                    userInfo:nil repeats:NO];
        [self.runLoop addTimer:self.reconnectTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void)auth {
    if (!self.authorized) {
        JegarnAuthPacket *packet = [[JegarnAuthPacket alloc] init];
        packet.content.account = self.account;
        packet.content.password = self.password;
        [self sendPacket:packet];
    }
}

- (BOOL)sendPacket:(JegarnPacket *)packet {
    if (self.packetWriter) {
        return [self.packetWriter sendPacket:packet];
    }
    return NO;
}

@end