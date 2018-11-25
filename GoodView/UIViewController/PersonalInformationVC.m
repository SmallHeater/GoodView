//
//  PersonalInformationVC.m
//  GoodView
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 mac. All rights reserved.
//

#import "PersonalInformationVC.h"
#import "MyEntryModel.h"
#import "AvatarCell.h"
#import "MyEntryCell.h"
#import "AccountBindingVC.h"

@interface PersonalInformationVC ()

@end

@implementation PersonalInformationVC

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //头像模型
    MyEntryModel * avatarModel = [[MyEntryModel alloc] init];
    avatarModel.title = @"头像";
    avatarModel.imageUrlString = @"";
    [self.dataArray addObject:avatarModel];
    //名字模型
    MyEntryModel * nameModel = [[MyEntryModel alloc] init];
    nameModel.title = @"名字";
    nameModel.content = [AccountManager sharedManager].userModel.nickname;
    [self.dataArray addObject:nameModel];
    //电话号码模型
    MyEntryModel * phoneNumberModel = [[MyEntryModel alloc] init];
    phoneNumberModel.title = @"电话号码";
    NSMutableString * phoneNumber = [[NSMutableString alloc] initWithString:[AccountManager sharedManager].userModel.jhmobile];
    NSString * newPhoneNumber = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
    phoneNumberModel.content = newPhoneNumber;
    [self.dataArray addObject:phoneNumberModel];
    //账号绑定模型
    MyEntryModel * bindingModel = [[MyEntryModel alloc] init];
    bindingModel.title = @"账号绑定";
    [self.dataArray addObject:bindingModel];
    //地区模型
    MyEntryModel * areaModel = [[MyEntryModel alloc] init];
    areaModel.title = @"地区";
    [self.dataArray addObject:areaModel];
    
    self.tableView.scrollEnabled = NO;
}


#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 70;
    }
    else if (indexPath.section == 1){
        
        return 50;
    }
    else if (indexPath.section == 2){
        
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 15;
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 20)];
    view.backgroundColor = Color_F5F5F5;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        AccountBindingVC * accountVC = [[AccountBindingVC alloc] initWithTitle:@"账号绑定" andTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:accountVC animated:NO];
    }
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    else if (section == 1){
        
        return 2;
    }
    else if (section == 2){
        
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString * cellID = @"AvatarCell";
        AvatarCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            
            cell = [[AvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MyEntryModel * avatarModel = self.dataArray[0];
        [cell setTitle:avatarModel.title andImage:@""];
        return cell;
    }
    else if (indexPath.section == 1){
        
        static NSString * cellID = @"MyEntryCell";
        MyEntryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            
            cell = [[MyEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MyEntryModel * model = self.dataArray[indexPath.row + 1];
        [cell setIconImage:@"" andTitle:model.title andContent:model.content andShowLine:indexPath.row == 1?NO:YES];
        return cell;
    }
    else if (indexPath.section == 2){
        
        static NSString * cellID = @"MyEntryCell";
        MyEntryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            
            cell = [[MyEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MyEntryModel * model = self.dataArray[indexPath.row + 3];
        [cell setIconImage:@"" andTitle:model.title andContent:@"" andShowLine:indexPath.row == 1?NO:YES];
        return cell;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

#pragma mark  ----  自定义函数


@end
