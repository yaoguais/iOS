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
        NSInteger groupId = [(NSNumber *) content[@"group_id"] integerValue];
        NSString *text = content[@"text"];
        return [JegarnTextGroupChatPacket initWithFrom:from to:to groupId:groupId text:text];
    }

    return nil;
}

@end