//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "jegarnHasSubTypePacketFactory.h"
#import "JegarnPacket.h"
#import "JegarnStringUtil.h"
#import "JegarnChatPacket.h"
#import "JegarnChatPacketFactory.h"
#import "JegarnGroupChatPacket.h"
#import "JegarnGroupChatPacketFactory.h"
#import "JegarnChatRoomPacket.h"
#import "JegarnChatRoomPacketFactory.h"


@implementation jegarnHasSubTypePacketFactory

static id _instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (JegarnPacket *)getPacket:(NSString *)from to:(NSString *)to type:(NSString *)type content:(id)content {
    if ([JegarnStringUtil isEmptyString:type]) {
        return nil;
    }
    if ([[JegarnChatPacket packetType] isEqualToString:type]) {
        return [[JegarnChatPacketFactory sharedInstance] getPacket:from to:to type:type content:content];
    }
    if ([[JegarnGroupChatPacket packetType] isEqualToString:type]) {
        return [[JegarnGroupChatPacketFactory sharedInstance] getPacket:from to:to type:type content:content];
    }
    if ([[JegarnChatRoomPacket packetType] isEqualToString:type]) {
        return [[JegarnChatRoomPacketFactory sharedInstance] getPacket:from to:to type:type content:content];
    }
    return nil;
}

@end