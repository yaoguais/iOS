//
// Created by Yao Guai on 16/9/18.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNChatsGroupChatViewController.h"
#import "MNGroupModel.h"
#import "JegarnPacketManager.h"
#import "JegarnTextGroupChatPacket.h"
#import "YGCommonMicro.h"
#import "MNWidgetUtil.h"
#import "MNLoginUserModel.h"
#import "AppDelegate.h"
#import "JegarnClient.h"
#import "MNUserManager.h"
#import "MNErrorCode.h"
#import "YGWeakifyStrongifyMicro.h"


@implementation MNChatsGroupChatViewController

- (void)viewDidAppear:(BOOL)animated {
    [[JegarnGroupChatPacketManager sharedInstance] addDelegate:self];
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[JegarnGroupChatPacketManager sharedInstance] removeDelegate:self];
    [super viewDidDisappear:animated];
}

- (BOOL)processPacket:(JegarnGroupChatPacket *)packet {
    if ([packet isKindOfClass:[JegarnTextGroupChatPacket class]]) {
        NSString *fromUid = packet.from;
        NSString *toUid = packet.to;
        NSInteger groupId = ((JegarnTextGroupChatPacket *) packet).content.groupId;
        if (groupId == [_groupModel.groupId intValue] && ([toUid isEqualToString:_loginUser.uid] || [packet isSendToAll])) {
            NSString *content = ((JegarnTextGroupChatPacket *) packet).content.text;
            @weakify(self);
            [[MNUserManager sharedInstance] fetchUser:fromUid callback:^(MNUserInfoViewModel *viewModel) {
                @strongify(self);
                if (![MNErrorCode isSuccess:viewModel.code]) {
                    [MNWidgetUtil alertWithController:self title:@"Alert" mssage:[MNErrorCode getMessage:viewModel.code]];
                } else {
                    [self appendUser:viewModel.user textMessage:content];
                }
            }];
        }
    }
    return YES;
}


- (void)sendButtonClick {
    NSString *content = _inputTextField.text;
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (YGIsEmptyString(content)) {
        [MNWidgetUtil alertWithController:self title:@"Alter" mssage:@"content can not be empty"];
        return;
    }
    // send to server
    JegarnTextGroupChatPacket *packet = [JegarnTextGroupChatPacket
            initWithFrom:_loginUser.uid to:@"all" groupId:[_groupModel.groupId intValue] text:content];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if (![delegate.chatClient sendPacket:packet]) {
        [MNWidgetUtil alertWithController:self title:@"Alter" mssage:@"send message failed"];
        return;
    }

    [self appendUser:_loginUser textMessage:content];
}

@end