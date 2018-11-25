//
//  TabbarViewController.m
//  GoodView
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 mac. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "MyViewController.h"

#import "SHImageAndTitleBtn.h"

@interface TabbarViewController ()

//自定义UITabbar
@property (nonatomic,strong) UIView * tabbarView;

@end

@implementation TabbarViewController


#pragma mark  ----  生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.hidden = YES;
    [self.view addSubview:self.tabbarView];
    
    HomeViewController * homeVC = [[HomeViewController alloc] initWithTitle:@"首页"];
    MyViewController * myVC = [[MyViewController alloc] initWithTitle:@"我的"];
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController * myNav = [[UINavigationController alloc] initWithRootViewController:myVC];
    
    self.viewControllers = @[homeNav,myNav];
    self.selectedIndex = 0;
    SHImageAndTitleBtn * homeBtn = [self.tabbarView viewWithTag:1100];
    homeBtn.selected = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}


#pragma mark  ----  自定义函数

//首页,我的按钮的响应
-(void)buttonClicked:(UIButton *)btn{
    
    btn.selected = YES;
    
    if (btn.tag == 1100) {
        
        SHImageAndTitleBtn * myBtn = [self.tabbarView viewWithTag:1101];
        myBtn.selected = NO;
        self.selectedIndex = 0;
    }
    else if (btn.tag == 1101){
        
        SHImageAndTitleBtn * homeBtn = [self.tabbarView viewWithTag:1100];
        homeBtn.selected = NO;
        self.selectedIndex = 1;
    }
}

//隐藏自定义tabbar
-(void)hidTabbar{
    
    self.tabbarView.hidden = YES;
}
//显示自定义tabbar
-(void)showTabbar{
    
    self.tabbarView.hidden = NO;
}

    
#pragma mark  ----  系统函数




#pragma mark  ----  懒加载
-(UIView *)tabbarView{
    
    if (!_tabbarView) {
        
        //button宽
        float btnWidth = MAINWIDTH / 2;
        //button高
        float btnHeight = 49;
        //图片宽，高
        float imageWidth = 25;
        _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, MAINHEIGHT - btnHeight, MAINWIDTH, btnHeight)];
        
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, MAINWIDTH, 1);
        layer.backgroundColor = Color_F5F5F5.CGColor;
        [_tabbarView.layer addSublayer:layer];
        
        _tabbarView.backgroundColor = [UIColor whiteColor];
        SHImageAndTitleBtn * homeBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(0, 0, btnWidth, CGRectGetHeight(_tabbarView.frame)) andImageFrame:CGRectMake((btnWidth - imageWidth) / 2, 5, imageWidth, imageWidth) andTitleFrame:CGRectMake(0, imageWidth + 5, btnWidth, btnHeight - imageWidth - 5) andImageName:@"home_black@2x.png" andSelectedImageName:@"home_green@2x.png" andTitle:@"首页" andTarget:self andAction:@selector(buttonClicked:)];
        homeBtn.tag = 1100;
        [homeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [homeBtn setTitleColor:Color_1FBF9A forState:UIControlStateSelected];
        [_tabbarView addSubview:homeBtn];
        
        
        SHImageAndTitleBtn * myBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake(CGRectGetMaxX(homeBtn.frame), 0, btnWidth, CGRectGetHeight(_tabbarView.frame)) andImageFrame:CGRectMake((btnWidth - imageWidth) / 2, 5,imageWidth, imageWidth) andTitleFrame:CGRectMake(0, imageWidth + 5, btnWidth, btnHeight - imageWidth - 5) andImageName:@"me_black@2x.png" andSelectedImageName:@"me_green@2x.png" andTitle:@"我的" andTarget:self andAction:@selector(buttonClicked:)];
        myBtn.tag = 1101;
        [myBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [myBtn setTitleColor:Color_1FBF9A forState:UIControlStateSelected];
        [_tabbarView addSubview:myBtn];
    }
    return _tabbarView;
}


@end
