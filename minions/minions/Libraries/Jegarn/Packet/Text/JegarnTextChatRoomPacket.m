//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnTextChatRoomPacket.h"
#import "JegarnChatRoomPacket.h"


@implementation JegarnTextChatRoomPacket
@synthesize content;

- (NSMutableDictionary *)convertToDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"from"] = self.from;
    dict[@"to"] = self.to;
    dict[@"type"] = self.type;
    dict[@"content"] = @{
            @"type" : [JegarnTextChatRoomPacket packetSubType],
            @"group_id" : [NSString stringWithFormat:@"%i", self.content.groupId],
            @"text" : self.content.text ? self.content.text : @"",
    };

    return dict;
}

+ (instancetype) initWithFrom:(NSString *)from to:(NSString *)to groupId:(NSInteger)groupId text:(NSString *)text
{
    JegarnTextGroupPacketContent *textContent = [[JegarnTextGroupPacketContent alloc] init];
    textContent.groupId = groupId;
    textContent.text = text;
    JegarnTextChatRoomPacket *packet = [[JegarnTextChatRoomPacket alloc] init];
    packet.from = from;
    packet.to = to;
    packet.type = [JegarnChatRoomPacket packetType];
    packet.content = textContent;
    return packet;
}

+ (NSString *)packetSubType {
    return @"text";
}

@end