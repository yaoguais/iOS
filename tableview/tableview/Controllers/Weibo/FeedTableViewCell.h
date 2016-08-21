//
// Created by 刘勇 on 16/8/21.
// Copyright (c) 2016 tableview.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Feed;


@interface FeedTableViewCell : UITableViewCell

#pragma mark 微博对象
@property (nonatomic,strong) Feed * status;

#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;

@end