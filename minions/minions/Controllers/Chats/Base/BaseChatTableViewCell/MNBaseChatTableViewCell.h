//
// Created by Yao Guai on 16/9/16.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MNChatMessageModel;

@interface MNBaseChatTableViewCell : UITableViewCell

@property (nonatomic) BOOL isLoginUser;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *username;
@property (strong, nonatomic) UILabel *content;
@property (nonatomic) CGFloat height;

- (void)renderFromChatMessage:(MNChatMessageModel *)chatMessage isLoginUser:(BOOL)isLoginUser;
+ (void)storageHeight:(CGFloat)height ForRowAtIndexPath:(NSIndexPath *)indexPath;
+ (CGFloat) heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end