//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNChatViewModel;
@class MNUserModel;

@interface MNChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) MNChatViewModel *viewModel;

@property (nonatomic, strong) MNUserModel *loginUser;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *sendButton;

@end