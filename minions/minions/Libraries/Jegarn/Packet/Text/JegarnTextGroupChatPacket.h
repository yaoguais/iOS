//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnGroupChatPacket.h"
#import "JegarnTextGroupPacketContent.h"

@interface JegarnTextGroupChatPacket : JegarnGroupChatPacket
@property (nonatomic, readwrite, strong) JegarnTextGroupPacketContent *content;
@end