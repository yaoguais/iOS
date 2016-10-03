//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacketWriter.h"
#import "JegarnLog.h"
#import "JegarnClient.h"
#import "JegarnListener.h"
#import "MPMessagePackWriter.h"
#import "JegarnConvertUtil.h"

@interface JegarnPacketWriter()
@property (strong, nonatomic) NSMutableData *buffer;
@property (nonatomic) BOOL enableWrite;
@property (nonatomic) BOOL isSendAuthPacket;
@end
@implementation JegarnPacketWriter {
@private
    NSOutputStream *_stream;
}
@synthesize stream = _stream;

- (instancetype)init {
    self = [super init];
    if (self) {
        _buffer = [[NSMutableData alloc] init];
    }

    return self;
}

- (void)startup {
    self.enableWrite = NO;
    self.isSendAuthPacket = NO;
    [super startup];
}

- (void)shutdown {
    self.enableWrite = NO;
    self.isSendAuthPacket = NO;
    [super shutdown];
}


- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {
#ifdef DEBUG
    [self streamHandledEvents:eventCode];
#endif

    if (eventCode & NSStreamEventHasSpaceAvailable) {
        if (self.client.enableSsl && ![self applySSLSecurityPolicy:sender withEvent:eventCode]) {
            DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventHasSpaceAvailable error %@", sender.streamError);
            self.enableWrite = NO;
        } else {
            self.enableWrite = YES;
            if (!self.isSendAuthPacket) {
                self.isSendAuthPacket = YES;
                [self.client auth];
            }
        }
    }
    if (eventCode & NSStreamEventErrorOccurred) {
        [self.client.listener errorListener:JegarnErrorTypeNetworkError client:self.client];
        [self.client reconnectDelayInterval];
    }
}

- (BOOL)sendPacket:(JegarnPacket *)packet {
    DDLogVerbose(@"[JegarnPacketWriter] sendPacket pending");
    if (![self.client.listener sendListener:packet client:self.client]) {
        return NO;
    }
    NSMutableDictionary *packetDict = packet.convertToDictionary;
    packetDict[JegarnSessionKey] = self.client.sessionId;

    NSError *error = nil;
    NSData *packetData = [MPMessagePackWriter writeObject:packetDict error:&error];
    if (error) {
        DDLogVerbose(@"[JegarnPacketWriter] sendPacket error %@", error);
        return NO;
    }

    NSData *lengthData = [JegarnConvertUtil intToBinaryString:[packetData length]];
    @synchronized (self) {
        [self.buffer appendData:lengthData];
        [self.buffer appendData:packetData];
    }

    return [self send:nil];
}

- (BOOL)send:(NSData *)data {
    DDLogVerbose(@"[JegarnPacketWriter] send data(client.running:%d enableWrite:%d)", self.client.running, self.enableWrite);
    if (!self.client.running) {
        return NO;
    }
    @synchronized(self) {
        if (!self.enableWrite) {
            return NO;
        }

        if (data) {
            [self.buffer appendData:data];
        }

        if (self.buffer.length) {
            DDLogVerbose(@"[JegarnPacketWriter] buffer to write (%lu)=%@...",
                    (unsigned long)self.buffer.length,
                    [self.buffer subdataWithRange:NSMakeRange(0, MIN(256, self.buffer.length))]);

            NSInteger n = [self.stream write:self.buffer.bytes maxLength:self.buffer.length];
            if (n == -1) {
                DDLogVerbose(@"[JegarnPacketWriter] streamError: %@", self.stream.streamError);
                return NO;
            } else {
                if (n < self.buffer.length) {
                    DDLogVerbose(@"[JegarnPacketWriter] buffer partially written: %ld", (long) n);
                }
                [self.buffer replaceBytesInRange:NSMakeRange(0, n) withBytes:NULL length:0];
            }
        }
        return YES;
    }
}

- (void)streamHandledEvents:(NSStreamEvent)eventCode {
    if (eventCode & NSStreamEventNone) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventNone");
    }
    if (eventCode & NSStreamEventOpenCompleted) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventOpenCompleted");
    }
    if (eventCode & NSStreamEventHasBytesAvailable) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventHasBytesAvailable");
    }
    if (eventCode & NSStreamEventHasSpaceAvailable) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventHasSpaceAvailable");
    }
    if (eventCode & NSStreamEventErrorOccurred) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventErrorOccurred");
    }
    if (eventCode & NSStreamEventEndEncountered) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventEndEncountered");
    }
}

@end