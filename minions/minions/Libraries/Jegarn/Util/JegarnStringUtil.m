//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnStringUtil.h"


@implementation JegarnStringUtil

+ (BOOL) isEmptyString: (id) str
{
    return !str || ![str isKindOfClass:[NSString class]] || [str length] == 0;
}

@end