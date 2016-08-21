//
//  FirstViewController.m
//  navigation
//
//  Created by 刘勇 on 16/7/28.
//  Copyright (c) 2016 刘勇. All rights reserved.
//


#import "FirstViewController.h"
#import "SecondViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"FirstViewController load");

    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"你好第一页";

    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100,100,100,40)];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonClick {
    NSLog(@"FirstViewController is clicked");
    UIViewController * viewController = [[SecondViewController alloc] init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end