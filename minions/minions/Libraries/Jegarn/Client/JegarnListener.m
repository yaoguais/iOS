//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnListener.h"
#import "JegarnPacket.h"
#import "JegarnClient.h"
#import "JegarnLog.h"
#import "JegarnChatPacket.h"
#import "JegarnPacketManager.h"
#import "JegarnGroupChatPacket.h"
#import "JegarnChatRoomPacket.h"
#import "JegarnNotificationPacket.h"
#import "JegarnPacketListener.h"


@implementation JegarnListener

- (void)packetListener:(JegarnPacket *)packet client:(JegarnClient *)client {
    DDLogVerbose(@"[JegarnListener] packetListener %@", [packet class]);
    NSMutableArray *delegates = nil;
    if ([packet isKindOfClass:[JegarnChatPacket class]]) {
        delegates = [JegarnChatPacketManager sharedInstance].delegates;
    } else if ([packet isKindOfClass:[JegarnGroupChatPacket class]]) {
        delegates = [JegarnGroupChatPacketManager sharedInstance].delegates;
    } else if ([packet isKindOfClass:[JegarnChatRoomPacket class]]) {
        delegates = [JegarnChatRoomPacketManager sharedInstance].delegates;
    } else if ([packet isKindOfClass:[JegarnNotificationPacket class]]) {
        delegates = [JegarnNotificationPacketManager sharedInstance].delegates;
    }
    if (delegates) {
        for (NSUInteger i = 0; i < delegates.count; ++i) {
            DDLogVerbose(@"[JegarnListener] packetListener processPacket %@", delegates[i]);
            if (![delegates[i] processPacket:packet]) {
                return;
            }
        }
    }
}

- (BOOL)sendListener:(JegarnPacket *)packet client:(JegarnClient *)client {
    DDLogVerbose(@"[JegarnListener] sendListener");
    return YES;
}

- (void)errorListener:(JegarnErrorType)errorType client:(JegarnClient *)client {
    DDLogVerbose(@"[JegarnListener] errorListener");
}

- (void)connectListener:(JegarnClient *)client {
    DDLogVerbose(@"[JegarnListener] connectListener");
}

- (void)disconnectListener:(JegarnClient *)client {
    DDLogVerbose(@"[JegarnListener] disconnectListener");
}

@end