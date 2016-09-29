//
// Created by Yao Guai on 16/9/29.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//
#import "YGNSStreamTest.h"

@implementation YGNSStreamTest

- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef) @"127.0.0.1", 8883, &readStream, &writeStream);
    _inputStream = (__bridge_transfer NSInputStream *) readStream;
    _outputStream = (__bridge_transfer NSOutputStream *) writeStream;
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    [_outputStream open];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    NSString *event;
    switch (eventCode) {
        case NSStreamEventNone:
            event = @"NSStreamEventNone";
            break;
        case NSStreamEventOpenCompleted:
            event = @"NSStreamEventOpenCompleted";
            break;
        case NSStreamEventHasBytesAvailable:
            event = @"NSStreamEventHasBytesAvailable";
            if (aStream == _inputStream) {
                NSMutableData *input = [[NSMutableData alloc] init];
                uint8_t buffer[1024];
                NSInteger len;
                while ([_inputStream hasBytesAvailable]) {
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        [input appendBytes:buffer length:len];
                    }
                }
                NSString *resultstring = [[NSString alloc] initWithData:input encoding:NSUTF8StringEncoding];
                NSLog(@"接收 : %@", resultstring);
            }
            break;
        case NSStreamEventHasSpaceAvailable:
            event = @"NSStreamEventHasSpaceAvailable";
            if (aStream == _outputStream) {
                //UInt8 buff[] = "Hello Server!";
                //[_outputStream write:buff maxLength:strlen((const char *) buff) + 1];
            }
            break;
        case NSStreamEventErrorOccurred:
            event = @"NSStreamEventErrorOccurred";
            break;
        case NSStreamEventEndEncountered:
            event = @"NSStreamEventEndEncountered";
            NSLog(@"ERROR :%ld :%@", (long) [[aStream streamError] code], [[aStream streamError] localizedDescription]);
            break;
        default:
            event = @"Unknow";
            break;
    }
    NSLog(@"event ------- %@ ", event);
}

- (void)close {
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream setDelegate:nil];
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream setDelegate:nil];
}
@end