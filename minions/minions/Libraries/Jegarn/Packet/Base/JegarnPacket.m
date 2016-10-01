//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacket.h"


@implementation JegarnPacket

- (instancetype)init {
    self = [super init];
    if (self) {
        _from = @"";
        _to = @"";
        _type = @"";
    }

    return self;
}

- (BOOL) isFromSystemUser
{
    return [@"system" isEqualToString:_from];
}

- (void) setToSystemUser
{
    _to = @"system";
}

- (NSMutableDictionary *)convertToDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"from"] = self.from;
    dict[@"to"] = self.to;
    dict[@"type"] = self.type;

    return dict;
}

+ (NSString *) packetType
{
    return @"";
}

@end