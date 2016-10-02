//
// Created by Yao Guai on 16/9/18.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNBaseChatViewController.h"
#import "JegarnPacketListener.h"

@class MNGroupModel;


@interface MNChatsChatRoomViewController : MNBaseChatViewController<JegarnChatRoomPacketListenerDelegate>
@property (nonatomic, strong) MNGroupModel *groupModel;
@end