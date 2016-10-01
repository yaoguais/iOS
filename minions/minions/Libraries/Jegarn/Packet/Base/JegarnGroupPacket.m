//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnGroupPacket.h"


@implementation JegarnGroupPacket

- (BOOL) isSendToAll
{
    return [@"all" isEqualToString:self.to];
}

- (void) setSendToAll
{
    self.to = @"all";
}

@end