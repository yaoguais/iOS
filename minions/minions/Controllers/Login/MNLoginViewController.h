//
// Created by Yao Guai on 16/9/15.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MNLoginViewController : UIViewController

@property (strong, nonatomic) UILabel * signLabel;
@property (strong, nonatomic) UILabel * usernameLabel;
@property (strong, nonatomic) UITextField * usernameTextField;
@property (strong, nonatomic) UIView * usernameLineView;
@property (strong, nonatomic) UILabel * passwordLabel;
@property (strong, nonatomic) UITextField * passwordTextField;
@property (strong, nonatomic) UIView * passwordLineView;
@property (strong, nonatomic) UIButton * loginButton;


@end