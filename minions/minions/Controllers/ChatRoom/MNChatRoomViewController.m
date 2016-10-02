//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <YYWebImage/UIImageView+YYWebImage.h>
#import "MNChatRoomViewController.h"
#import "MNChatRoomViewModel.h"
#import "MNGroupModel.h"
#import "MNResourceUtil.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNErrorCode.h"
#import "MNWidgetUtil.h"
#import "MNChatsChatRoomViewController.h"


@implementation MNChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[MNChatRoomViewModel alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.title = @"ChatRoom";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self requestForGroups];
}

- (void)requestForGroups {
    @weakify(self);
    [_viewModel requestGroupsWithCallback:^(MNChatRoomViewModel *viewModel) {
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
    MNGroupModel *groupModel = [_viewModel groupForRowAtIndexPath:indexPath];
    MNChatsChatRoomViewController *chatRoomViewController = [[MNChatsChatRoomViewController alloc] init];
    chatRoomViewController.groupModel = groupModel;
    chatRoomViewController.title = groupModel.name;
    [self.navigationController pushViewController:chatRoomViewController animated:NO];
}

@end