//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnTransport.h"
#import "JegarnCFSocketDecoder.h"
#import "JegarnCFSocketEncoder.h"

@interface JegarnCFSocketTransport : JegarnTransport <JegarnTransport, JegarnCFSocketDecoderDelegate, JegarnCFSocketEncoderDelegate>
@property (strong, nonatomic) NSString *host;
@property (nonatomic) UInt16 port;
@property (nonatomic) BOOL tls;
@property (strong, nonatomic) NSArray *certificates;

@end
