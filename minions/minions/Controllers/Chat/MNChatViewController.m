//
// Created by 刘勇 on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNChatViewController.h"


@implementation MNChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // 标题栏
    self.navigationItem.title = @"title";
    self.title = @"controller";
    self.navigationController.title = @"nav";

    // 内容
    self.contentTableView = [[UITableView alloc] init];
    [self.view addSubview:self.contentTableView];

    // 输入框
    self.inputTextField = [[UITextField alloc] init];
    [self.view addSubview:self.inputTextField];

    // 发送按钮
    self.sendButton = [[UIButton alloc] init];
    [self.view addSubview:self.sendButton];
}


@end