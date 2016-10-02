//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnTextGroupPacketContent.h"
#import "JegarnChatRoomPacket.h"

@interface JegarnTextChatRoomPacket : JegarnChatRoomPacket
@property (nonatomic, readwrite, strong) JegarnTextGroupPacketContent *content;
+ (instancetype) initWithFrom:(NSString *)from to:(NSString *)to groupId:(NSInteger)groupId text:(NSString *)text;
@end