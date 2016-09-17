//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNLoginUserManager.h"
#import "MNLoginUserModel.h"


@implementation MNLoginUserManager

YGSingletonM(MNLoginUserManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        _fakeUser = [[MNLoginUserModel alloc] init];
        _fakeUser.uid = @"12";
        _fakeUser.account = @"yaoguai";
        _fakeUser.avatar = @"/upload/avatar/default/b7.jpg";
        _fakeUser.token = @"a03231805fb703d159dbc71633c72b86";
    }

    return self;
}


@end