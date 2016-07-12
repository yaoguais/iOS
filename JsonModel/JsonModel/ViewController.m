//
//  ViewController.m
//  JsonModel
//
//  Created by 刘勇 on 16/7/12.
//  Copyright (c) 2016 刘勇. All rights reserved.
//


#import "ViewController.h"
#import "UserModel.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString  * json = @"{\"uid\":100,\"username\":\"jack\",\"nickname\":\"jacky\",\"created_at\":\"2016-07-12T09:34:42+08:00\"}";
    UserModel * user = [UserModel yy_modelWithJSON:json];
    NSLog(@"%@", user);
    NSLog(@"%@", [user yy_modelToJSONObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end