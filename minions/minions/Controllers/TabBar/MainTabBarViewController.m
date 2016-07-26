//
// Created by 刘勇 on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MessageViewController.h"
#import "ContactViewController.h"
#import "GroupChatViewController.h"
#import "ChatRoomViewController.h"


@implementation MainTabBarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        UITableViewController * messageViewController = [[MessageViewController alloc] init];
        messageViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[[UIImage imageNamed:@"tab_conversation.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"tab_conversation_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [messageViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        UITableViewController * contactViewController = [[ContactViewController alloc] init];
        contactViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab_contact.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 selectedImage:[[UIImage imageNamed:@"tab_contact_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [contactViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        UITableViewController * groupChatViewController = [[GroupChatViewController alloc] init];
        groupChatViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab_groupchat.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                   selectedImage:[[UIImage imageNamed:@"tab_groupchat_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [groupChatViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        UITableViewController * chatRoomViewController = [[ChatRoomViewController alloc] init];
        chatRoomViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"tab_chatroom.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[UIImage imageNamed:@"tab_chatroom_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [chatRoomViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        self.viewControllers = @[messageViewController, contactViewController, groupChatViewController, chatRoomViewController];

    }

    return self;
}


@end