//
//  SelectCityViewController.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SelectCityViewController.h"
#import "SHSearchBar.h"
#import "CityCell.h"

@interface SelectCityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SHSearchBar * searchBar;
//列表区域
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UIView * tableHeaderView;


@end

@implementation SelectCityViewController

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
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"CityCell";
    CityCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setCity:@"北京"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"A";
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return @[@"A",@"B",@"C",@"D",@"E",@"F"];
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(10);
        make.top.equalTo(self.busNavigationBar.mas_bottom).offset(10);
        make.right.offset(-15);
        make.height.offset(30);
    }];
   
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.right.offset(0);
        make.top.equalTo(self.busNavigationBar.mas_bottom).offset(50);
        make.bottom.offset(0);
    }];
}

//定位城市的响应
-(void)locationBtnClicked{
    
}

//热门城市的响应
-(void)btnClicked:(UIButton *)hotBtn{
    
}

#pragma mark  ----  懒加载
-(SHSearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[SHSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andPlaceholder:@"请输入城市名或拼音"];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.layer.cornerRadius = 4;
    }
    return _searchBar;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeaderView;
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

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(UIView *)tableHeaderView{
    
    if (!_tableHeaderView) {
        
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 300)];
        //定位城市
        UILabel * locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 15)];
        locationLabel.font = FONT15;
        locationLabel.text = @"定位城市";
        [_tableHeaderView addSubview:locationLabel];
        
        UIButton * locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        locationBtn.frame = CGRectMake(15, CGRectGetMaxY(locationLabel.frame) + 10, 100, 40);
        [locationBtn setBackgroundColor:Color_F5F5F5];
        [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [locationBtn setTitle:@"北京市" forState:UIControlStateNormal];
        [locationBtn addTarget:self action:@selector(locationBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_tableHeaderView addSubview:locationBtn];
        
        //热门城市
        UILabel * hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(locationBtn.frame) + 20, 200, 15)];
        hotLabel.font = FONT15;
        hotLabel.text = @"热门城市";
        [_tableHeaderView addSubview:hotLabel];
        
        //间距
        NSUInteger padding = 10;
        //按钮宽度
        float btnWidth = (MAINWIDTH - 15 * 2 - 10 * 2) / 3;
        
        for (NSUInteger i = 0; i < 9; i++) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:Color_F5F5F5];
            btn.frame = CGRectMake(15 + (btnWidth + padding) * (i % 3), CGRectGetMaxY(hotLabel.frame) + 10 + (i / 3) * (40 + 10), 100, 40);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:@"北京市" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_tableHeaderView addSubview:btn];
        }
    }
    return _tableHeaderView;
}

@end
