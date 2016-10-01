//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacketReader.h"
#import "JegarnLog.h"

@implementation JegarnPacketReader {
@private
    NSInputStream *_stream;
}

@synthesize stream = _stream;

- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {
    DDLogVerbose(@"[JegarnPacketReader] NSStreamEvent %d", eventCode);

    if (eventCode &  NSStreamEventHasBytesAvailable) {
        if(self.enableSsl){
            if (![self applySSLSecurityPolicy:sender withEvent:eventCode]){
                DDLogVerbose(@"[JegarnPacketReader] NSStreamEventHasBytesAvailable error %@", sender.streamError);
            }else{
                [self parsePackets:sender];
            }
        }else{
            [self parsePackets:sender];
        }
    }

    if (eventCode &  NSStreamEventEndEncountered) {}
    if (eventCode &  NSStreamEventErrorOccurred) {}
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



@end