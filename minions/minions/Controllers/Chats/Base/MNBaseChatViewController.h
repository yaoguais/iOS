//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNBaseChatViewModel;
@class MNLoginUserModel;
@class MNUserModel;

@interface MNBaseChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
@protected
    MNBaseChatViewModel * _viewModel;
    MNLoginUserModel * _loginUser;
    UITableView * _contentTableView;
    UITextField * _inputTextField;
    UIButton * _sendButton;
}

@property (nonatomic, strong) MNBaseChatViewModel *viewModel;

@property (nonatomic, strong) MNLoginUserModel *loginUser;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *sendButton;

- (void)appendUser:(MNUserModel *)user textMessage:(NSString *)text;

@end