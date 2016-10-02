//
// Created by Yao Guai on 16/9/18.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNChatsChatRoomViewController.h"
#import "MNGroupModel.h"
#import "JegarnPacketManager.h"
#import "JegarnTextChatRoomPacket.h"
#import "MNLoginUserModel.h"
#import "YGWeakifyStrongifyMicro.h"
#import "MNUserManager.h"
#import "MNErrorCode.h"
#import "MNWidgetUtil.h"
#import "YGCommonMicro.h"
#import "AppDelegate.h"
#import "JegarnClient.h"


@implementation MNChatsChatRoomViewController

- (void)viewDidAppear:(BOOL)animated {
    [[JegarnChatRoomPacketManager sharedInstance] addDelegate:self];
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[JegarnGroupChatPacketManager sharedInstance] removeDelegate:self];
    [super viewDidDisappear:animated];
}

- (BOOL)processPacket:(JegarnChatRoomPacket *)packet {
    if ([packet isKindOfClass:[JegarnTextChatRoomPacket class]]) {
        NSString *fromUid = packet.from;
        NSString *toUid = packet.to;
        NSInteger groupId = ((JegarnTextChatRoomPacket *) packet).content.groupId;
        if (groupId == [_groupModel.groupId intValue] && ([toUid isEqualToString:_loginUser.uid] || [packet isSendToAll])) {
            NSString *content = ((JegarnTextChatRoomPacket *) packet).content.text;
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
    JegarnTextChatRoomPacket *packet = [JegarnTextChatRoomPacket
            initWithFrom:_loginUser.uid to:@"all" groupId:[_groupModel.groupId intValue] text:content];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if (![delegate.chatClient sendPacket:packet]) {
        [MNWidgetUtil alertWithController:self title:@"Alter" mssage:@"send message failed"];
        return;
    }

    [self appendUser:_loginUser textMessage:content];
}

@end