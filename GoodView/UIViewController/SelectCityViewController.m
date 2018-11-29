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
#import "CityModel.h"


typedef NS_ENUM(NSUInteger,TableViewType){
    
    TableViewType_list = 0,//列表展示tableView
    TableViewType_search//搜索数据展示tableView
};

@interface SelectCityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) SHSearchBar * searchBar;
//列表区域
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UIView * tableHeaderView;
//热门城市数组
@property (nonatomic,strong) NSMutableArray * hotCitysArray;
//定位城市模型
@property (nonatomic,strong) CityModel * locationCityModel;
//存储所有数据模型的数组，搜索用
@property (nonatomic,strong) NSMutableArray<CityModel *> * modelsArray;
//存储搜索到的城市的模型数组
@property (nonatomic,strong) NSMutableArray<CityModel *> * searchedModelArray;
@property (nonatomic,assign) TableViewType tableViewType;


@end

@implementation SelectCityViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)navTitle locationCity:(NSString *)locationCity{
    
    self = [super initWithTitle:navTitle];
    if (self) {
        
        self.tableViewType = TableViewType_list;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            for (NSDictionary * dic in self.dataArray) {
                
                NSArray * modelsArray = dic[@"citysModel"];
                for (CityModel * model in modelsArray) {
                    
                    if ([model.city_name isEqualToString:locationCity] || [model.short_name isEqualToString:locationCity]) {
                        
                        self.locationCityModel = model;
                        dispatch_async(dispatch_get_main_queue(), ^{
                           
                            UIButton * btn = [self.tableHeaderView viewWithTag:1111];
                            [btn setTitle:model.city_name forState:UIControlStateNormal];
                        });
                        break;
                    }
                }
            }
        });
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
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
    
    if (self.tableViewType == TableViewType_list) {
        
        NSDictionary * dic = self.dataArray[indexPath.section];
        NSArray * cityModelsArray = dic[@"citysModel"];
        CityModel * model = cityModelsArray[indexPath.row];
        if (self.city) {
            
            self.city(model.city_name);
        }
    }
    else if (self.tableViewType == TableViewType_search){
        
        CityModel * model = self.searchedModelArray[indexPath.row];
        if (self.city) {
            
            self.city(model.city_name);
        }
    }
    [self backBtnClicked:nil];
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.tableViewType == TableViewType_list) {
        
        NSDictionary * dic = self.dataArray[section];
        NSArray * cityModelsArray = dic[@"citysModel"];
        return cityModelsArray.count;
    }
    else if (self.tableViewType == TableViewType_search){
        
        return self.searchedModelArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"CityCell";
    CityCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.tableViewType == TableViewType_list) {
        
        NSDictionary * dic = self.dataArray[indexPath.section];
        NSArray * cityModelsArray = dic[@"citysModel"];
        CityModel * model = cityModelsArray[indexPath.row];
        [cell setCity:model.city_name];
    }
    else if (self.tableViewType == TableViewType_search){
        
        CityModel * model = self.searchedModelArray[indexPath.row];
        [cell setCity:model.city_name];
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.tableViewType == TableViewType_list) {
        
        return self.dataArray.count;
    }
    else if (self.tableViewType == TableViewType_search){
        
        return 1;
    }
    return 0;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (self.tableViewType == TableViewType_list) {
        
        NSDictionary * dic = self.dataArray[section];
        return dic[@"initial"];
    }
    else if (self.tableViewType == TableViewType_search){
        
    }
    return @"";
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    if (self.tableViewType == TableViewType_list) {
        
        for (NSUInteger i = 0; i < self.dataArray.count; i++) {
            
            NSDictionary * dic = self.dataArray[i];
            [array addObject:dic[@"initial"]];
        }
    }
    else if (self.tableViewType == TableViewType_search){
        
    }
    
    return array;
}

