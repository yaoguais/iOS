//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnChatPacketFactory.h"
#import "JegarnPacket.h"
#import "JegarnTextChatPacket.h"


@implementation JegarnChatPacketFactory

static id _instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (JegarnPacket *)getPacket:(NSString *)from to:(NSString *)to type:(NSString *)type content:(id)content {
    if (!content || ![content isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    NSString *subType = content[@"type"];
    if ([[JegarnTextChatPacket packetSubType] isEqualToString:subType]) {
        NSString *text = content[@"text"];
        return [JegarnTextChatPacket initWithFrom:from to:to text:text];
    }

    return nil;
}

@end