//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNGroupModel.h"


@implementation MNGroupModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"groupId" : @"group_id",
            @"name" : @"name",
            @"icon" : @"icon",
            @"desc" : @"description",
    };
}

@end