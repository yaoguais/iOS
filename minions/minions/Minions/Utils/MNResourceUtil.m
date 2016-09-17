//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNResourceUtil.h"
#import "MNHttpRequestUrl.h"


@implementation MNResourceUtil

+ (NSString *) getUrl:(NSString *) key
{
    return [NSString stringWithFormat:@"%@%@", MNHttpResourceDomain, key];
}

+ (UIImage *) getAvatarPlaceholder
{
    return [UIImage imageNamed:@"avatar.jpg"];
}

@end