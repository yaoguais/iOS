//
// Created by 刘勇 on 16/8/21.
// Copyright (c) 2016 tableview.jegarn.com. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactGroup.h"
#import "Contact.h"


@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];

    //创建一个分组样式的UITableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(kContactToolbarHeight, 0, 0, 0);
    [self.view addSubview:_tableView];

    [self addToolbar];

    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource = self;

    _tableView.delegate = self;
}


#pragma mark 加载数据

- (void)initData {
    _contacts = [[NSMutableArray alloc] init];

    Contact *contact1 = [Contact initWithFirstName:@"Cui" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    Contact *contact2 = [Contact initWithFirstName:@"Cui" andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    ContactGroup *group1 = [ContactGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1, contact2, nil]];
    [_contacts addObject:group1];


    Contact *contact3 = [Contact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    Contact *contact4 = [Contact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    Contact *contact5 = [Contact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    ContactGroup *group2 = [ContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3, contact4, contact5, nil]];
    [_contacts addObject:group2];


    Contact *contact6 = [Contact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    Contact *contact7 = [Contact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];

    ContactGroup *group3 = [ContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6, contact7, nil]];
    [_contacts addObject:group3];


    Contact *contact8 = [Contact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    Contact *contact9 = [Contact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
    Contact *contact10 = [Contact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
    Contact *contact11 = [Contact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
    Contact *contact12 = [Contact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
    ContactGroup *group4 = [ContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8, contact9, contact10, contact11, contact12, nil]];
    [_contacts addObject:group4];


    Contact *contact13 = [Contact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    Contact *contact14 = [Contact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    Contact *contact15 = [Contact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    ContactGroup *group5 = [ContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13, contact14, contact15, nil]];
    [_contacts addObject:group5];

}

#pragma mark 添加工具栏

- (void)addToolbar {
    CGRect frame = self.view.frame;
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, kContactToolbarHeight)];
    //    _toolbar.backgroundColor=[UIColor colorWithHue:246/255.0 saturation:246/255.0 brightness:246/255.0 alpha:1];
    [self.view addSubview:_toolbar];
    UIBarButtonItem *removeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(remove)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    NSArray *buttonArray = @[removeButton, flexibleButton, addButton];
    _toolbar.items = buttonArray;
}

#pragma mark 删除

- (void)remove {
    //直接通过下面的方法设置编辑状态没有动画
    //_tableView.editing=!_tableView.isEditing;
    _isInsert = false;
    [_tableView setEditing:!_tableView.isEditing animated:true];
}

#pragma mark 取得当前操作状态，根据不同的状态左侧出现不同的操作按钮

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isInsert) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

#pragma mark 删除操作

//实现了此方法向左滑动就会显示删除按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactGroup *group = _contacts[indexPath.section];
    Contact *contact = group.contacts[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [group.contacts removeObject:contact];
        //考虑到性能这里不建议使用reloadData
        //[tableView reloadData];
        //使用下面的方法既可以局部刷新又有动画效果
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];

        //如果当前组中没有数据则移除组刷新整个表格
        if (group.contacts.count == 0) {
            [_contacts removeObject:group];
            [tableView reloadData];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        Contact *newContact = [[Contact alloc] init];
        newContact.firstName = @"first";
        newContact.lastName = @"last";
        newContact.phoneNumber = @"12345678901";
        [group.contacts insertObject:newContact atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];//注意这里没有使用reladData刷新
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    ContactGroup *sourceGroup = _contacts[sourceIndexPath.section];
    Contact *sourceContact = sourceGroup.contacts[sourceIndexPath.row];
    ContactGroup *destinationGroup = _contacts[destinationIndexPath.section];

    [sourceGroup.contacts removeObject:sourceContact];
    if (sourceGroup.contacts.count == 0) {
        [_contacts removeObject:sourceGroup];
        [tableView reloadData];
    }

    [destinationGroup.contacts insertObject:sourceContact atIndex:destinationIndexPath.row];

}


#pragma mark 添加

- (void)add {
    _isInsert = true;
    [_tableView setEditing:!_tableView.isEditing animated:true];
}

#pragma mark - 数据源方法
#pragma mark 返回分组数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"计算分组数");
    return _contacts.count;
}

#pragma mark 返回每组行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"计算每组(组%i)行数", section);
    ContactGroup *group1 = _contacts[section];
    return group1.contacts.count;
}

#pragma mark返回每行的单元格

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Cell重用机制 http://www.jianshu.com/p/b2bba60c0976
    //NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
    ContactGroup *group = _contacts[indexPath.section];
    Contact *contact = group.contacts[indexPath.row];

    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    static NSString *cellIdentifierForFirstRow = @"UITableViewCellIdentifierKeyWithSwitch";
    //首先根据标示去缓存池取
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierForFirstRow];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    //如果缓存池没有取到则重新创建并放到缓存池中
    if (!cell) {
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifierForFirstRow];
            UISwitch *sw = [[UISwitch alloc] init];
            [sw addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = sw;
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
    }

    if (indexPath.row == 0) {
        ((UISwitch *) cell.accessoryView).tag = indexPath.section;
    }

    cell.textLabel.text = [contact getName];
    cell.detailTextLabel.text = contact.phoneNumber;
    //NSLog(@"cell:%@",cell);

    return cell;
}

#pragma mark 返回每组头标题名称

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //NSLog(@"生成组（组%i）名称", section);
    ContactGroup *group = _contacts[section];
    return group.name;
}

#pragma mark 返回每组尾部说明

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    //NSLog(@"生成尾部（组%i）详情", section);
    ContactGroup *group = _contacts[section];
    return group.detail;
}

#pragma mark 返回每组标题索引

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //NSLog(@"生成组索引");
    NSMutableArray *indexs = [[NSMutableArray alloc] init];
    for (ContactGroup *group in _contacts) {
        [indexs addObject:group.name];
    }
    return indexs;
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

#pragma mark 设置尾部说明内容高度

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}


#pragma mark 点击行

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"click %@", indexPath);
    _selectedIndexPath = indexPath;
    ContactGroup *group = _contacts[indexPath.section];
    Contact *contact = group.contacts[indexPath.row];
    //创建弹出窗口
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"System Info" message:[contact getName] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput; //设置窗口内容样式
    UITextField *textField = [alert textFieldAtIndex:0]; //取得文本框
    textField.text = contact.phoneNumber; //设置文本框内容
    [alert show]; //显示窗口
}

#pragma mark 窗口的代理方法，用户保存数据

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //当点击了第二个按钮（OK）
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        //修改模型数据
        ContactGroup *group = _contacts[_selectedIndexPath.section];
        Contact *contact = group.contacts[_selectedIndexPath.row];
        contact.phoneNumber = textField.text;
        //刷新表格
        //[_tableView reloadData];

        // 优化为局部刷新
        NSArray *indexPaths = @[_selectedIndexPath];
        [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];//后面的参数代表更新时的动画
    }
}

#pragma mark 重写状态样式方法

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark 切换开关转化事件

- (void)switchValueChange:(UISwitch *)sw {
    NSLog(@"section:%i,switch:%i", sw.tag, sw.on);
}

@end