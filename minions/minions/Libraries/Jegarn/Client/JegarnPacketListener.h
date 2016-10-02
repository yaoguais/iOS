//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnPacket.h"
#import "JegarnChatPacket.h"
#import "JegarnGroupChatPacket.h"
#import "JegarnChatRoomPacket.h"
#import "JegarnNotificationPacket.h"

@interface JegarnPacketListener : NSObject
@end

@protocol JegarnChatPacketListenerDelegate
-(BOOL) processPacket:(JegarnChatPacket*)packet;
@end

@protocol JegarnGroupCHatPacketListenerDelegate
-(BOOL) processPacket:(JegarnGroupChatPacket*)packet;
@end

@protocol JegarnChatRoomPacketListenerDelegate
-(BOOL) processPacket:(JegarnChatRoomPacket *)packet;
@end

@protocol JegarnNotificationPacketListenerDelegate
-(BOOL) processPacket:(JegarnNotificationPacket *)packet;
@end