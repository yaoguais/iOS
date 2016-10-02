//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnConvertUtil.h"


@implementation JegarnConvertUtil

+ (NSData *)intToBinaryString:(NSInteger)value {
    Byte bytes[] = {
            (Byte) value >> 24,
            (Byte) value >> 16,
            (Byte) value >> 8,
            (Byte) value,
    };

    return [[NSData alloc] initWithBytes:bytes length:4];
}

+ (NSInteger)binaryStringToInt:(NSData *)data {
    NSInteger value = -1;
    if ([data length] == 4) {
        Byte *bytes = (Byte *) [data bytes];
        value = (bytes[0] << 24) | ((bytes[1] & 0xff) << 16) | ((bytes[2] & 0xff) << 8) | (bytes[3] & 0xff);
    }
    return value;
}

+ (NSString *)idToString:(id)input {
    if ([input isKindOfClass:[NSNumber class]]) {
        return [NSNumberFormatter localizedStringFromNumber:input numberStyle:NSNumberFormatterNoStyle];
    } else {
        return (NSString *) input;
    }
}

@end