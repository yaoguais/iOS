//
// Created by Yao Guai on 16/9/29.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YGNSStreamTest : NSObject <NSStreamDelegate>

@property (nonatomic,retain)NSInputStream * inputStream;
@property (nonatomic,retain)NSOutputStream * outputStream;

- (void)initNetworkCommunication;

@end