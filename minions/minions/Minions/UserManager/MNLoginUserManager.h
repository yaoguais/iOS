//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGSingletonMicro.h"
@class MNLoginUserModel;



@interface MNLoginUserManager : NSObject

@property (nonatomic, strong) MNLoginUserModel * loginUser;

YGSingletonH(MNLoginUserManager);

@end