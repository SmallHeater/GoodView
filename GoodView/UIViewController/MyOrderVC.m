//
//  PersonalInformationVC.m
//  GoodView
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 mac. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderCell.h"
#import "OrderModel.h"


@interface MyOrderVC ()

@end

@implementation MyOrderVC

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
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
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"MyOrderCell";
    MyOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    OrderModel * model = self.dataArray[indexPath.row];
    [cell setIcon:[[NSString alloc] initWithFormat:@"%@%@",KIMGURL,model.scenic_img] scenicName:model.scenic_name isPay:model.is_pay price:model.money payType:model.pay_type buyTime:model.add_time];
    return cell;
}

#pragma mark  ----  自定义函数
//获取数据
-(void)getData{
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KGENURL]];
    [manager POST:@"User/orderlist" parameters:@{@"user_id":@"13"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber * status = responseObject[@"status"];
        if (status.integerValue == 1) {
            
            NSArray * ordersArray = responseObject[@"orders"];
            
            for (NSUInteger i = 0; i < ordersArray.count; i++) {
                
                NSDictionary * dic = ordersArray[i];
                NSError * error;
                OrderModel * model = [[OrderModel alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.dataArray addObject:model];
                }
            }
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD showErrorMessage:@"请求失败，请检查网络"];
    }];
}

//下拉刷新
-(void)loadNewData{
    
    [self getData];
    [self.tableView.mj_header endRefreshing];
}


@end
