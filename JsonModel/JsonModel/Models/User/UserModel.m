//
// Created by 刘勇 on 16/7/12.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "UserModel.h"


@implementation UserModel {

}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"uid",
            @"username" : @"username",
            @"nickname" : @"nickname",
            @"createdAt" : @"created_at"};
}

@end