//
// Created by 刘勇 on 16/8/25.
// Copyright (c) 2016 refresh.jegarn.com. All rights reserved.
//

#import "RefreshHeaderViewController.h"
#import "MJRefreshNormalHeader.h"

static const CGFloat MJDuration = 2.0;
static int stepIndex = 0;
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", ++stepIndex]


@implementation RefreshHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _data = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [_data insertObject:MJRandomData atIndex:0];
    }

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    __weak __typeof(self) weakSelf = self;

    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.data removeAllObjects];
        [weakSelf loadNewData];
    }];



    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];

    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark - 隐藏状态栏

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据

- (void)loadNewData {
    // 1.添加假数据
    for (int i = 0; i < 5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }

    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];

        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"count %d", self.data.count);
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", indexPath.row % 2 ? @"push" : @"modal", self.data[indexPath.row]];
    //NSLog(@"text %@", cell.textLabel.text);

    return cell;
}

@end