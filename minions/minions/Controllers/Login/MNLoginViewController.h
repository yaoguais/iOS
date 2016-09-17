//
// Created by Yao Guai on 16/9/15.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNLoginViewModel;

@interface MNLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UILabel * signLabel;
@property (strong, nonatomic) UILabel * accountLabel;
@property (strong, nonatomic) UITextField * accountTextField;
@property (strong, nonatomic) UIView * accountLineView;
@property (strong, nonatomic) UILabel * passwordLabel;
@property (strong, nonatomic) UITextField * passwordTextField;
@property (strong, nonatomic) UIView * passwordLineView;
@property (strong, nonatomic) UIButton * loginButton;

@property (strong, nonatomic) MNLoginViewModel * viewModel;

@end