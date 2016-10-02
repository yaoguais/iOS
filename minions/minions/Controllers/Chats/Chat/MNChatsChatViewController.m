//
// Created by Yao Guai on 16/9/18.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNChatsChatViewController.h"
#import "YGCommonMicro.h"
#import "MNBaseChatViewModel.h"
#import "MNChatMessageModel.h"
#import "MNUserModel.h"
#import "MNWidgetUtil.h"
#import "MNLoginUserModel.h"
#import "JegarnTextChatPacket.h"
#import "AppDelegate.h"
#import "JegarnClient.h"
#import "JegarnPacketManager.h"


@implementation MNChatsChatViewController

- (void)viewDidAppear:(BOOL)animated {
    [[JegarnChatPacketManager sharedInstance] addDelegate:self];
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[JegarnChatPacketManager sharedInstance] removeDelegate:self];
    [super viewDidDisappear:animated];
}

- (BOOL)processPacket:(JegarnChatPacket *)packet {
    if([packet isKindOfClass:[JegarnTextChatPacket class]]){
        NSString *fromUid = packet.from;
        NSString *toUid = packet.to;
        if ([fromUid isEqualToString:_chatWithUser.uid] && [toUid isEqualToString:_loginUser.uid]) {
            NSString *content = ((JegarnTextChatPacket *) packet).content.text;
            [self appendUser:_chatWithUser message:content];
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
    JegarnTextChatPacket * packet = [JegarnTextChatPacket initWithFrom:_loginUser.uid to:_chatWithUser.uid text:content];
    AppDelegate * delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if (![delegate.chatClient sendPacket:packet]) {
        [MNWidgetUtil alertWithController:self title:@"Alter" mssage:@"send message failed"];
        return;
    }

    [self appendUser:_loginUser message:content];
}

- (void) appendUser:(MNUserModel *)user message:(NSString *)content
{
    MNChatMessageModel *chatMessageModel = [[MNChatMessageModel alloc] init];
    chatMessageModel.user = user;
    chatMessageModel.content = content;
    NSIndexPath *indexPath = [_viewModel appendChatMessageModel:chatMessageModel];
    [_contentTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    _inputTextField.text = @"";
    [_inputTextField becomeFirstResponder];
    if ([_viewModel count] > 0) {
        [_contentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_viewModel count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

@end