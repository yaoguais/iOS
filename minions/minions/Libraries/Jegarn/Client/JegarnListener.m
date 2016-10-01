//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnListener.h"
#import "JegarnPacket.h"
#import "JegarnClient.h"
#import "JegarnLog.h"


@implementation JegarnListener

- (void)packetListener:(JegarnPacket *)packet client:(JegarnClient *)client {
    DDLogVerbose(@"[JegarnListener] packetListener");
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