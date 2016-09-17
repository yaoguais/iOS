//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNConversationViewController.h"
#import "MNBaseChatViewController.h"
#import "UIImageView+YYWebImage.h"
#import "MNResourceUtil.h"


@implementation MNConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.title = @"Conversation";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _messageInfoArr = @[
            /*@{
                    @"name" : @"会话一",
                    @"icon" : @"/upload/avatar/default/b2.jpg"
            },
            @{
                    @"name" : @"会话二",
                    @"icon" : @"/upload/avatar/default/b6.jpg"
            },
            @{
                    @"name" : @"会话三",
                    @"icon" : @"/upload/avatar/default/b7.jpg"
            },
            @{
                    @"name" : @"会话四",
                    @"icon" : @"/upload/avatar/default/b8.jpg"
            }*/
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
    [cell.imageView yy_setImageWithURL:[NSURL URLWithString:[MNResourceUtil getUrl:item[@"icon"]]] placeholder:[MNResourceUtil getAvatarPlaceholder]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MNBaseChatViewController * chatViewController = [[MNBaseChatViewController alloc] init];
    chatViewController.title = _messageInfoArr[(NSUInteger) indexPath.row][@"name"];
    [self.navigationController pushViewController:chatViewController animated:NO];
}


@end