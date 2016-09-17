//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNGroupChatViewController.h"


@implementation MNGroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.title = @"GroupChat";
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    _groupInfoArr = @[
            @{
                    @"name" : @"群组一",
                    @"icon" : @"avatar_g0.jpg"
            },
            @{
                    @"name" : @"群组二",
                    @"icon" : @"avatar_g1.jpg"
            },
            @{
                    @"name" : @"群组三",
                    @"icon" : @"avatar_g2.jpg"
            },
            @{
                    @"name" : @"群组四",
                    @"icon" : @"avatar_g3.jpg"
            }
    ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_groupInfoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *item = _groupInfoArr[(NSUInteger) indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setText:item[@"name"]];
    [cell.imageView setImage:[UIImage imageNamed:item[@"icon"]]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end