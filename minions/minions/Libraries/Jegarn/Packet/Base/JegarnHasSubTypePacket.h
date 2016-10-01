//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnPacket.h"


@class JegarnHasSubTypePacketContent;

@interface JegarnHasSubTypePacket : JegarnPacket

@property (nonatomic, readonly) JegarnHasSubTypePacketContent *content;
+ (NSString *) packetSubType;

@end