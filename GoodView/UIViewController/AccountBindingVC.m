//
//  AccountBindingVC.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AccountBindingVC.h"
#import "MyEntryModel.h"
#import "MyEntryCell.h"

@interface AccountBindingVC ()

@end

@implementation AccountBindingVC



#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //昵称模型
    MyEntryModel * nicknameModel = [[MyEntryModel alloc] init];
    nicknameModel.title = @"昵称";
    nicknameModel.content = @"11";
    [self.dataArray addObject:nicknameModel];
    //登录密码模型
    MyEntryModel * passwordModel = [[MyEntryModel alloc] init];
    passwordModel.title = @"登录密码";
    passwordModel.content = @"修改";
    [self.dataArray addObject:passwordModel];
    //手机模型
    MyEntryModel * phoneNumberModel = [[MyEntryModel alloc] init];
    phoneNumberModel.iconName = @"draft@2x.png";
    phoneNumberModel.title = @"手机号";
    phoneNumberModel.content = @"15010111111";
    [self.dataArray addObject:phoneNumberModel];
    //微信模型
    MyEntryModel * wechatModel = [[MyEntryModel alloc] init];
    wechatModel.iconName = @"draft@2x.png";
    wechatModel.title = @"微信";
    wechatModel.content = @"未绑定";
    [self.dataArray addObject:wechatModel];
    //QQ模型
    MyEntryModel * QQModel = [[MyEntryModel alloc] init];
    QQModel.iconName = @"draft@2x.png";
    QQModel.title = @"QQ";
    QQModel.content = @"已绑定";
    [self.dataArray addObject:QQModel];
    
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.scrollEnabled = NO;
}


#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 20)];
    view.backgroundColor = [UIColor grayColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 2;
    }
    else if (section == 1){
        
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        
        static NSString * cellID = @"MyEntryCell";
        MyEntryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            
            cell = [[MyEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        }
        MyEntryModel * model = self.dataArray[indexPath.row];
        [cell setIconImage:@"" andTitle:model.title andContent:model.content andShowLine:indexPath.row == 1?NO:YES];
        return cell;
    }
    else if (indexPath.section == 1){
        
        static NSString * cellID = @"MyEntryCell";
        MyEntryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            
            cell = [[MyEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        }
        MyEntryModel * model = self.dataArray[indexPath.row + 2];
        [cell setIconImage:model.iconName andTitle:model.title andContent:model.content andShowLine:indexPath.row == 2?NO:YES];
        return cell;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

#pragma mark  ----  自定义函数



@end
