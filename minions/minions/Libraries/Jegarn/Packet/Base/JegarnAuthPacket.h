//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnPacket.h"

@class JegarnAuthPacketContent;

@interface JegarnAuthPacket : JegarnPacket
@property (nonatomic, strong, readwrite) JegarnAuthPacketContent *content;
@end