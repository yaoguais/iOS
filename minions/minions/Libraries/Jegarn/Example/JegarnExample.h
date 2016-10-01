//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JegarnClient;


@interface JegarnExample : NSObject{
@protected
    JegarnClient * _client;
}
@property (nonatomic, strong) JegarnClient * client;

- (void) connectToServer;
- (void) disconnectToServer;

@end