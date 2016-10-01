//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnGroupChatPacketFactory.h"
#import "JegarnPacket.h"
#import "JegarnTextGroupPacketContent.h"
#import "JegarnTextGroupChatPacket.h"


@implementation JegarnGroupChatPacketFactory

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
    if ([[JegarnTextGroupChatPacket packetSubType] isEqualToString:subType]) {
        NSString *text = content[@"text"];
        JegarnTextGroupPacketContent *textContent = [[JegarnTextGroupPacketContent alloc] init];
        textContent.text = text;
        JegarnTextGroupChatPacket *packet = [[JegarnTextGroupChatPacket alloc] init];
        packet.from = from;
        packet.to = to;
        packet.type = type;
        packet.content = textContent;
        return packet;
    }

    return nil;
}

@end