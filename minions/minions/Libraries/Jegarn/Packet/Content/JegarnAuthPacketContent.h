//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnAuthPacket.h"


@interface JegarnAuthPacketContent : NSObject

@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * account;
@property (nonatomic, copy) NSString * password;
@property (nonatomic) NSInteger status;

@end