//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JegarnConvertUtil : NSObject

+ (NSData *)intToBinaryString:(NSInteger)value;
+ (NSInteger) binaryStringToInt:(NSData *)data;
+ (NSString *) idToString:(id)input;

@end