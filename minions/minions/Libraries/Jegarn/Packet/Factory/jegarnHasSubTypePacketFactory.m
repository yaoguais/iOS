//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "jegarnHasSubTypePacketFactory.h"
#import "JegarnPacket.h"


@implementation jegarnHasSubTypePacketFactory

static id _instance;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (JegarnPacket *)getPacket:(NSString *)from to:(NSStream *)to type:(NSString *)type content:(id)content
{
    return nil;
}

@end