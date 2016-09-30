//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnCFSocketTransport.h"

@class JegarnCFSslSecurityPolicy;

@interface JegarnCFSslSocketTransport : JegarnCFSocketTransport

@property (strong, nonatomic) JegarnCFSslSecurityPolicy *securityPolicy;
@property (nonatomic) BOOL tls;
@property (strong, nonatomic) NSArray *certificates;

@end