//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnGroupChatPacket.h"
#import "JegarnGroupPacketContent.h"


@implementation JegarnGroupChatPacket
@dynamic content;

+ (NSString *)packetType {
    return @"groupchat";
}

@end