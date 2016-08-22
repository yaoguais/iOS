//
// Created by 刘勇 on 16/8/22.
// Copyright (c) 2016 tableview.jegarn.com. All rights reserved.
//

#import "SearchDisplayViewController.h"
#import "ContactGroup.h"
#import "Contact.h"

#define kSearchbarHeight 44
@interface SearchDisplayViewController (){
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchDisplayController;
    NSMutableArray *_contacts;//联系人模型
    NSMutableArray *_searchContacts;//符合条件的搜索联系人
    //BOOL _isSearching;
}
@end

@implementation SearchDisplayViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //添加搜索框
    [self addSearchBar];
    [self.view addSubview:_tableView];

    _tableView.dataSource = self;
    _tableView.delegate = self;
}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (_isSearching) {
//        return 1;
//    }
    //如果当前是UISearchDisplayController内部的tableView则不分组
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    return _contacts.count;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (_isSearching) {
//        return _searchContacts.count;
//    }
    //如果当前是UISearchDisplayController内部的tableView则使用搜索数据
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return _searchContacts.count;
    }
    ContactGroup *group1=_contacts[section];
    return group1.contacts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Contact *contact=nil;

//    if (_isSearching) {
//        contact=_searchContacts[indexPath.row];
//    }else{
//        ContactGroup *group=_contacts[indexPath.section];
//        contact=group.contacts[indexPath.row];
//    }
    //如果当前是UISearchDisplayController内部的tableView则使用搜索数据
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        contact=_searchContacts[indexPath.row];
    }else{
        ContactGroup *group=_contacts[indexPath.section];
        contact=group.contacts[indexPath.row];
    }

    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";

    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text=contact.phoneNumber;

    return cell;
}
#pragma mark - 代理方法
#pragma mark 设置分组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return @"搜索结果";
    }
    ContactGroup *group=_contacts[section];
    return group.name;
}
#pragma mark 选中之前
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_searchBar resignFirstResponder];//退出键盘
    return indexPath;
}
#pragma mark - 搜索框代理
//#pragma mark  取消搜索
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    //_isSearching=NO;
//    _searchBar.text=@"";
//    //[self.tableView reloadData];
//    [_searchBar resignFirstResponder];
//}
//
//#pragma mark 输入搜索关键字
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    if([_searchBar.text isEqual:@""]){
//        //_isSearching=NO;
//        //[self.tableView reloadData];
//        return;
//    }
//    [self searchDataWithKeyWord:_searchBar.text];
//}
//#pragma mark 点击虚拟键盘上的搜索时
//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//
//    [self searchDataWithKeyWord:_searchBar.text];
//
//    [_searchBar resignFirstResponder];//放弃第一响应者对象，关闭虚拟键盘
//}
#pragma mark - UISearchDisplayController代理方法
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self searchDataWithKeyWord:searchString];
    return YES;
}
#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark 加载数据
-(void)initData{
    _contacts=[[NSMutableArray alloc]init];

    Contact *contact1=[Contact initWithFirstName:@"Cui" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    Contact *contact2=[Contact initWithFirstName:@"Cui" andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    ContactGroup *group1=[ContactGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    [_contacts addObject:group1];



    Contact *contact3=[Contact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    Contact *contact4=[Contact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    Contact *contact5=[Contact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    ContactGroup *group2=[ContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    [_contacts addObject:group2];



    Contact *contact6=[Contact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    Contact *contact7=[Contact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];

    ContactGroup *group3=[ContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    [_contacts addObject:group3];


    Contact *contact8=[Contact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    Contact *contact9=[Contact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
    Contact *contact10=[Contact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
    Contact *contact11=[Contact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
    Contact *contact12=[Contact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
    ContactGroup *group4=[ContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    [_contacts addObject:group4];


    Contact *contact13=[Contact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    Contact *contact14=[Contact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    Contact *contact15=[Contact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    ContactGroup *group5=[ContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    [_contacts addObject:group5];

}
#pragma mark 搜索形成新数据
-(void)searchDataWithKeyWord:(NSString *)keyWord{
    //_isSearching=YES;
    _searchContacts=[NSMutableArray array];
    [_contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ContactGroup *group=obj;
        [group.contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Contact *contact=obj;
            if ([contact.firstName.uppercaseString containsString:keyWord.uppercaseString]||[contact.lastName.uppercaseString containsString:keyWord.uppercaseString]||[contact.phoneNumber containsString:keyWord]) {
                [_searchContacts addObject:contact];
            }
        }];
    }];

    //刷新表格
    //[self.tableView reloadData];
}
#pragma mark 添加搜索栏

- (void)addSearchBar {
    _searchBar = [[UISearchBar alloc] init];
    [_searchBar sizeToFit];//大小自适应容器
    _searchBar.placeholder = @"Please input key word...";
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.showsCancelButton = YES;//显示取消按钮
    //添加搜索框到页眉位置
    //_searchBar.delegate=self;
    self.tableView.tableHeaderView = _searchBar;
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    [_searchDisplayController setActive:NO animated:YES];
}
@end