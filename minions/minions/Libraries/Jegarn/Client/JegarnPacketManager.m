//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacketManager.h"
#import "JegarnPacket.h"

#define JegarnPacketManagersImplementationSharedInstance \
static id _instance;                                     \
+ (instancetype)sharedInstance {                         \
    static dispatch_once_t onceToken;                    \
    dispatch_once(&onceToken, ^{                         \
        _instance = [[self alloc] init];                 \
    });                                                  \
    return _instance;                                    \
}

@implementation JegarnPacketManager
JegarnPacketManagersImplementationSharedInstance;

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegates = [[NSMutableArray alloc] init];
    }

    return self;
}

- (BOOL)addDelegate:(id)delegate {
    for (NSUInteger i = 0; i < _delegates.count; ++i) {
        if (_delegates[i] == delegate) {
            return NO;
        }
    }
    [_delegates addObject:delegate];
    return YES;
}

- (BOOL)removeDelegate:(id)delegate
{
    for (NSUInteger i = 0; i < _delegates.count; ++i) {
        if (_delegates[i] == delegate) {
            [_delegates removeObjectAtIndex:i];
            return YES;
        }
    }
    return NO;
}

@end

@implementation JegarnChatPacketManager
JegarnPacketManagersImplementationSharedInstance;
@end

@implementation JegarnGroupChatPacketManager
JegarnPacketManagersImplementationSharedInstance;
@end

@implementation JegarnChatRoomPacketManager
JegarnPacketManagersImplementationSharedInstance;
@end

@implementation JegarnNotificationPacketManager
JegarnPacketManagersImplementationSharedInstance;
@end