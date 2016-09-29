//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnCFSocketEncoder.h"

#import "JegarnLog.h"

@interface JegarnCFSocketEncoder()
@property (strong, nonatomic) NSMutableData *buffer;

@end

@implementation JegarnCFSocketEncoder

- (instancetype)init {
    self = [super init];
    self.state = JegarnCFSocketEncoderStateInitializing;
    self.buffer = [[NSMutableData alloc] init];

    self.stream = nil;
    self.runLoop = [NSRunLoop currentRunLoop];
    self.runLoopMode = NSDefaultRunLoopMode;

    return self;
}

- (void)dealloc {
    NSLog(@"output stream dealloc");
    [self close];
}

- (void)open {
    [self.stream setDelegate:self];
    [self.stream scheduleInRunLoop:self.runLoop forMode:self.runLoopMode];
    [self.stream open];
}

- (void)close {
    [self.stream close];
    [self.stream removeFromRunLoop:self.runLoop forMode:self.runLoopMode];
    [self.stream setDelegate:nil];
}

- (void)setState:(JegarnCFSocketEncoderState)state {
    DDLogVerbose(@"[JegarnCFSocketEncoder] setState %ld/%ld", (long)_state, (long)state);
    _state = state;
}

- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {

    DDLogVerbose(@"[JegarnCFSocketEncoder] NSStreamEvent %d", eventCode);

    if (eventCode & NSStreamEventOpenCompleted) {
        DDLogVerbose(@"[JegarnCFSocketEncoder] NSStreamEventOpenCompleted");
    }
    if (eventCode & NSStreamEventHasBytesAvailable) {
        DDLogVerbose(@"[JegarnCFSocketEncoder] NSStreamEventHasBytesAvailable");
    }

    if (eventCode & NSStreamEventHasSpaceAvailable) {
        DDLogVerbose(@"[JegarnCFSocketEncoder] NSStreamEventHasSpaceAvailable");
        if (self.state == JegarnCFSocketEncoderStateInitializing) {
            self.state = JegarnCFSocketEncoderStateReady;
            [self.delegate encoderDidOpen:self];
        }

        if (self.state == JegarnCFSocketEncoderStateReady) {
            if (self.buffer.length) {
                [self send:nil];
            }
        }
    }

    if (eventCode &  NSStreamEventEndEncountered) {
        DDLogVerbose(@"[JegarnCFSocketEncoder] NSStreamEventEndEncountered");
        self.state = JegarnCFSocketEncoderStateInitializing;
        self.error = nil;
        [self.delegate encoderdidClose:self];
    }

    if (eventCode &  NSStreamEventErrorOccurred) {
        DDLogVerbose(@"[JegarnCFSocketEncoder] NSStreamEventErrorOccurred");
        self.state = JegarnCFSocketEncoderStateError;
        self.error = self.stream.streamError;
        [self.delegate encoder:self didFailWithError:self.error];
    }
}

- (BOOL)send:(NSData *)data {
    @synchronized(self) {
        if (self.state != JegarnCFSocketEncoderStateReady) {
            DDLogInfo(@"[JegarnCFSocketEncoder] not JegarnCFSocketEncoderStateReady");
            return FALSE;
        }

        if (data) {
            [self.buffer appendData:data];
        }

        if (self.buffer.length) {
            DDLogVerbose(@"[JegarnCFSocketEncoder] buffer to write (%lu)=%@...",
                    (unsigned long)self.buffer.length,
                    [self.buffer subdataWithRange:NSMakeRange(0, MIN(256, self.buffer.length))]);

            NSInteger n = [self.stream write:self.buffer.bytes maxLength:self.buffer.length];

            if (n == -1) {
                DDLogVerbose(@"[JegarnCFSocketEncoder] streamError: %@", self.error);
                self.state = JegarnCFSocketEncoderStateError;
                self.error = self.stream.streamError;
                return FALSE;
            } else {
                if (n < self.buffer.length) {
                    DDLogVerbose(@"[JegarnCFSocketEncoder] buffer partially written: %ld", (long)n);
                }
                [self.buffer replaceBytesInRange:NSMakeRange(0, n) withBytes:NULL length:0];
            }
        }
        return TRUE;
    }
}

@end