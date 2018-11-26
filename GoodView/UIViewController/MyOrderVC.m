//
//  PersonalInformationVC.m
//  GoodView
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 mac. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderCell.h"

@interface MyOrderVC ()

@end

@implementation MyOrderVC

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 165;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"MyOrderCell";
    MyOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark  ----  自定义函数

/*
 
 -(void)headerRereshing{
 
 _count = @"0";
 
 DLog(@"%@--%@",[DZUserTool sharedDZUserTool].dzuser.latitude,[DZUserTool sharedDZUserTool].dzuser.longitude);
 
 [HTTPTool postWithURL:KGENURL@"User/orderlist" Set:kset params:@{@"number":_count,@"user_id":[DZUserTool sharedDZUserTool].dzuser.usertoken} success:^(id responseObject) {
 
 
 if(![responseObject[@"orders"]  isEqual:[NSNull null]]){
 
 
 NSArray *orders = [JHOrders objectArrayWithKeyValuesArray:responseObject[@"orders"]];
 
 _testDataArr = [NSMutableArray array];
 for (JHOrders *order in orders) {
 [_testDataArr addObject:order];
 }
 }else{
 _testDataArr = [NSMutableArray array];
 }
 // 刷新表格
 [self.tableView reloadData];
 [self.tableView.header endRefreshing];
 
 } failure:^(NSError *error) {
 [ProgressHUD showError:@"网络异常"];
 }];
 
 }
 -(void)footerRereshing{
 
 DLog(@"_________________________%@",[DZUserTool sharedDZUserTool].dzuser.latitude);
 
 _count = [NSString stringWithFormat:@"%lu",(unsigned long)_testDataArr.count];
 [HTTPTool postWithURL:KGENURL@"User/orderlist" Set:kset params:@{@"number":_count,@"user_id":[DZUserTool sharedDZUserTool].dzuser.usertoken} success:^(id responseObject) {
 
 if(![responseObject[@"orders"]  isEqual:[NSNull null]]){
 
 NSArray *orders = [JHOrders objectArrayWithKeyValuesArray:responseObject[@"orders"]];
 _testDataArr = [NSMutableArray array];
 for (JHOrders *order in orders) {
 [_testDataArr addObject:order];
 }
 
 }        // 刷新表格
 [self.tableView reloadData];
 [self.tableView.footer endRefreshing];
 
 } failure:^(NSError *error) {
 [ProgressHUD showError:@"网络异常"];
 }];
 }
 
 */


@end
