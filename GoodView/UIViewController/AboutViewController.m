//
//  AboutViewController.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AboutViewController.h"
#import "MyEntryModel.h"
#import "MyEntryCell.h"

@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>

//头部图标版本区域
@property (nonatomic,strong) UIView * headerView;
@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * versionLabel;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray<MyEntryModel *> * dataArray;
@property (nonatomic,strong) UIView * bottomView;
//协议
@property (nonatomic,strong) UILabel * protocolLabel;
@property (nonatomic,strong) UILabel * remarksLabel;


@end

@implementation AboutViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        
    }
    else if (indexPath.row == 1){
        
        UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"是否清除浏览生成的缓存数据？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [alertControl addAction:cancleAction];
        [alertControl addAction:sureAction];
        [self presentViewController:alertControl animated:YES completion:^{
            
        }];
    }
    else if (indexPath.row == 2){
        
        UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"清除数据" message:@"是否清空本地离线包所有文件？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [alertControl addAction:cancleAction];
        [alertControl addAction:sureAction];
        [self presentViewController:alertControl animated:YES completion:^{
            
        }];
    }
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"MyEntryCell";
    MyEntryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[MyEntryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MyEntryModel * model = self.dataArray[indexPath.row];
    [cell setIconImage:model.iconName andTitle:model.title andContent:model.content andShowLine:indexPath.row == 2?NO:YES];
    return cell;
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.busNavigationBar.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.equalTo(self.headerView.mas_width).multipliedBy(0.5f);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(20);
        make.width.height.offset(50);
        make.left.offset((MAINWIDTH - 50) / 2);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.height.offset(15);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.height.offset(40 * 3);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.tableView.mas_bottom).offset(0);
    }];
    
    [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset(-50);
        make.height.offset(15);
    }];
    
    [self.remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset(-5);
        make.height.offset(40);
    }];
}

//协议被点击
-(void)protocolLabelTaped{
    
}

#pragma mark  ----  懒加载
-(UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor redColor];
        [_headerView addSubview:self.iconImageView];
        [_headerView addSubview:self.versionLabel];
    }
    return _headerView;
}

-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor greenColor];
    }
    return _iconImageView;
}

-(UILabel *)versionLabel{
    
    if (!_versionLabel) {
        
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.text = @"系统版本：4.5.2";
    }
    return _versionLabel;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //取消contentSize和contentOffset的改的，解决闪屏问题
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(NSMutableArray<MyEntryModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
        
        //公司简介
        MyEntryModel * myOrderModel = [[MyEntryModel alloc] init];
        myOrderModel.title = @"公司简介";
        [_dataArray addObject:myOrderModel];
        //清除缓存
        MyEntryModel * amplifierOrderModel = [[MyEntryModel alloc] init];
        amplifierOrderModel.title = @"清除缓存";
        amplifierOrderModel.content = @"583.0K";
        [_dataArray addObject:amplifierOrderModel];
        //清除数据
        MyEntryModel * offlinePackageManagementModel = [[MyEntryModel alloc] init];
        offlinePackageManagementModel.title = @"清除数据";
        [_dataArray addObject:offlinePackageManagementModel];
    }
    return _dataArray;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        [_bottomView addSubview:self.protocolLabel];
        [_bottomView addSubview:self.remarksLabel];
    }
    return _bottomView;
}

-(UILabel *)protocolLabel{
    
    if (!_protocolLabel) {
        
        _protocolLabel = [[UILabel alloc] init];
        _protocolLabel.textAlignment = NSTextAlignmentCenter;
        _protocolLabel.text = @"协议";
        _protocolLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolLabelTaped)];
        [_protocolLabel addGestureRecognizer:tap];
    }
    return _protocolLabel;
}

-(UILabel *)remarksLabel{
    
    if (!_remarksLabel) {
        
        _remarksLabel = [[UILabel alloc] init];
        _remarksLabel.textAlignment = NSTextAlignmentCenter;
        _remarksLabel.numberOfLines = 0;
        _remarksLabel.font = [UIFont systemFontOfSize:14];
        _remarksLabel.text = @"景好公司 版权所有\n2014";
    }
    return _remarksLabel;
}

@end
