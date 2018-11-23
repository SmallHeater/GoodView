//
//  MyViewController.m
//  GoodView
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 mac. All rights reserved.
//

#import "MyViewController.h"
#import "SHLabelAndLabelView.h"
#import "MyEntryModel.h"
#import "MyEntryCell.h"
#import "PersonalInformationVC.h"
#import "TabbarViewController.h"
#import "AboutViewController.h"
#import "LoginViewController.h"
#import "SelectCityViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
//头像区域
@property (nonatomic,strong) UIView * headView;
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIImageView * avatarImageView;
//用户名
@property (nonatomic,strong) UILabel * userNameLabel;
//联系人，我的余额，我的收藏区域
@property (nonatomic,strong) UIView * middleView;
//列表区域
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray<MyEntryModel *> * dataArray;
//退出登录按钮
@property (nonatomic,strong) UIButton * logOutBtn;
//底部灰条
@property (nonatomic,strong) UILabel * bottomLabel;

@end

@implementation MyViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.busNavigationBar.hidden = YES;
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    TabbarViewController * control = (TabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [control showTabbar];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    TabbarViewController * control = (TabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [control hidTabbar];
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
        
    }
    else if (indexPath.row == 2){
        
    }
    else if (indexPath.row == 3){
        
        AboutViewController * aboutVC = [[AboutViewController alloc] initWithTitle:@"关于景好"];
        [self.navigationController pushViewController:aboutVC animated:NO];
    }
    else if (indexPath.row == 4) {
        
        UIAlertController * alertControl = [UIAlertController alertControllerWithTitle:@"拨打电话" message:@"0571-29605717" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:0571-29605717"]];
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
    [cell setIconImage:model.iconName andTitle:model.title andContent:model.content andShowLine:YES];
    return cell;
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.bgView];
    [self.bgView addSubview:self.avatarImageView];
    [self.headView addSubview:self.userNameLabel];
    [self.view addSubview:self.middleView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logOutBtn];
    [self.view addSubview:self.bottomLabel];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.equalTo(self.headView.mas_width).multipliedBy(2.0/3.0f);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.headView.mas_centerX);
        make.centerY.equalTo(self.headView.mas_centerY);
        make.width.height.offset(80);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.centerY.equalTo(self.bgView.mas_centerY);
        make.width.height.offset(70);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.bgView.mas_bottom).offset(5);
        make.height.offset(15);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.headView.mas_bottom).offset(0);
        make.height.offset(70);
    }];
    
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.offset(0);
        make.top.equalTo(self.middleView.mas_bottom).offset(0);
        make.height.offset(40 * 5);
    }];

    [self.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.offset(0);
        make.top.equalTo(self.tableView.mas_bottom).offset(0);
        make.height.offset(60);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.logOutBtn.mas_bottom).offset(0);
        make.bottom.offset(-49);
    }];
}

//退出登录响应
-(void)logOutBtnClicked{
    
}

//个人信息点击的响应
-(void)userNameLabelTaped{
    
    PersonalInformationVC * vc = [[PersonalInformationVC alloc] initWithTitle:@"个人信息" andTableViewStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:NO];
    
//    LoginViewController * logIn = [[LoginViewController alloc] initWithTitle:@"登录"];
//    [self.navigationController pushViewController:logIn animated:YES];
    
//    SelectCityViewController * vc = [[SelectCityViewController alloc] initWithTitle:@"选择城市"];
//    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark  ----  懒加载
-(UIView *)headView{
    
    if (!_headView) {
        
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor greenColor];
        
        
        
        
    }
    return _headView;
}

-(UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 40;
    }
    return _bgView;
}

-(UIImageView *)avatarImageView{
    
    if (!_avatarImageView) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor redColor];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 35;
    }
    return _avatarImageView;
}

-(UILabel *)userNameLabel{
    
    if (!_userNameLabel) {
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.text = @"游客 >";
        _userNameLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userNameLabelTaped)];
        [_userNameLabel addGestureRecognizer:tap];
    }
    return _userNameLabel;
}

