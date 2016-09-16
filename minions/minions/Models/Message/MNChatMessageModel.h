//
// Created by Yao Guai on 16/9/16.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNUserModel;


@interface MNChatMessageModel : NSObject

@property (strong, nonatomic) MNUserModel *user;
@property (strong, nonatomic) NSString *content;

@end