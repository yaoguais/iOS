//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnChatPacket.h"
#import "JegarnTextChatPacketContent.h"

@interface JegarnTextChatPacket : JegarnChatPacket
@property (nonatomic, readwrite, strong) JegarnTextChatPacketContent *content;

+ (instancetype)initWithFrom:(NSString *)from to:(NSString *)to text:(NSString *)text;

@end