-(UIView *)middleView{
    
    if (!_middleView) {
        
        _middleView = [[UIView alloc] init];
//        _middleView.backgroundColor = [UIColor whiteColor];
        //每个子view的平均宽度
        float viewWidth = MAINWIDTH / 3;
        //联系人
        SHLabelAndLabelView * contactView = [[SHLabelAndLabelView alloc] initWithFrame:CGRectMake(0, 10, viewWidth, 50) andFirstLabelFrame:CGRectMake(0, 0, viewWidth, 20) andSecondLabelFrame:CGRectMake(0, 30, viewWidth, 20) andFirstLabelText:@"0" andSecondLabelText:@"联系人"];
        [contactView refreshFirstLabelFont:nil textColor:nil textAlignment:NSTextAlignmentCenter];
        [contactView refreshSecondLabelFont:nil textColor:nil textAlignment:NSTextAlignmentCenter];
        [_middleView addSubview:contactView];
        //我的余额
        SHLabelAndLabelView * myBalanceView = [[SHLabelAndLabelView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(contactView.frame), CGRectGetMinY(contactView.frame), viewWidth, CGRectGetHeight(contactView.frame)) andFirstLabelFrame:CGRectMake(0, 0, viewWidth, 20) andSecondLabelFrame:CGRectMake(0, 30, viewWidth, 20) andFirstLabelText:@"0" andSecondLabelText:@"我的余额"];
        [myBalanceView refreshFirstLabelFont:nil textColor:nil textAlignment:NSTextAlignmentCenter];
        [myBalanceView refreshSecondLabelFont:nil textColor:nil textAlignment:NSTextAlignmentCenter];
        [_middleView addSubview:myBalanceView];
        CALayer *leftLayer = [CALayer layer];
        leftLayer.frame = CGRectMake(0, 0, 1, CGRectGetHeight(myBalanceView.frame));
        leftLayer.backgroundColor = [UIColor greenColor].CGColor;
        [myBalanceView.layer addSublayer:leftLayer];
        CALayer *rightLayer = [CALayer layer];
        rightLayer.frame = CGRectMake(CGRectGetWidth(myBalanceView.frame) - 1, 0, 1, CGRectGetHeight(myBalanceView.frame));
        rightLayer.backgroundColor = [UIColor grayColor].CGColor;
        [myBalanceView.layer addSublayer:rightLayer];
        //我的收藏
        SHLabelAndLabelView * myCollectionView = [[SHLabelAndLabelView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myBalanceView.frame), CGRectGetMinY(contactView.frame), viewWidth, CGRectGetHeight(contactView.frame)) andFirstLabelFrame:CGRectMake(0, 0, viewWidth, 20) andSecondLabelFrame:CGRectMake(0, 30, viewWidth, 20) andFirstLabelText:@"0" andSecondLabelText:@"我的收藏"];
        [myCollectionView refreshFirstLabelFont:nil textColor:nil textAlignment:NSTextAlignmentCenter];
        [myCollectionView refreshSecondLabelFont:nil textColor:nil textAlignment:NSTextAlignmentCenter];
        [_middleView addSubview:myCollectionView];
        //底部灰框
        UILabel * bottomLabel = [[UILabel alloc] init];
        bottomLabel.frame = CGRectMake(0, CGRectGetMaxY(contactView.frame), MAINWIDTH, 10);
        bottomLabel.backgroundColor = [UIColor grayColor];
        [_middleView addSubview:bottomLabel];
    }
    return _middleView;
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
    }
    return _tableView;
}

-(UIButton *)logOutBtn{
    
    if (!_logOutBtn) {
        
        _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_logOutBtn addTarget:self action:@selector(logOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logOutBtn;
}

-(NSMutableArray<MyEntryModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
        
        //我的订单
        MyEntryModel * myOrderModel = [[MyEntryModel alloc] init];
        myOrderModel.iconName = @"draft@2x.png";
        myOrderModel.title = @"我的订单";
        myOrderModel.content = @"查看所有订单";
        [_dataArray addObject:myOrderModel];
        //扩音器订单
        MyEntryModel * amplifierOrderModel = [[MyEntryModel alloc] init];
        amplifierOrderModel.iconName = @"draft@2x.png";
        amplifierOrderModel.title = @"扩音器订单";
        amplifierOrderModel.content = @"查看所有订单";
        [_dataArray addObject:amplifierOrderModel];
        //离线包管理
        MyEntryModel * offlinePackageManagementModel = [[MyEntryModel alloc] init];
        offlinePackageManagementModel.iconName = @"draft@2x.png";
        offlinePackageManagementModel.title = @"离线包管理";
        [_dataArray addObject:offlinePackageManagementModel];
        //关于景好
        MyEntryModel * aboutJingjingModel = [[MyEntryModel alloc] init];
        aboutJingjingModel.iconName = @"draft@2x.png";
        aboutJingjingModel.title = @"关于景好";
        [_dataArray addObject:aboutJingjingModel];
        //联系客服
        MyEntryModel * contactCustomerServiceModel = [[MyEntryModel alloc] init];
        contactCustomerServiceModel.iconName = @"draft@2x.png";
        contactCustomerServiceModel.title = @"联系客服";
        [_dataArray addObject:contactCustomerServiceModel];
    }
    return _dataArray;
}

-(UILabel *)bottomLabel{
    
    if (!_bottomLabel) {
        
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = [UIColor grayColor];
    }
    return _bottomLabel;
}

@end
