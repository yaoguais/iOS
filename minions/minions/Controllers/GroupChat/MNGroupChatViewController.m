//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <YYWebImage/UIImageView+YYWebImage.h>
#import "MNGroupChatViewController.h"
#import "MNGroupChatViewModel.h"
#import "MNResourceUtil.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNErrorCode.h"
#import "MNWidgetUtil.h"
#import "MNGroupModel.h"
#import "MNChatsGroupChatViewController.h"

@implementation MNGroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[MNGroupChatViewModel alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.title = @"GroupChat";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self requestForGroups];
}

- (void)requestForGroups {
    @weakify(self);
    [_viewModel requestGroupsWithCallback:^(MNGroupChatViewModel *viewModel) {
        @strongify(self);
        if (![MNErrorCode isSuccess:viewModel.code]) {
            [MNWidgetUtil alertWithController:self title:@"Alert" mssage:[MNErrorCode getMessage:viewModel.code]];
        } else {
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
    MNGroupModel *groupModel = [_viewModel groupForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setText:groupModel.name];
    [cell.imageView yy_setImageWithURL:[NSURL URLWithString:[MNResourceUtil getUrl:groupModel.icon]] placeholder:[MNResourceUtil getAvatarPlaceholder]];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MNGroupModel * groupModel = [_viewModel groupForRowAtIndexPath:indexPath];
    MNChatsGroupChatViewController * groupChatViewController = [[MNChatsGroupChatViewController alloc] init];
    groupChatViewController.groupModel = groupModel;
    groupChatViewController.title = groupModel.name;
    [self.navigationController pushViewController:groupChatViewController animated:NO];
}

@end