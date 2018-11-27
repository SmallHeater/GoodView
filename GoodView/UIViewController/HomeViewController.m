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
#import "CarouselCell.h"
#import "JHToutiaoCell.h"
#import "NearScenicHeadCell.h"

#import "JHArticle.h"
#import "WKWebViewController.h"



#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate,UITextFieldDelegate>

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


@property (nonatomic,strong) UILabel * newsLabel;
//列表区域
//@property (nonatomic,strong) UITableView * tableView;
//当前景区数量，第一次是0
@property (nonatomic,strong) NSString * scenicNumber;
//景区模型数组
//@property (nonatomic,strong) NSMutableArray<ScenicModel *> * dataArray;
//广告模型数组
@property (nonatomic,strong) NSMutableArray<ADModel *> * adModelArray;
//景好头条模型数组
@property (nonatomic,strong) NSMutableArray<JHArticle *> * toutiaoModelArray;
//滑动是否已松手 (松手之后，不去触发上拉或者下拉)
@property (nonatomic,assign) BOOL hadEndDrag;
//是否已触发上拉加载下拉刷新
@property (nonatomic,assign) BOOL hadLoadMore;
@property (nonatomic,assign) float lastContentY;
//是否还需要加载更多（无更多数据后，置为NO）
@property (nonatomic,assign) BOOL needLoadMore;
@end

@implementation HomeViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.busNavigationBar.hidden = YES;
    self.scenicNumber = @"0";
    self.needLoadMore = YES;
    [self startPositioning];
    [self setUI];
    
    NSLog(@"宽高：%ld,%ld",(long)MAINWIDTH,(long)MAINHEIGHT);
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
}

-(void)dealloc{
    
    [self cleanUpAction];
    self.completionBlock = nil;
}

#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //轮播区高度
        return MAINWIDTH * 335.0/750.0;
    }
    else if (indexPath.row == 1){
        
        //头条区高度
        return 40;
    }
    else if (indexPath.row == 2){
        
        //附近景区高度
        return 50;
    }
    else{
        
        //景区cell高度
        return 100;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString * firstCellID = @"CarouselCell";
        CarouselCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellID];
        if (!cell) {
            
            cell = [[CarouselCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setCarouselData:self.adModelArray];
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString * secondCellID = @"CarouselCell";
        JHToutiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
        if (!cell) {
            
            cell = [[JHToutiaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setToutiaoData:self.toutiaoModelArray];
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString * thirdCellID = @"NearScenicHeadCell";
        NearScenicHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellID];
        if (!cell) {
            
            cell = [[NearScenicHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else{
        
        static NSString * forthCellID = @"ScenicSpotCell";
        ScenicSpotCell * cell = [tableView dequeueReusableCellWithIdentifier:forthCellID];
        if (!cell) {
            
            cell = [[ScenicSpotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forthCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        ScenicModel * model = self.dataArray[indexPath.row - 3];
        [cell setImage:[[NSString alloc] initWithFormat:@"%@%@",KIMGURL,model.scenic_img] scenicName:model.scenic_name scenicContent:model.scenics_text listen:model.listen_num distance:model.km];
        return cell;
    }
}

#pragma mark  ----  UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.hadEndDrag = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint contentOffset = scrollView.contentOffset;
    if (!self.hadEndDrag) {
        if (!self.hadLoadMore) {
            CGSize contentSize = scrollView.contentSize;
            //未显示的tableView高度
            float remainingHeight = contentSize.height - contentOffset.y - 100 * 3;
            if (contentOffset.y > 0 && contentOffset.y - self.lastContentY > 0) {
                //大于0，才是上拉；小于0，是下拉
                if (contentSize.height < MAINHEIGHT) {
                    //显示数据不到一屏，无加载更多功能
                }
                else
                {
                    if (remainingHeight < MAINHEIGHT * 2) {
                        if (!self.needLoadMore) {
                            
                            [MBProgressHUD showErrorMessage:@"无更多数据！"];
                        }
                        else{
    
                            self.hadLoadMore = YES;
                            [self loadHomeData];
                        }
                    }
                }
            }
        }
    }
    self.lastContentY = contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.hadEndDrag = YES;
}

#pragma mark  ----  UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
    [manager POST:@"Scenic/home" parameters:@{@"number":self.scenicNumber,@"city":@"杭州市",@"latitude":[NSNumber numberWithFloat:[AccountManager sharedManager].latitude],@"longitude":[NSNumber numberWithFloat:[AccountManager sharedManager].longitude],@"user_id":@""} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber * status = responseObject[@"status"];
        if (status.integerValue == 1) {
            
            self.hadLoadMore = NO;
            NSDictionary * dataDic = responseObject[@"result"];
            NSArray * scenicsArray = dataDic[@"scenics"];
            if (scenicsArray.count == 0) {
                
                self.needLoadMore = NO;
            }
            
            NSArray * adArray = dataDic[@"ad"];
            [self.adModelArray removeAllObjects];
            for (NSUInteger j = 0; j < adArray.count; j++) {
                
                NSDictionary * dic = adArray[j];
                NSError * error;
                ADModel * model = [[ADModel alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.adModelArray addObject:model];
                }
            }
            
            
            [self.toutiaoModelArray removeAllObjects];
            NSArray * toutiaoArray = dataDic[@"toutiao"];
            for (NSUInteger k = 0; k < toutiaoArray.count; k++) {
                
                NSDictionary * dic = toutiaoArray[k];
                NSError * error;
                JHArticle * model = [[JHArticle alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.toutiaoModelArray addObject:model];
                }
            }
            
            for (NSUInteger i = 0; i < scenicsArray.count; i++) {
                
                NSDictionary * dic = scenicsArray[i];
                NSError * error;
                ScenicModel * model = [[ScenicModel alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.dataArray addObject:model];
                }
            }
            
            self.scenicNumber = [[NSString alloc] initWithFormat:@"%ld",self.dataArray.count];
            [self.tableView reloadData];
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
        make.width.offset(75);
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
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.myNav.mas_bottom).offset(0);
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
        _cityBtn.tag = 1200;
        [_cityBtn setTitle:@"城市" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityBtn addTarget:self action:@selector(cityBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_cityBtn setImage:[UIImage imageNamed:@"ic_search_bar_arrow_down@2x"] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = FONT15;
        [_cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 61, 0, 0)];
        [_cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        
        CALayer * rightLayer = [CALayer layer];
        rightLayer.frame = CGRectMake(74, 5, 1, 20);
        rightLayer.backgroundColor = Color_F5F5F5.CGColor;
        [_cityBtn.layer addSublayer:rightLayer];
    }
    return _cityBtn;
}

-(SHSearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[SHSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andPlaceholder:@"请输入景区或者目的地"];
        _searchBar.delegate = self;
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
