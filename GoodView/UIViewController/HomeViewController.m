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
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapServices.h>
#import "ScenicModel.h"
#import "ADModel.h"
#import "SDCycleScrollView.h"
#import "VerticalLoopView.h"
#import "JHArticle.h"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,SDCycleScrollViewDelegate,VerticalLoopDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

//自定义导航
@property (nonatomic,strong) UIView * myNav;
@property (nonatomic,strong) UIView * searchBGView;
//城市按钮
@property (nonatomic,strong) UIButton * cityBtn;
@property (nonatomic,strong) SHSearchBar * searchBar;
//扫码按钮
@property (nonatomic,strong) UIButton * scanBtn;
//轮播区
@property (nonatomic,strong) SDCycleScrollView * carouselScrollView;
//景好头条
@property (nonatomic,strong) UIView * headlineView;
@property (nonatomic,strong) VerticalLoopView * verticalLoopV;
@property (nonatomic,strong) UILabel * newsLabel;
//列表区域
@property (nonatomic,strong) UITableView * tableView;
//景区模型数组
@property (nonatomic,strong) NSMutableArray<ScenicModel *> * dataArray;
//广告模型数组
@property (nonatomic,strong) NSMutableArray<ADModel *> * adModelArray;
//景好头条模型数组
@property (nonatomic,strong) NSMutableArray<JHArticle *> * toutiaoModelArray;


@end

@implementation HomeViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.busNavigationBar.hidden = YES;
    [self startPositioning];
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

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self.verticalLoopV stop];
}

-(void)dealloc{
    
    [self cleanUpAction];
    
    self.completionBlock = nil;
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
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"ScenicSpotCell";
    ScenicSpotCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {

        cell = [[ScenicSpotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ScenicModel * model = self.dataArray[indexPath.row];
    [cell setImage:[[NSString alloc] initWithFormat:@"%@%@",KIMGURL,model.scenic_img] scenicName:model.scenic_name scenicContent:model.scenics_text listen:model.listen_num distance:model.distance];
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


#pragma mark  ----  VerticalLoopDelegate
- (void)didClickContentAtIndex:(NSInteger)index{
    
}


#pragma mark  ----  SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

#pragma mark  ----  自定义函数
//开始定位
-(void)startPositioning{
    
    [AMapServices sharedServices].apiKey = @"8753cfe1293deef38267201416d77a19";
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    [self initCompleteBlock];
    [self reGeocodeAction];
}

- (void)initCompleteBlock
{
    __weak HomeViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
        //修改label显示内容
        if (regeocode)
        {
            [AccountManager sharedManager].city = regeocode.city;
            [AccountManager sharedManager].longitude = location.coordinate.longitude;
            [AccountManager sharedManager].latitude = location.coordinate.latitude;
            
            UIButton * cityBtn = [weakSelf.searchBGView viewWithTag:1200];
            [cityBtn setTitle:regeocode.city forState:UIControlStateNormal];
            NSLog(@"%@",[NSString stringWithFormat:@"%@ \n %@-%@-%.2fm", regeocode.formattedAddress,regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]);
            [weakSelf loadHomeData];
        }
        else
        {
            NSLog(@"%@",[NSString stringWithFormat:@"lat:%f;lon:%f \n accuracy:%.2fm", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy]);
        }
    };
}

- (void)reGeocodeAction
{
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
}

//获取首页数据
-(void)loadHomeData{
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KGENURL]];
    [manager POST:@"Scenic/home" parameters:@{@"number":@"0",@"city":@"杭州市",@"latitude":[NSNumber numberWithFloat:[AccountManager sharedManager].latitude],@"longitude":[NSNumber numberWithFloat:[AccountManager sharedManager].longitude],@"user_id":@""} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber * status = responseObject[@"status"];
        if (status.integerValue == 1) {
            
            NSDictionary * dataDic = responseObject[@"result"];
            NSArray * scenicsArray = dataDic[@"scenics"];
            for (NSUInteger i = 0; i < scenicsArray.count; i++) {
                
                NSDictionary * dic = scenicsArray[i];
                NSError * error;
                ScenicModel * model = [[ScenicModel alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.dataArray addObject:model];
                }
            }
            [self.tableView reloadData];
            
            NSArray * adArray = dataDic[@"ad"];
            for (NSUInteger j = 0; j < adArray.count; j++) {
                
                NSDictionary * dic = adArray[j];
                NSError * error;
                ADModel * model = [[ADModel alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.adModelArray addObject:model];
                }
            }
            [self createCarousel];
            
            NSArray * toutiaoArray = dataDic[@"toutiao"];
            for (NSUInteger k = 0; k < toutiaoArray.count; k++) {
                
                NSDictionary * dic = toutiaoArray[k];
                NSError * error;
                JHArticle * model = [[JHArticle alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.toutiaoModelArray addObject:model];
                }
            }
            [self createToutiao];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD showErrorMessage:@"请求失败，请检查网络"];
    }];
}
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

//    [self.view addSubview:self.verticalLoopV];
//    [self.verticalLoopV mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.offset(0);
//        make.top.equalTo(self.carouselScrollView.mas_bottom).offset(0);
//        make.height.offset(40);
//    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.headlineView.mas_bottom).offset(0);
        make.bottom.offset(-49);
    }];
}

//创建轮播区
-(void)createCarousel{
    
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < self.adModelArray.count; i++) {
        
        ADModel * model = self.adModelArray[i];
        [arr addObject:[[NSString alloc] initWithFormat:@"%@%@",KIMGURL,model.ad_code]];
    }
    self.carouselScrollView.imageURLStringsGroup = arr;
}
//创建头条区
-(void)createToutiao{
    
    self.verticalLoopV.verticalLoopContentArr = self.toutiaoModelArray;
    [self.verticalLoopV start];
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
        _cityBtn.tag = 1200;
        [_cityBtn setTitle:@"城市" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(cityBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_cityBtn setImage:[UIImage imageNamed:@"ic_search_bar_arrow_down@2x"] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = FONT15;
        [_cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 58, 0, 0)];
        [_cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
        
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

-(SDCycleScrollView *)carouselScrollView{
    
    if (!_carouselScrollView) {
        
        _carouselScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 0, 0) delegate:self placeholderImage:[UIImage imageNamed:@"default@2x.png"]];
        _carouselScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _carouselScrollView;
}

-(VerticalLoopView *)verticalLoopV{
    
    if (!_verticalLoopV) {
        
        _verticalLoopV = [[VerticalLoopView alloc] initWithFrame:CGRectZero];
        _verticalLoopV.loopDelegate = self;
        _verticalLoopV.is_start = 1;
        _verticalLoopV.backgroundColor = [UIColor whiteColor];
//        _verticalLoopV.verticalLoopContentArr = _articleDataArr;
        _verticalLoopV.verticalLoopAnimationDuration = 1;
        _verticalLoopV.Direction = VerticalLoopDirectionDown;
    }
    return _verticalLoopV;
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
        
        
        [_headlineView addSubview:self.verticalLoopV];
        [self.verticalLoopV mas_makeConstraints:^(MASConstraintMaker *make) {
           
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

-(NSMutableArray<ScenicModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray<ADModel *> *)adModelArray{
    
    if (!_adModelArray) {
        
        _adModelArray = [[NSMutableArray alloc] init];
    }
    return _adModelArray;
}

-(NSMutableArray<JHArticle *> *)toutiaoModelArray{
    
    if (!_toutiaoModelArray) {
        
        _toutiaoModelArray = [[NSMutableArray alloc] init];
    }
    return _toutiaoModelArray;
}

@end
