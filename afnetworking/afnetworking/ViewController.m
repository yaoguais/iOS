//
//  ViewController.m
//  afnetworking
//
//  Created by 刘勇 on 16/7/10.
//  Copyright (c) 2016 刘勇. All rights reserved.
//


#import "ViewController.h"
#import "AFHTTPSessionManager.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor redColor] CGColor];
    button.frame = CGRectMake(40, 40, 100, 40);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview: button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)TouchDown {
    NSLog(@"被点击了");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"按钮被点击了" message:@"警告哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    //[self HttpGet];
    //[self HttpPost];
    [self UploadFile];
}

- (void) HttpGet {
    NSDictionary *dictionary = @{@"name" : @"testname",
            @"APPversion" : @"3.2.3",
            @"serverIp" : @"127.0.0.1",
            @"clientType" : @"2"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://127.0.0.1:9068/?a=b" parameters:dictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Data: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) HttpPost {
    NSDictionary *dictionary = @{@"name" : @"testname",
            @"APPversion" : @"3.2.3",
            @"serverIp" : @"127.0.0.1",
            @"clientType" : @"2"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://127.0.0.1:9068/?a=b" parameters:dictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"Data: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) UploadFile {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:@"http://127.0.0.1:9068/?a=b"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";

    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
    NSURL *filePath = [NSURL fileURLWithPath:imagePath];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

@end