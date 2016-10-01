//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnPacketStream.h"
#import "JegarnPacket.h"

@interface JegarnPacketWriter : JegarnPacketStream
@property (strong, nonatomic, readwrite) NSOutputStream *stream;

- (BOOL)sendPacket:(JegarnPacket *)packet;

@end