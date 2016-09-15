//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGHttpFile.h"


@implementation YGHttpFile

- (YGHttpFile *)initWithFilePath:(NSString *)filePath andMimeType:(NSString *)mimeType; {
    if (self = [super init]) {
        _filePath = filePath;
        _mimeType = mimeType;
    }

    return self;
}

- (YGHttpFile *)initImageFilePath:(NSString *)filePath {
    return [self initWithFilePath:filePath andMimeType:@"image/jpeg"];
}

@end