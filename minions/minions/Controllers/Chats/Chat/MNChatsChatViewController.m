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


@implementation MNChatsChatViewController

- (void)sendButtonClick {
    NSString *content = _inputTextField.text;
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (YGIsEmptyString(content)) {
        [MNWidgetUtil alertWithController:self title:@"Alter" mssage:@"content can not be empty"];
        return;
    }

    MNChatMessageModel *chatMessageModel = [[MNChatMessageModel alloc] init];
    if (arc4random() % 2 == 1) {
        chatMessageModel.user = _loginUser;
    } else {
        chatMessageModel.user = _chatWithUser;
    }
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