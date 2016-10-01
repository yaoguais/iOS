//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnPacket.h"
#import "JegarnAuthPacketContent.h"

typedef enum {
    JegarnAuthPacketStatusNeedAuth = 1,
    JegarnAuthPacketStatusAuthSuccess = 2,
    JegarnAuthPacketStatusAuthFailed = 3
}JegarnAuthPacketStatus;

@interface JegarnAuthPacket : JegarnPacket
@property (nonatomic, strong) JegarnAuthPacketContent *content;
@end