//
// Created by Yao Guai on 16/7/23.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <YYWebImage/UIImageView+YYWebImage.h>
#import "MNContactViewController.h"
#import "MNContactViewModel.h"
#import "MNUserModel.h"
#import "MNResourceUtil.h"
#import "MNErrorCode.h"
#import "MNWidgetUtil.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNBaseChatViewController.h"
#import "MNChatsChatViewController.h"


@implementation MNContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[MNContactViewModel alloc] init];
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.title = @"Contact";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestForUsers];
}

- (void) requestForUsers
{
    @weakify(self);
    [_viewModel requestForUsersForCallback:^(MNContactViewModel *viewModel) {
        @strongify(self);
        if (![MNErrorCode isSuccess:viewModel.code]) {
            [MNWidgetUtil alertWithController:self title:@"Alert" mssage:[MNErrorCode getMessage:viewModel.code]];
        }else{
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MNUserModel * userModel = [_viewModel userForRowAtIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setText:userModel.account];
    [cell.imageView yy_setImageWithURL:[NSURL URLWithString:[MNResourceUtil getUrl:userModel.avatar]] placeholder:[MNResourceUtil getAvatarPlaceholder]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MNUserModel *userModel = [_viewModel userForRowAtIndexPath:indexPath];
    MNChatsChatViewController *chatViewController = [[MNChatsChatViewController alloc] init];
    chatViewController.title = userModel.account;
    chatViewController.chatWithUser = userModel;
    [self.navigationController pushViewController:chatViewController animated:NO];
}

@end