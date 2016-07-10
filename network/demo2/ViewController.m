//
//  ViewController.m
//  demo2
//
//  Created by 刘勇 on 16/7/10.
//  Copyright (c) 2016 刘勇. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor redColor] CGColor];
    button.frame = CGRectMake(40, 40, 100, 40);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    //UIColor * red = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    //[button setTitleColor: red forState:UIControlStateNormal];
    [button addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)TouchDown {
    NSLog(@"被点击了");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"按钮被点击了" message:@"警告哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [self FetchDataAsync];
    [self UploadFileAsync];
    [self DownloadFileAsync];
}

- (void)FetchDataAsync {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:9068/?a=b"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[@"c=d&e=f" dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"FetchDataSync");
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@", response);
        NSLog(@"%@", error);
    }];
    [task resume];
}

- (void)UploadFileAsync {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:[self UploadTaskRequest] fromData:[self UploadTaskRequestBody] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"UploadFileAsync");
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@", response);
        NSLog(@"%@", error);
    }];
    [task resume];
}

- (NSMutableURLRequest *)UploadTaskRequest {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:9068/?a=b"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", Boundary]
   forHTTPHeaderField:@"Content-Type"];

    return request;
}

- (NSData *)UploadTaskRequestBody {
    NSMutableData *totlData = [NSMutableData new];
    NSDictionary *dictionary = @{@"name" : @"testname",
            @"APPversion" : @"3.2.3",
            @"serverIp" : @"127.0.0.1",
            @"clientType" : @"2"};
    NSArray *allKeys = [dictionary allKeys];
    for (int i = 0; i < allKeys.count; i++) {

        NSString *disposition = [NSString stringWithFormat:@"%@Content-Disposition: form-data; name=\"%@\"%@", StartBoundary, allKeys[i], Wrap2];
        NSString *object = [dictionary objectForKey:allKeys[i]];
        disposition = [disposition stringByAppendingString:object];
        disposition = [disposition stringByAppendingString:Wrap1];
        [totlData appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];

    }
    NSString *body = [NSString stringWithFormat:@"%@Content-Disposition: form-data; name=\"picture\"; filename=\"%@\";%@Content-Type:image/jpg%@", StartBoundary, @"test.jpg", Wrap1, Wrap2];
    [totlData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"test.jpg"]);
    NSData *data = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"]]);
    [totlData appendData:data];
    [totlData appendData:[Wrap1 dataUsingEncoding:NSUTF8StringEncoding]];
    [totlData appendData:[EndBody dataUsingEncoding:NSUTF8StringEncoding]];

    return totlData;
}

- (void) DownloadFileAsync {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:9068/test.jpg"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask * task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * location, NSURLResponse * response, NSError * error){
        NSLog(@"DownloadFileAsync");
        NSLog(@"%@", location);
        NSLog(@"%@", response);
        NSLog(@"%@", error);

        NSString  * fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
                stringByAppendingPathComponent:response.suggestedFilename];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
        NSLog(@"%@", fullPath);
    }];
    [task resume];
}

@end