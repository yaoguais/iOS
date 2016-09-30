//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnCFSocketEncoder.h"

@class JegarnCFSslSecurityPolicy;


@interface JegarnCFSslSocketEncoder : JegarnCFSocketEncoder

@property(strong, nonatomic) JegarnCFSslSecurityPolicy *securityPolicy;
@property(strong, nonatomic) NSString *securityDomain;

@end