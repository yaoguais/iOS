//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JegarnSslConvert : NSObject

+ (NSArray *)clientCertsFromP12:(NSString *)path passphrase:(NSString *)passphrase;

@end