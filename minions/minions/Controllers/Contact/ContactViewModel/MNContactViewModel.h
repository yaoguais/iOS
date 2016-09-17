//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MNUserModel;


@interface MNContactViewModel : NSObject

@property (nonatomic) NSInteger code;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *users;

- (NSUInteger)count;
- (MNUserModel *)userForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)requestForUsersForCallback:(void (^)(MNContactViewModel *))callback;

@end