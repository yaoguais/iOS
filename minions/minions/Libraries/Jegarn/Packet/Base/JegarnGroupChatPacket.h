//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnGroupPacket.h"
#import "JegarnGroupPacketContent.h"

@interface JegarnGroupChatPacket : JegarnGroupPacket
@property (nonatomic, readonly) JegarnGroupPacketContent *content;
@end