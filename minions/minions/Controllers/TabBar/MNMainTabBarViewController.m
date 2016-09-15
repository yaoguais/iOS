//
// Created by 刘勇 on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNMainTabBarViewController.h"
#import "MNMessageViewController.h"
#import "MNContactViewController.h"
#import "MNGroupChatViewController.h"
#import "MNChatRoomViewController.h"
#import "YGCommonMicro.h"


@implementation MNMainTabBarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 49);
        UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
        [backgroundView setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:35 / 255.0 blue:35 / 255.0 alpha:1]];
        [[self tabBar] addSubview:backgroundView];

        UITableViewController * messageViewController = [[MNMessageViewController alloc] init];
        messageViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Chat"
                                                        image:[[UIImage imageNamed:@"tab_conversation.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tab_conversation_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [messageViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        UITableViewController * contactViewController = [[MNContactViewController alloc] init];
        contactViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contact" image:[[UIImage imageNamed:@"tab_contact.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 selectedImage:[[UIImage imageNamed:@"tab_contact_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [contactViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        UITableViewController * groupChatViewController = [[MNGroupChatViewController alloc] init];
        groupChatViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Group" image:[[UIImage imageNamed:@"tab_groupchat.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                   selectedImage:[[UIImage imageNamed:@"tab_groupchat_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [groupChatViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        UITableViewController * chatRoomViewController = [[MNChatRoomViewController alloc] init];
        chatRoomViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Room" image:[[UIImage imageNamed:@"tab_chatroom.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[UIImage imageNamed:@"tab_chatroom_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [chatRoomViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        self.viewControllers = @[messageViewController, contactViewController, groupChatViewController, chatRoomViewController];
    }

    return self;
}


@end