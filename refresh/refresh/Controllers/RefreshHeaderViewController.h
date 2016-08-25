//
// Created by 刘勇 on 16/8/25.
// Copyright (c) 2016 refresh.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RefreshHeaderViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *data;

@end