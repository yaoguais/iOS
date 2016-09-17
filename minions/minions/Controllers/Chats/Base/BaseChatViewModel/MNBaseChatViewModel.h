//
// Created by Yao Guai on 16/9/16.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MNChatMessageModel;
@class MNUserModel;

@interface MNBaseChatViewModel : NSObject

@property (strong, nonatomic) NSMutableArray * messages;

- (NSUInteger) count;
- (MNChatMessageModel *)chatMessageForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *) appendChatMessageModel: (MNChatMessageModel *) chatMessageModel;

- (void) requestForMessages;

@end