//
//  MyViewController.m
//  GoodView
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 mac. All rights reserved.
//

#import "MyViewController.h"
#import "SHLabelAndLabelView.h"


@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
//头像区域
@property (nonatomic,strong) UIView * headView;
//联系人，我的余额，我的收藏区域
@property (nonatomic,strong) UIView * middleView;
//列表区域
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
//退出登录按钮
@property (nonatomic,strong) UIButton * logOutBtn;


@end

@implementation MyViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.busNavigationBar.hidden = YES;
    [self setUI];
}

#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.middleView];
//    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.logOutBtn];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.equalTo(self.headView.mas_width).multipliedBy(2.0/3.0f);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.headView.mas_bottom).offset(0);
        make.height.offset(70);
    }];
    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.offset(0);
//        make.top.equalTo(self.middleView.mas_bottom).offset(0);
//        make.height.offset(300);
//    }];
//
//    [self.logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.offset(0);
//        make.top.equalTo(self.tableView.mas_bottom).offset(0);
//        make.height.offset(60);
//    }];
    
}

//退出登录响应
-(void)logOutBtnClicked{
    
}

#pragma mark  ----  懒加载
-(UIView *)headView{
    
    if (!_headView) {
        
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor greenColor];
    }
    return _headView;
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
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleView.frame), MAINWIDTH, 60 * 5) style:UITableViewStylePlain];
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
        [_logOutBtn addTarget:self action:@selector(logOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logOutBtn;
}

@end
