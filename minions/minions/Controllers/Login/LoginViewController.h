//
// Created by 刘勇 on 16/7/20.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController

@property (strong, nonatomic) UILabel * usernameLabel;
@property (strong, nonatomic) UITextField * usernameTextField;
@property (strong, nonatomic) UILabel * passwordLabel;
@property (strong, nonatomic) UITextField * passwordTextField;
@property (strong, nonatomic) UIButton * loginButton;

@end