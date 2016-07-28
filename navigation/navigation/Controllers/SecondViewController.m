//
// Created by 刘勇 on 16/7/28.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"


@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"SecondViewController loaded");

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"你好第二页";

    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100,100,100,40)];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonClick {
    NSLog(@"SecondViewController is clicked");
    UIViewController * viewController = [[ThirdViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    viewController.title = @"第三页";
    [self.navigationController pushViewController:viewController animated:YES];
}

@end