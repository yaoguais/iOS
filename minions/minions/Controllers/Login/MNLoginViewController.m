//
// Created by Yao Guai on 16/9/15.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGWeakifyStrongifyMicro.h"
#import "MNLoginViewController.h"
#import "YGCommonMicro.h"
#import "MNWidgetUtil.h"
#import "MNLoginViewModel.h"
#import "MNErrorCode.h"
#import "MNUserManager.h"
#import "AppDelegate.h"
#import "MNLoginUserModel.h"


@implementation MNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _viewModel = [[MNLoginViewModel alloc] init];
    const CGFloat commonMarginLeft = 60;
    const CGFloat commonWidth = YGViewWidth(self.view) - 2 * commonMarginLeft;
    UIColor * commonColor = [UIColor colorWithRed:155 / 255.0 green:155 / 255.0 blue:155 / 255.0 alpha:1];
    UIColor * commonHighlightColor = [UIColor colorWithRed:155 / 255.0 green:155 / 255.0 blue:155 / 255.0 alpha:0.44];

    _signLabel = [[UILabel alloc] initWithFrame:CGRectMake(commonMarginLeft, 70, commonWidth, 100)];
    _signLabel.text = @"SIGN\nIN";
    _signLabel.numberOfLines = 0;
    _signLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _signLabel.textColor = commonColor;
    [_signLabel setFont:[UIFont systemFontOfSize:40]];
    [_signLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_signLabel];

    const CGFloat usernameMarginTop = 200;
    _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(commonMarginLeft, usernameMarginTop, commonWidth, 20)];
    _accountLabel.text = @"USERNAME";
    _accountLabel.textColor = [UIColor colorWithRed:161 / 255.0 green:161 / 255.0 blue:164 / 255.0 alpha:1];
    _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:_accountLabel];

    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(commonMarginLeft, usernameMarginTop + 32, commonWidth, 32)];
    _accountTextField.keyboardType = UIKeyboardTypeAlphabet;
    _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    _accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [_accountTextField becomeFirstResponder];
    [_accountTextField setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:_accountTextField];

    _accountLineView = [[UIView alloc] initWithFrame:CGRectMake(commonMarginLeft, usernameMarginTop + 70, commonWidth, 1)];
    _accountLineView.backgroundColor = [UIColor colorWithRed:36 / 255.0 green:37 / 255.0 blue:42 / 255.0 alpha:1];
    [self.view addSubview:_accountLineView];

    const CGFloat passwordMarginTop = usernameMarginTop + 110;
    _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(commonMarginLeft, passwordMarginTop, commonWidth, 20)];
    _passwordLabel.text = @"PASSWORD";
    _passwordLabel.textColor = [UIColor colorWithRed:161 / 255.0 green:161 / 255.0 blue:164 / 255.0 alpha:1];
    [self.view addSubview:_passwordLabel];

    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(commonMarginLeft, passwordMarginTop + 32, commonWidth, 32)];
    _passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
    [_passwordTextField setFont:[UIFont systemFontOfSize:18]];
    [_passwordTextField setSecureTextEntry:YES];
    _passwordTextField.delegate = self;
    [self.view addSubview:_passwordTextField];

    _passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(commonMarginLeft, passwordMarginTop + 70, commonWidth, 1)];
    _passwordLineView.backgroundColor = [UIColor colorWithRed:36 / 255.0 green:37 / 255.0 blue:42 / 255.0 alpha:1];
    [self.view addSubview:_passwordLineView];

    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake((YGViewWidth(self.view) - 140)/2, passwordMarginTop + 140, 140, 40)];
    [_loginButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [_loginButton setTitleColor:commonColor forState:UIControlStateNormal];
    [_loginButton setTitleColor:commonHighlightColor forState:UIControlStateHighlighted];
    [_loginButton setTitleColor:commonHighlightColor forState:UIControlStateSelected];
    _loginButton.layer.borderColor = commonColor.CGColor;
    _loginButton.layer.borderWidth = 2.0;
    _loginButton.layer.cornerRadius = 10.0;
    [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_loginButton];
}


- (void) loginButtonClick{
    NSString *account = _accountTextField.text;
    if (YGIsEmptyString(account)) {
        [MNWidgetUtil alertWithController:self title:@"Alter" mssage:@"username can not be empty"];
        return;
    }

    MNLoginUserModel *fakeUser = [MNUserManager sharedInstance].fakeUser;
    if ([account isEqualToString:fakeUser.account]) {
        [MNUserManager sharedInstance].loginUser = fakeUser;
        AppDelegate * delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [delegate startChatClientAccount:fakeUser.account password:fakeUser.token];
        [delegate presentMainTabBarViewController];
        return;
    }

    NSString *password = _passwordTextField.text;
    if (YGIsEmptyString(password)) {
        [MNWidgetUtil alertWithController:self title:@"Alter" mssage:@"password can not be empty"];
        return;
    }

    @weakify(self);
    [_viewModel loginWithAccount:account password:password callback:^(MNLoginViewModel *viewModel) {
        @strongify(self);
        if (![MNErrorCode isSuccess:viewModel.code]) {
            [MNWidgetUtil alertWithController:self title:@"Alert" mssage:[MNErrorCode getMessage:viewModel.code]];
        } else {
            [MNUserManager sharedInstance].loginUser = viewModel.user;
            AppDelegate * delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [delegate startChatClientAccount:viewModel.user.account password:viewModel.user.token];
            [delegate presentMainTabBarViewController];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loginButtonClick];
    return NO;
}

@end