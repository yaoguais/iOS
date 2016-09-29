//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnCFSocketTransport.h"
#import "JegarnLog.h"

@interface JegarnCFSocketTransport()
@property (strong, nonatomic) JegarnCFSocketEncoder *encoder;
@property (strong, nonatomic) JegarnCFSocketDecoder *decoder;
@end

@implementation JegarnCFSocketTransport

@synthesize state;
@synthesize delegate;
@synthesize runLoop;
@synthesize runLoopMode;

- (instancetype)init {
    self = [super init];
    self.host = @"127.0.0.1";
    self.port = 8883;
    self.runLoop = [NSRunLoop currentRunLoop];
    self.runLoopMode = NSDefaultRunLoopMode;
    self.tls = false;
    self.certificates = nil;
    return self;
}

- (void)open {
    DDLogVerbose(@"[JegarnCFSocketTransport] open");
    self.state = JegarnTransportOpening;

    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;

    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)self.host, self.port, &readStream, &writeStream);
    CFReadStreamSetProperty(readStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
    CFWriteStreamSetProperty(writeStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);


    self.decoder.delegate = nil;
    self.decoder = [[JegarnCFSocketDecoder alloc] init];
    self.decoder.stream =  CFBridgingRelease(readStream);
    self.decoder.runLoop = self.runLoop;
    self.decoder.runLoopMode = self.runLoopMode;
    self.decoder.delegate = self;

    self.encoder.delegate = nil;
    self.encoder = [[JegarnCFSocketEncoder alloc] init];
    self.encoder.stream = CFBridgingRelease(writeStream);
    self.encoder.runLoop = self.runLoop;
    self.encoder.runLoopMode = self.runLoopMode;
    self.encoder.delegate = self;

    [self.decoder open];
    [self.encoder open];
}

- (void)close {
    DDLogVerbose(@"[JegarnCFSocketTransport] close");
    self.state = JegarnTransportClosing;

    if (self.encoder) {
        [self.encoder close];
        self.encoder.delegate = nil;
    }

    if (self.decoder) {
        [self.decoder close];
        self.decoder.delegate = nil;
    }
}

- (BOOL)send:(nonnull NSData *)data {
    return [self.encoder send:data];
}

- (void)decoder:(JegarnCFSocketDecoder *)sender didReceiveMessage:(nonnull NSData *)data {
    [self.delegate JegarnTransport:self didReceiveMessage:data];
}

- (void)decoder:(JegarnCFSocketDecoder *)sender didFailWithError:(NSError *)error {
    //self.state = JegarnTransportClosing;
    //[self.delegate JegarnTransport:self didFailWithError:error];
}
- (void)encoder:(JegarnCFSocketEncoder *)sender didFailWithError:(NSError *)error {
    self.state = JegarnTransportClosing;
    [self.delegate JegarnTransport:self didFailWithError:error];
}

- (void)decoderdidClose:(JegarnCFSocketDecoder *)sender {
    self.state = JegarnTransportClosed;
    [self.delegate JegarnTransportDidClose:self];
}
- (void)encoderdidClose:(JegarnCFSocketEncoder *)sender {
    //self.state = JegarnTransportClosed;
    //[self.delegate JegarnTransportDidClose:self];
}

- (void)decoderDidOpen:(JegarnCFSocketDecoder *)sender {
    //self.state = JegarnTransportOpen;
    //[self.delegate JegarnTransportDidOpen:self];
}
- (void)encoderDidOpen:(JegarnCFSocketEncoder *)sender {
    self.state = JegarnTransportOpen;
    [self.delegate JegarnTransportDidOpen:self];
}
@end