//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnHasSubTypePacketContent.h"

@interface JegarnTextChatPacketContent : JegarnHasSubTypePacketContent
@property (nonatomic, copy) NSString *text;
@end