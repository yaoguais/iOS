//
// Created by 刘勇 on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNMessageViewController.h"
#import "AppDelegate.h"
#import "MNChatViewController.h"


@implementation MNMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _messageInfoArr = @[
            @{
                    @"name" : @"会话一",
                    @"icon" : @"avatar_b5.jpg"
            },
            @{
                    @"name" : @"会话二",
                    @"icon" : @"avatar_b6.jpg"
            },
            @{
                    @"name" : @"会话三",
                    @"icon" : @"avatar_b7.jpg"
            },
            @{
                    @"name" : @"会话四",
                    @"icon" : @"avatar_b8.jpg"
            }
    ];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messageInfoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *item = _messageInfoArr[(NSUInteger) indexPath.row];
    [cell.textLabel setText:item[@"name"]];
    [cell.imageView setImage:[UIImage imageNamed:item[@"icon"]]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = [[MNChatViewController alloc] init];
}


@end