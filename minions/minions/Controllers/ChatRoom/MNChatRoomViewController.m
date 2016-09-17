//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNChatRoomViewController.h"


@implementation MNChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.title = @"ChatRoom";
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    _groupInfoArr = @[
            @{
                    @"name" : @"房间一",
                    @"icon" : @"avatar_g6.jpg"
            },
            @{
                    @"name" : @"房间二",
                    @"icon" : @"avatar_g7.jpg"
            },
            @{
                    @"name" : @"房间三",
                    @"icon" : @"avatar_g8.jpg"
            },
            @{
                    @"name" : @"房间四",
                    @"icon" : @"avatar_g9.jpg"
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