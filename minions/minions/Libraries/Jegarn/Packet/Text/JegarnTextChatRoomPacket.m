//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnTextChatRoomPacket.h"
#import "JegarnTextGroupPacketContent.h"


@implementation JegarnTextChatRoomPacket
@dynamic content;

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

+ (NSString *)packetSubType {
    return @"text";
}

@end