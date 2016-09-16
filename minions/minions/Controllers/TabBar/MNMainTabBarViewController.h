//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNConversationViewController;
@class MNContactViewController;
@class MNGroupChatViewController;
@class MNChatRoomViewController;

@interface MNMainTabBarViewController : UITabBarController

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) MNConversationViewController * conversationViewController;
@property (nonatomic, strong) MNContactViewController * contactViewController;
@property (nonatomic, strong) MNGroupChatViewController * groupChatViewController;
@property (nonatomic, strong) MNChatRoomViewController * chatRoomViewController;


@end