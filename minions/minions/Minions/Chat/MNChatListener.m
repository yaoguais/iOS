//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNChatListener.h"


@implementation MNChatListener

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
}

- (void)disconnectListener:(JegarnClient *)client {
    [super disconnectListener:client];
}

@end