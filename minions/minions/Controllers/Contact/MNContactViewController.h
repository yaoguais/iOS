//
// Created by Yao Guai on 16/7/23.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNContactViewModel;

@interface MNContactViewController : UITableViewController

@property (nonatomic, strong) NSArray * userInfoArr;
@property (nonatomic, strong) MNContactViewModel *viewModel;

@end