//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnCFSocketTransport.h"

@class JegarnSecurityPolicy;

@interface JegarnCFSslSocketTransport : JegarnCFSocketTransport

@property (strong, nonatomic) JegarnSecurityPolicy *securityPolicy;
@property (nonatomic) BOOL tls;
@property (strong, nonatomic) NSArray *certificates;

@end