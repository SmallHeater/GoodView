//
//  JHBusAppleBaseViewController.m
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/7.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "JHLiveBaseViewController.h"
//#import "UIColor+Translate.h"
//#import "JHRoutingComponent.h"


@interface JHLiveBaseViewController ()

@end

@implementation JHLiveBaseViewController


#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)navTitle{
    
    self = [self init];
    if (self) {
        
        if (navTitle) {
            
            self.busNavigationBar.navTitle = navTitle;
        }
        else{
            
            self.busNavigationBar.navTitle = @"";
        }
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorFromHexRGB:@"F5F5F5"];
    [self.view addSubview:self.busNavigationBar];
    
    NSString * lastInitClassName = NSStringFromClass([self class]);
    if (lastInitClassName && lastInitClassName.length > 0){
        
        //最后实例化的类
        [[NSUserDefaults standardUserDefaults] setValue:lastInitClassName forKey:@"LASTINITCLASS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
    

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    NSString * className = NSStringFromClass([self class]);
    if (className && [className isKindOfClass:[NSString class]] && className.length > 0){
        
        //最后展示的页面
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:className forKey:@"SHOWINGCLASSNAME"];
        [defaults synchronize];
  
//        [JHRoutingComponent openURL:SHOWPAGEVIEW withParameter:@{@"pageName":className}];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    NSString * className = NSStringFromClass([self class]);
//    [JHRoutingComponent openURL:GOAWAYPAGEVIEW withParameter:@{@"pageName":className}];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSString * className = NSStringFromClass([self class]);
    //收到内存警告的页面
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:className forKey:@"MEMORYWARNINGCLASSNAME"];
    [defaults synchronize];
}

#pragma mark  ----  自定义函数
-(void)backBtnClicked:(UIButton *)btn{

    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark  ----  SET
-(void)setNavTitle:(NSString *)navTitle{

    _navTitle = navTitle;
    self.busNavigationBar.navTitle = navTitle;
}

#pragma mark  ----  懒加载
-(JHLiveBaseNavigationBar *)busNavigationBar{

    if (!_busNavigationBar) {
        
        _busNavigationBar = [[JHLiveBaseNavigationBar alloc] initWithTitle:@"" andBackbtnAction:@selector(backBtnClicked:) andBackBtnTarget:self];
    }
    return _busNavigationBar;
}

/*
-(JHStoreListNoDataView *)noDataView{
    
    if (!_noDataView) {
        
        _noDataView = [[JHStoreListNoDataView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.busNavigationBar.frame), MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.busNavigationBar.frame) - [JHLiveAdaptUI heightOfEmptyBottom])];
    }
    return _noDataView;
}

-(UIView *)noInternetBGView{
    
    if (!_noInternetBGView) {
        
        _noInternetBGView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.busNavigationBar.frame), MAINWIDTH, MAINHEIGHT - CGRectGetMaxY(self.busNavigationBar.frame) - [JHLiveAdaptUI heightOfEmptyBottom])];
    }
    return _noInternetBGView;
}
 */
@end
