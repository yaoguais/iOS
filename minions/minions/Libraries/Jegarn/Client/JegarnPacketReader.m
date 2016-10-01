//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacketReader.h"
#import "JegarnLog.h"
#import "JegarnClient.h"
#import "JegarnListener.h"

@implementation JegarnPacketReader {
@private
    NSInputStream *_stream;
}

@synthesize stream = _stream;

- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {
#ifdef DEBUG
    [self streamHandledEvents:eventCode];
#endif

    if (eventCode &  NSStreamEventHasBytesAvailable) {
        if(self.client.enableSsl){
            if (![self applySSLSecurityPolicy:sender withEvent:eventCode]){
                DDLogVerbose(@"[JegarnPacketReader] NSStreamEventHasBytesAvailable error %@", sender.streamError);
            }else{
                [self parsePackets:sender];
            }
        }else{
            [self parsePackets:sender];
        }
    }

    if (eventCode &  NSStreamEventErrorOccurred) {
        [self.client.listener errorListener:JegarnErrorTypeNetworkError client:self.client];
        [self.client reconnectDelayInterval];
    }
}

- (void) parsePackets:(NSStream *) sender
{
    NSInteger n;
    UInt8 buffer[768];

    n = [(NSInputStream *) sender read:buffer maxLength:sizeof(buffer)];
    if (n == -1) {
        DDLogVerbose(@"[JegarnPacketReader] parsePackets error %@", self.stream.streamError);
    } else {
        NSData *data = [NSData dataWithBytes:buffer length:n];
        const int strShortLen = 256;
        NSString *strShortData = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, MIN(strShortLen, data.length))] encoding:NSUTF8StringEncoding];
        DDLogVerbose(@"[JegarnPacketReader] received (%lu)=%@%@", (unsigned long) data.length, strShortData, data.length > strShortLen ? @"..." : @"");
    }
}

- (void)streamHandledEvents:(NSStreamEvent)eventCode {
    if (eventCode & NSStreamEventNone) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventNone");
    }
    if (eventCode & NSStreamEventOpenCompleted) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventOpenCompleted");
    }
    if (eventCode & NSStreamEventHasBytesAvailable) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventHasBytesAvailable");
    }
    if (eventCode & NSStreamEventHasSpaceAvailable) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventHasSpaceAvailable");
    }
    if (eventCode & NSStreamEventErrorOccurred) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventErrorOccurred");
    }
    if (eventCode & NSStreamEventEndEncountered) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventEndEncountered");
    }
}

@end