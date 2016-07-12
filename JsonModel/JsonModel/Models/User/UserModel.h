//
// Created by 刘勇 on 16/7/12.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface UserModel : BaseModel
    @property (nonatomic) NSInteger uid;
    @property (nonatomic, copy) NSString * username;
    @property (nonatomic, copy) NSString * nickname;
    @property (nonatomic, copy) NSDate * createdAt;
@end