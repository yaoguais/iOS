//
// Created by Yao Guai on 16/7/23.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNContactViewController.h"


@implementation MNContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.title = @"Contact";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _userInfoArr = @[
            @{
                    @"name" : @"张三",
                    @"avatar" : @"avatar.jpg"
            },
            @{
                    @"name" : @"李四",
                    @"avatar" : @"avatar_b0.jpg"
            },
            @{
                    @"name" : @"王二",
                    @"avatar" : @"avatar_b1.jpg"
            },
            @{
                    @"name" : @"赵五",
                    @"avatar" : @"avatar_b2.jpg"
            }
    ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_userInfoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *item = _userInfoArr[(NSUInteger) indexPath.row];
    [cell.textLabel setText:item[@"name"]];
    [cell.imageView setImage:[UIImage imageNamed:item[@"avatar"]]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end