//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JegarnPacket : NSObject
{
@protected
    NSString * _from;
    NSString * _to;
    NSString * _type;
    id _content;
}

@property (nonatomic, copy) NSString * from;
@property (nonatomic, copy) NSString * to;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, readonly) id content;

- (BOOL) isFromSystemUser;
- (void) setToSystemUser;
- (NSMutableDictionary *) convertToDictionary;
+ (NSString *) packetType;

@end