//
// Created by 刘勇 on 16/7/28.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "ThirdViewController.h"


@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"ThirdViewController loaded");

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"你好第三页";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end