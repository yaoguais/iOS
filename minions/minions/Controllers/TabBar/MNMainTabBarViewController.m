//
// Created by Yao Guai on 16/7/24.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

#import "MNMainTabBarViewController.h"
#import "MNConversationViewController.h"
#import "MNContactViewController.h"
#import "MNGroupChatViewController.h"
#import "MNChatRoomViewController.h"


@implementation MNMainTabBarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 49)];
        [_backgroundView setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:35 / 255.0 blue:35 / 255.0 alpha:1]];

        _conversationViewController = [[MNConversationViewController alloc] init];
        _contactViewController = [[MNContactViewController alloc] init];
        _groupChatViewController = [[MNGroupChatViewController alloc] init];
        _chatRoomViewController = [[MNChatRoomViewController alloc] init];

        _conversationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Chat"
                                                                               image:[[UIImage imageNamed:@"tab_conversation.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                       selectedImage:[[UIImage imageNamed:@"tab_conversation_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_conversationViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_contactViewController.tabBarItem setTag:0];

        _contactViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contact" image:[[UIImage imageNamed:@"tab_contact.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[UIImage imageNamed:@"tab_contact_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_contactViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_contactViewController.tabBarItem setTag:1];

        _groupChatViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Group" image:[[UIImage imageNamed:@"tab_groupchat.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                    selectedImage:[[UIImage imageNamed:@"tab_groupchat_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_groupChatViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_groupChatViewController.tabBarItem setTag:2];

        _chatRoomViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Room" image:[[UIImage imageNamed:@"tab_chatroom.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                   selectedImage:[[UIImage imageNamed:@"tab_chatroom_selected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_chatRoomViewController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_chatRoomViewController.tabBarItem setTag:3];

        [[self tabBar] addSubview:_backgroundView];
        self.viewControllers = @[_conversationViewController, _contactViewController, _groupChatViewController, _chatRoomViewController];
        self.selectedIndex = 0;
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    switch (item.tag) {
        case 0:
            self.title = @"Conversation";
            break;
        case 1:
            self.title = @"Contact";
            break;
        case 2:
            self.title = @"GroupChat";
            break;
        case 3:
            self.title = @"ChatRoom";
            break;
        default:
            break;
    }
}

@end