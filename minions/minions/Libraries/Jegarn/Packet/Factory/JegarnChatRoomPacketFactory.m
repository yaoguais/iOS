//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnChatRoomPacketFactory.h"
#import "JegarnPacket.h"
#import "JegarnTextChatRoomPacket.h"


@implementation JegarnChatRoomPacketFactory

static id _instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (JegarnPacket *)getPacket:(NSString *)from to:(NSString *)to type:(NSString *)type content:(id)content
{
    if (!content || ![content isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    NSString *subType = content[@"type"];
    if ([[JegarnTextChatRoomPacket packetSubType] isEqualToString:subType]) {
        NSString *text = content[@"text"];
        NSInteger groupId = [(NSNumber *) content[@"group_id"] integerValue];
        JegarnTextGroupPacketContent *textContent = [[JegarnTextGroupPacketContent alloc] init];
        textContent.groupId = groupId;
        textContent.text = text;
        JegarnTextChatRoomPacket *packet = [[JegarnTextChatRoomPacket alloc] init];
        packet.from = from;
        packet.to = to;
        packet.type = type;
        packet.content = textContent;
        return packet;
    }

    return nil;
}

@end