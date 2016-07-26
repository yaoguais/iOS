//
// Created by 刘勇 on 16/7/20.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "LoginViewController.h"
#import "View+MASAdditions.h"
#import "WidgetUtil.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 用户名标签
    UILabel *usernameLabel = [[UILabel alloc] init];
    [self.view addSubview:usernameLabel];
    [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.centerY.equalTo(self.view).with.offset(-100);
        make.width.mas_equalTo(@100);
    }];
    usernameLabel.text = @"username: ";
    usernameLabel.textColor = [UIColor blackColor];
    _usernameLabel = usernameLabel;

    // 用户名输入框
    UITextField *usernameTextField = [[UITextField alloc] init];
    [self.view addSubview:usernameTextField];
    [usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(usernameLabel).with.offset(-3);
        make.left.equalTo(usernameLabel.mas_right);
        make.width.equalTo(self.view).with.offset(-120);
    }];
    usernameTextField.borderStyle = UITextBorderStyleRoundedRect | UITextBorderStyleLine;
    [usernameTextField becomeFirstResponder];
    _usernameTextField = usernameTextField;

    // 密码标签
    UILabel *passwordLabel = [[UILabel alloc] init];
    [self.view addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(usernameLabel).with.offset(50);
        make.width.mas_equalTo(@100);
    }];
    passwordLabel.text = @"password: ";
    passwordLabel.textColor = [UIColor blackColor];
    _passwordLabel = passwordLabel;

    // 密码输入框
    UITextField *passwordTextField = [[UITextField alloc] init];
    [self.view addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel).with.offset(-3);
        make.left.equalTo(passwordLabel.mas_right);
        make.width.equalTo(self.view).with.offset(-120);
    }];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect | UITextBorderStyleLine;
    passwordTextField.secureTextEntry = YES;
    _passwordTextField = passwordTextField;

    // 登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel).with.offset(50);
        make.centerX.equalTo(self.view).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [loginButton setTitle:@"login" forState:UIControlStateNormal];
    CALayer *loginButtonLayer = [loginButton layer];
    [loginButtonLayer setMasksToBounds:YES];
    [loginButtonLayer setCornerRadius:10.0];
    [loginButtonLayer setBorderWidth:1.0];
    [loginButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];

    // 点击登录
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButtonClick:(id)sender {

    NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!username || username.length == 0) {
        [WidgetUtil AlertWithControll:self title:@"alert" mssage:@"username required"];
        return;
    }

    NSString * password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!password || password.length == 0) {
        [WidgetUtil AlertWithControll:self title:@"alert" mssage:@"password required"];
        return;
    }

    //[WidgetUtil AlertWithControll:self title:@"alert" mssage:@"login button click"];
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = delegate.tabBarController;
}



@end