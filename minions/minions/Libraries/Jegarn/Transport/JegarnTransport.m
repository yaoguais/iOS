//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnTransport.h"
#import "JegarnLog.h"

@implementation JegarnTransport

@synthesize state;
@synthesize delegate;
@synthesize runLoop;
@synthesize runLoopMode;

- (instancetype)init {
    self = [super init];
    self.state = JegarnTransportCreated;
    self.runLoop = [NSRunLoop currentRunLoop];
    self.runLoopMode = NSDefaultRunLoopMode;
    return self;
}

- (void)open {
    DDLogError(@"JegarnTransport is abstract class");
}

- (void)close {
    DDLogError(@"JegarnTransport is abstract class");
}

- (BOOL)send:(NSData *)data {
    DDLogError(@"JegarnTransport is abstract class");
    return FALSE;
}

@end