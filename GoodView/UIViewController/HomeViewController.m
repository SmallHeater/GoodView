//
//  HomeViewController.m
//  GoodView
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "SelectCityViewController.h"
#import "TabbarViewController.h"
#import "SHSearchBar.h"
#import "ScenicSpotCell.h"
#import "QRCodeVC.h"
#import "SelectCityViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

//自定义导航
@property (nonatomic,strong) UIView * myNav;
@property (nonatomic,strong) UIView * searchBGView;
//城市按钮
@property (nonatomic,strong) UIButton * cityBtn;
@property (nonatomic,strong) SHSearchBar * searchBar;
//扫码按钮
@property (nonatomic,strong) UIButton * scanBtn;
//轮播区
@property (nonatomic,strong) UIScrollView * carouselScrollView;
//景好头条
@property (nonatomic,strong) UIView * headlineView;
@property (nonatomic,strong) UILabel * newsLabel;
//列表区域
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;


@end

@implementation HomeViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.busNavigationBar.hidden = YES;
    [self setUI];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
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
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"ScenicSpotCell";
    ScenicSpotCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {

        cell = [[ScenicSpotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uu@2x.png"]];
    imageView.frame = CGRectMake(10, 12, 26, 26);
    [view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 30)];
    label.text = @"附近景区";
    [view addSubview:label];
    
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, MAINWIDTH, 1)];
    lineLabel.backgroundColor = Color_F5F5F5;
    [view addSubview:lineLabel];
    return view;
}



#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.view addSubview:self.myNav];
    [self.myNav mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.offset(0);
        make.height.offset(64);
    }];
    
    [self.searchBGView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(20);
        make.top.offset(30);
        make.right.offset(-55);
        make.height.offset(30);
    }];
    
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.offset(0);
        make.width.offset(70);
    }];
    
    [self.scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.offset(25);
        make.bottom.offset(-6);
        make.right.offset(-15);
    }];
    
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.cityBtn.mas_right).offset(0);
        make.top.right.bottom.offset(0);
    }];
    
    [self.view addSubview:self.carouselScrollView];
    [self.carouselScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.myNav.mas_bottom).offset(0);
        make.height.equalTo(self.carouselScrollView.mas_width).multipliedBy(335.0/750.0f);
    }];
    
    [self.view addSubview:self.headlineView];
    [self.headlineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.carouselScrollView.mas_bottom).offset(0);
        make.height.offset(40);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.headlineView.mas_bottom).offset(0);
        make.bottom.offset(-49);
    }];
}

//城市按钮的响应
-(void)cityBtnClicked{
    
    SelectCityViewController * vc = [[SelectCityViewController alloc] initWithTitle:@"选择城市" locationCity:@"杭州"];
    [self.navigationController pushViewController:vc animated:NO];
}

//扫一扫按钮的响应
-(void)scanBtnClicked{
    
    QRCodeVC * vc = [[QRCodeVC alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark  ----  懒加载
-(UIView *)myNav{
    
    if (!_myNav) {
        
        _myNav = [[UIView alloc] init];
        _myNav.backgroundColor = Color_1FBF9A;
        
        [_myNav addSubview:self.searchBGView];
        [_myNav addSubview:self.scanBtn];
    }
    return _myNav;
}

-(UIView *)searchBGView{
    
    if (!_searchBGView) {
        
        _searchBGView = [[UIView alloc] init];
        _searchBGView.backgroundColor = [UIColor whiteColor];
        _searchBGView.layer.cornerRadius = 4;
        [_searchBGView addSubview:self.cityBtn];
        [_searchBGView addSubview:self.searchBar];
    }
    return _searchBGView;
}

-(UIButton *)cityBtn{
    
    if (!_cityBtn) {
        
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn setTitle:@"北京" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(cityBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_cityBtn setImage:[UIImage imageNamed:@"ic_search_bar_arrow_down@2x"] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = FONT15;
        [_cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        [_cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
        
        CALayer * rightLayer = [CALayer layer];
        rightLayer.frame = CGRectMake(69, 5, 1, 20);
        rightLayer.backgroundColor = Color_F5F5F5.CGColor;
        [_cityBtn.layer addSublayer:rightLayer];
    }
    return _cityBtn;
}

-(SHSearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[SHSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andPlaceholder:@"请输入景区或者目的地"];
    }
    return _searchBar;
}

-(UIButton *)scanBtn{
    
    if (!_scanBtn) {
        
        _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scanBtn setImage:[UIImage imageNamed:@"scaning@2x.png"] forState:UIControlStateNormal];
        [_scanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_scanBtn addTarget:self action:@selector(scanBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanBtn;
}

-(UIScrollView *)carouselScrollView{
    
    if (!_carouselScrollView) {
        
        _carouselScrollView = [[UIScrollView alloc] init];
        _carouselScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _carouselScrollView;
}

-(UIView *)headlineView{
    
    if (!_headlineView) {
        
        _headlineView = [[UIView alloc] init];
        _headlineView.backgroundColor = [UIColor grayColor];
        
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headline@2x.jpg"]];
        imageView.backgroundColor = [UIColor greenColor];
        [_headlineView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.bottom.offset(0);
            make.width.offset(100);
        }];
        
        CALayer * rightLayer = [CALayer layer];
        rightLayer.frame = CGRectMake(99, 0, 1, 39);
        rightLayer.backgroundColor = Color_F5F5F5.CGColor;
        [imageView.layer addSublayer:rightLayer];
        
        
        [_headlineView addSubview:self.newsLabel];
        [self.newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(imageView.mas_right).offset(0);
            make.top.right.bottom.offset(0);
        }];
        
        CALayer * bottomLayer = [CALayer layer];
        bottomLayer.frame = CGRectMake(0, 39, MAINWIDTH, 1);
        bottomLayer.backgroundColor = Color_F5F5F5.CGColor;
        [_headlineView.layer addSublayer:bottomLayer];
    }
    return _headlineView;
}

-(UILabel *)newsLabel{
    
    if (!_newsLabel) {
        
        _newsLabel = [[UILabel alloc] init];
        _newsLabel.backgroundColor = [UIColor whiteColor];
    }
    return _newsLabel;
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
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
