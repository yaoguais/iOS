//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnCFSocketDecoder.h"

#import "JegarnLog.h"

@interface JegarnCFSocketDecoder()

@end

@implementation JegarnCFSocketDecoder

- (instancetype)init {
    self = [super init];
    self.state = JegarnCFSocketDecoderStateInitializing;

    self.stream = nil;
    self.runLoop = [NSRunLoop currentRunLoop];
    self.runLoopMode = NSDefaultRunLoopMode;
    return self;
}

- (void)open {
    if (self.state == JegarnCFSocketDecoderStateInitializing) {
        [self.stream setDelegate:self];
        [self.stream scheduleInRunLoop:self.runLoop forMode:self.runLoopMode];
        [self.stream open];
    }
}

- (void)dealloc {
    [self close];
}

- (void)close {
    [self.stream close];
    [self.stream removeFromRunLoop:self.runLoop forMode:self.runLoopMode];
    [self.stream setDelegate:nil];
}

- (void)setState:(JegarnCFSocketDecoderState)state {
    DDLogVerbose(@"[JegarnCFSocketDecoder] setState %ld/%ld", (long)_state, (long)state);
    _state = state;
}

- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {

    DDLogVerbose(@"[JegarnCFSocketDecoder] NSStreamEvent %d", eventCode);

    if (eventCode & NSStreamEventOpenCompleted) {
        DDLogVerbose(@"[JegarnCFSocketDecoder] NSStreamEventOpenCompleted");
        self.state = JegarnCFSocketDecoderStateReady;
        [self.delegate decoderDidOpen:self];
    }

    if (eventCode &  NSStreamEventHasBytesAvailable) {
        DDLogVerbose(@"[JegarnCFSocketDecoder] NSStreamEventHasBytesAvailable");
        if (self.state == JegarnCFSocketDecoderStateInitializing) {
            self.state = JegarnCFSocketDecoderStateReady;
        }

        if (self.state == JegarnCFSocketDecoderStateReady) {
            NSInteger n;
            UInt8 buffer[768];

            n = [self.stream read:buffer maxLength:sizeof(buffer)];
            if (n == -1) {
                self.state = JegarnCFSocketDecoderStateError;
                [self.delegate decoder:self didFailWithError:nil];
            } else {
                NSData *data = [NSData dataWithBytes:buffer length:n];
                const int strShortLen = 256;
                NSString *strShortData = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, MIN(strShortLen, data.length))] encoding:NSUTF8StringEncoding];
                DDLogVerbose(@"[JegarnCFSocketDecoder] received (%lu)=%@%@", (unsigned long) data.length, strShortData, data.length > strShortLen ? @"..." : @"");
                [self.delegate decoder:self didReceiveMessage:data];
            }
        }
    }
    if (eventCode &  NSStreamEventHasSpaceAvailable) {
        DDLogVerbose(@"[JegarnCFSocketDecoder] NSStreamEventHasSpaceAvailable");
    }

    if (eventCode &  NSStreamEventEndEncountered) {
        DDLogVerbose(@"[JegarnCFSocketDecoder] NSStreamEventEndEncountered");
        self.state = JegarnCFSocketDecoderStateInitializing;
        self.error = nil;
        [self.delegate decoderdidClose:self];
    }

    if (eventCode &  NSStreamEventErrorOccurred) {
        DDLogVerbose(@"[JegarnCFSocketDecoder] NSStreamEventErrorOccurred");
        self.state = JegarnCFSocketDecoderStateError;
        self.error = self.stream.streamError;
        [self.delegate decoder:self didFailWithError:self.error];
    }
}

@end
