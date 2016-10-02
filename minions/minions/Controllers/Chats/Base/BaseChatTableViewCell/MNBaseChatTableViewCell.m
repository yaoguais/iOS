//
// Created by Yao Guai on 16/9/16.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <YYWebImage/UIImageView+YYWebImage.h>
#import "MNBaseChatTableViewCell.h"
#import "MNChatMessageModel.h"
#import "MNUserModel.h"
#import "YGCommonMicro.h"
#import "MNResourceUtil.h"


@implementation MNBaseChatTableViewCell

static NSMutableDictionary *chatTableViewCellHeights;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _avatar = [[UIImageView alloc] init];
        [self addSubview:_avatar];
        _username = [[UILabel alloc] init];
        _username.font = [UIFont systemFontOfSize:10.0];
        _username.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_username];
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_content];
    }
    return self;
}

- (void)renderFromChatMessage:(MNChatMessageModel *)chatMessage isLoginUser:(BOOL)isLoginUser {
    _isLoginUser = isLoginUser;
    _avatar.image = [UIImage imageNamed:chatMessage.user.avatar];
    [_avatar yy_setImageWithURL:[NSURL URLWithString:[MNResourceUtil getUrl:chatMessage.user.avatar]] placeholder:[MNResourceUtil getAvatarPlaceholder]];
    _avatar.contentMode = UIViewContentModeScaleAspectFit;
    _username.text = chatMessage.user.account;
    _content.text = chatMessage.content;
    const CGFloat avatarWidth = 50;
    const CGFloat commonMargin = 2;
    const CGFloat marginTop = 10;
    CGFloat contentWidth = YGWindowWidth - avatarWidth - 100;
    CGSize contentSize = [_content.text boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _content.font} context:nil].size;

    if (!isLoginUser) {
        _avatar.frame = CGRectMake(commonMargin, commonMargin+marginTop, avatarWidth, avatarWidth);
        _username.frame = CGRectMake(commonMargin, avatarWidth + commonMargin + marginTop, avatarWidth, 20);
        _content.frame = CGRectMake(avatarWidth+ commonMargin * 2, commonMargin + marginTop, contentSize.width, contentSize.height);
    } else {
        _avatar.frame = CGRectMake(YGWindowWidth - avatarWidth - commonMargin, commonMargin + marginTop, avatarWidth, avatarWidth);
        _username.frame = CGRectMake(YGWindowWidth - avatarWidth - commonMargin, avatarWidth + commonMargin + marginTop, avatarWidth, 20);
        _content.frame = CGRectMake(YGWindowWidth - avatarWidth - contentSize.width - commonMargin * 2, commonMargin + marginTop, contentSize.width, contentSize.height);
    }

    _height = marginTop + 20 + (contentSize.height > avatarWidth ? contentSize.height : avatarWidth);
}

+ (void)storageHeight:(CGFloat)height ForRowAtIndexPath:(NSIndexPath *)indexPath {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chatTableViewCellHeights = [[NSMutableDictionary alloc] init];
    });
    chatTableViewCellHeights[indexPath] = @(height);
}

+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((NSNumber *) chatTableViewCellHeights[indexPath]).floatValue;
}

@end