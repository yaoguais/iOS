//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnChatRoomPacket.h"
#import "JegarnGroupPacketContent.h"


@implementation JegarnChatRoomPacket
@dynamic content;

+ (NSString *)packetType {
    return @"chatroom";
}

@end