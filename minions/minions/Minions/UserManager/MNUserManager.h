//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGSingletonMicro.h"
#import "MNLoginViewModel.h"
#import "MNUserModel.h"
#import "MNLoginViewModel.h"

@interface MNUserInfoViewModel : MNLoginViewModel
@property (nonatomic) NSInteger code;
@property (nonatomic, strong) MNUserModel *user;
@end

@interface MNUserManager : NSObject

@property (nonatomic, strong) MNLoginUserModel * loginUser;
@property (nonatomic, strong) MNLoginUserModel * fakeUser;
@property (nonatomic, strong) NSMutableDictionary * users;

YGSingletonH(MNLoginUserManager);

- (void)fetchUser:(NSString *)uid callback:(void (^)(MNUserInfoViewModel *))callback;
- (void)addUser:(MNUserModel *)user;

@end