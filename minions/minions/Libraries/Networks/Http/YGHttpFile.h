//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YGHttpFile : NSObject

@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString * mimeType;

- (YGHttpFile *)initWithFilePath:(NSString *)filePath andMimeType:(NSString *)mimeType;
- (YGHttpFile *)initImageFilePath:(NSString *)filePath;

@end