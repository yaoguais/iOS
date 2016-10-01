//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnAuthPacketContent.h"

@implementation JegarnAuthPacketContent

- (instancetype)init {
    self = [super init];
    if (self) {
        _uid = @"";
        _account = @"";
        _password = @"";
    }

    return self;
}


@end