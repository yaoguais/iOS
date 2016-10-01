//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacket.h"


@implementation JegarnPacket

- (BOOL) isFromSystemUser
{
    return [@"system" isEqualToString:self.from];
}

- (void) setToSystemUser
{
    self.to = @"system";
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