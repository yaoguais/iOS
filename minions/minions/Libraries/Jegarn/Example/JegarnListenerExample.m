//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnListenerExample.h"
#import "JegarnLog.h"
#import "JegarnTextChatPacket.h"
#import "JegarnTextGroupChatPacket.h"
#import "JegarnTextChatRoomPacket.h"


@implementation JegarnListenerExample

- (void)packetListener:(JegarnPacket *)packet client:(JegarnClient *)client {
    [super packetListener:packet client:client];
}

- (BOOL)sendListener:(JegarnPacket *)packet client:(JegarnClient *)client {
    return [super sendListener:packet client:client];
}

- (void)errorListener:(JegarnErrorType)errorType client:(JegarnClient *)client {
    [super errorListener:errorType client:client];
}

- (void)connectListener:(JegarnClient *)client {
    [super connectListener:client];
    [client sendPacket:[JegarnTextChatPacket initWithFrom:@"2000" to:@"2001" text:@"ios chat msg"]];
    [client sendPacket:[JegarnTextGroupChatPacket initWithFrom:@"2002" to:@"2003" groupId:2004 text:@"ios group chat msg"]];
    [client sendPacket:[JegarnTextChatRoomPacket initWithFrom:@"2005" to:@"2006" groupId:2007 text:@"ios group chat msg"]];
}

- (void)disconnectListener:(JegarnClient *)client {
    [super disconnectListener:client];
}

@end