#pragma mark  ----  UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([NSString contentIsNullORNil:string] && range.location == 0) {
        
        //搜索输入框删完了
        [self search:@""];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self search:textField.text];
    return YES;
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
-(void)locationBtnClicked:(UIButton *)btn{
    
    if (self.city) {
        
        self.city(self.locationCityModel.city_name);
    }
    [self backBtnClicked:nil];
}

//热门城市的响应
-(void)btnClicked:(UIButton *)hotBtn{
    
    NSUInteger index = hotBtn.tag - 1300;
    CityModel * model = self.hotCitysArray[index];
    if (self.city) {
        
        self.city(model.city_name);
    }
    [self backBtnClicked:nil];
}

//搜索
-(void)search:(NSString *)text{
    
    if (![NSString contentIsNullORNil:text]) {
        
        [self.searchedModelArray removeAllObjects];
        NSString *subString=[text substringWithRange:NSMakeRange(0, 1)];
        const char *cString=[subString UTF8String];
        if (strlen(cString)==3){
            
            //汉字
            for (CityModel * model in self.modelsArray) {
                
                if ([model.city_name rangeOfString:text].location != NSNotFound) {
                    
                    [self.searchedModelArray addObject:model];
                }
            }
            
        }else if(strlen(cString)==1){
            
            //字母
            NSString * lowStr = [text lowercaseString];
            for (CityModel * model in self.modelsArray) {
                
                if ([model.pinyin hasPrefix:lowStr]) {
                    
                    [self.searchedModelArray addObject:model];
                }
            }
        }
        
        self.tableViewType = TableViewType_search;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    else{
        
        [self.searchedModelArray removeAllObjects];
        self.tableViewType = TableViewType_list;
        self.tableView.tableHeaderView = self.tableHeaderView;
    }
    [self.tableView reloadData];
}

#pragma mark  ----  懒加载
-(SHSearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[SHSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andPlaceholder:@"请输入城市名或拼音"];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.layer.cornerRadius = 4;
        _searchBar.delegate = self;
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
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
        for (NSUInteger i = 0; i < array.count; i++) {
            
            NSDictionary * dic = array[i];
            NSMutableDictionary * citysDic = [[NSMutableDictionary alloc] init];
            [citysDic setObject:dic[@"initial"] forKey:@"initial"];
            
            NSArray * cityArray = dic[@"citys"];
            NSMutableArray * cityModelsArray = [[NSMutableArray alloc] init];
            for (NSUInteger j = 0; j < cityArray.count; j++) {
                
                CityModel * model = [[CityModel alloc] initWithDictionary:cityArray[j] error:nil];
                [cityModelsArray addObject:model];
            }
            [citysDic setObject:cityModelsArray forKey:@"citysModel"];
            [_dataArray addObject:citysDic];
        }
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
        locationBtn.tag = 1111;
        locationBtn.frame = CGRectMake(15, CGRectGetMaxY(locationLabel.frame) + 10, 100, 40);
        [locationBtn setBackgroundColor:Color_F5F5F5];
        [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (self.locationCityModel) {
            
            [locationBtn setTitle:self.locationCityModel.city_name forState:UIControlStateNormal];
        }
        else{
            
            [locationBtn setTitle:@"定位中" forState:UIControlStateNormal];
        }
        
        [locationBtn setImage:[UIImage imageNamed:@"location@2x.png"] forState:UIControlStateNormal];
        [locationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 60)];
        [locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [locationBtn addTarget:self action:@selector(locationBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
        
        
        for (NSUInteger i = 0; i < self.hotCitysArray.count; i++) {
            
            CityModel * model = self.hotCitysArray[i];
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 1300 +i;
            [btn setBackgroundColor:Color_F5F5F5];
            btn.frame = CGRectMake(15 + (btnWidth + padding) * (i % 3), CGRectGetMaxY(hotLabel.frame) + 10 + (i / 3) * (40 + 10), 100, 40);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:model.city_name forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_tableHeaderView addSubview:btn];
        }
    }
    return _tableHeaderView;
}

-(NSMutableArray *)hotCitysArray{
    
    if (!_hotCitysArray) {
        
        _hotCitysArray = [[NSMutableArray alloc] init];
        
        //北京
        NSDictionary * firstDic = @{@"city_key":@"100010000",@"city_name":@"北京市",@"initials":@"bj",@"pinyin":@"beijing",@"short_name":@"北京"};
        CityModel * firstModel = [[CityModel alloc] initWithDictionary:firstDic error:nil];
        [_hotCitysArray addObject:firstModel];
        //上海
        NSDictionary * secondDic = @{@"city_key":@"200010000",@"city_name":@"上海市",@"initials":@"sh",@"pinyin":@"shanghai",@"short_name":@"上海"};
        CityModel * secondModel = [[CityModel alloc] initWithDictionary:secondDic error:nil];
        [_hotCitysArray addObject:secondModel];
        //广州
        NSDictionary * thirdDic = @{@"city_key":@"300110000",@"city_name":@"广州市",@"initials":@"gz",@"pinyin":@"guangzhou",@"short_name":@"广州"};
        CityModel * thirdModel = [[CityModel alloc] initWithDictionary:thirdDic error:nil];
        [_hotCitysArray addObject:thirdModel];
        //深圳
        NSDictionary * forthDic = @{@"city_key":@"300210000",@"city_name":@"深圳市",@"initials":@"sz",@"pinyin":@"shenzhen",@"short_name":@"深圳"};
        CityModel * forthModel = [[CityModel alloc] initWithDictionary:forthDic error:nil];
        [_hotCitysArray addObject:forthModel];
        //杭州
        NSDictionary * fifthDic = @{@"city_key":@"600010000",@"city_name":@"杭州市",@"initials":@"hz",@"pinyin":@"hangzhou",@"short_name":@"杭州"};
        CityModel * fifthModel = [[CityModel alloc] initWithDictionary:fifthDic error:nil];
        [_hotCitysArray addObject:fifthModel];
        //南京
        NSDictionary * sixthDic = @{@"city_key":@"700010000",@"city_name":@"南京市",@"initials":@"nj",@"pinyin":@"nanjing",@"short_name":@"南京"};
        CityModel * sixthModel = [[CityModel alloc] initWithDictionary:sixthDic error:nil];
        [_hotCitysArray addObject:sixthModel];
        //天津
        NSDictionary * seventhDic = @{@"city_key":@"500010000",@"city_name":@"天津市",@"initials":@"tj",@"pinyin":@"tianjin",@"short_name":@"天津"};
        CityModel * seventhModel = [[CityModel alloc] initWithDictionary:seventhDic error:nil];
        [_hotCitysArray addObject:seventhModel];
        //武汉
        NSDictionary * eighthDic = @{@"city_key":@"400010000",@"city_name":@"武汉市",@"initials":@"wh",@"pinyin":@"wuhan",@"short_name":@"武汉"};
        CityModel * eighthModel = [[CityModel alloc] initWithDictionary:eighthDic error:nil];
        [_hotCitysArray addObject:eighthModel];
        //重庆
        NSDictionary * ninthDic = @{@"city_key":@"900010000",@"city_name":@"重庆市",@"initials":@"cq",@"pinyin":@"chongqing",@"short_name":@"重庆"};
        CityModel * ninthModel = [[CityModel alloc] initWithDictionary:ninthDic error:nil];
        [_hotCitysArray addObject:ninthModel];
    }
    return _hotCitysArray;
}

-(NSMutableArray<CityModel *> *)modelsArray{
    
    if (!_modelsArray) {
        
        _modelsArray = [[NSMutableArray alloc] init];
        for (NSDictionary * dic in self.dataArray) {
            
            NSArray * cityModelsArray = dic[@"citysModel"];
            for (CityModel * model in cityModelsArray) {
                
                [self.modelsArray addObject:model];
            }
        }
    }
    return _modelsArray;
}

-(NSMutableArray<CityModel *> *)searchedModelArray{
    
    if (!_searchedModelArray) {
        
        _searchedModelArray = [[NSMutableArray alloc] init];
    }
    return _searchedModelArray;
}

@end
