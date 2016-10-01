//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnTextChatPacket.h"


@implementation JegarnTextChatPacket
@synthesize content;

+ (instancetype)initWithFrom:(NSString *)from to:(NSString *)to text:(NSString *)text
{
    JegarnTextChatPacketContent *textContent = [[JegarnTextChatPacketContent alloc] init];
    textContent.text = text;
    JegarnTextChatPacket *packet = [[JegarnTextChatPacket alloc] init];
    packet.from = from;
    packet.to = to;
    packet.type = [JegarnChatPacket packetType];
    packet.content = textContent;

    return packet;
}

- (NSMutableDictionary *)convertToDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"from"] = self.from;
    dict[@"to"] = self.to;
    dict[@"type"] = self.type;
    dict[@"content"] = @{
            @"type" : [JegarnTextChatPacket packetSubType],
            @"text" : self.content.text ? self.content.text : @"",
    };

    return dict;
}


+ (NSString *)packetSubType {
    return @"text";
}

@end