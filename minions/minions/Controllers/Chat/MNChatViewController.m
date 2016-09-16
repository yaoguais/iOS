//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNChatViewController.h"


@implementation MNChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain
                                                                            target:self action:@selector(backBtnClick)];

}

- (void) backBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end