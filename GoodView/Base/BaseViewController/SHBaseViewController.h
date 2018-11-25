//
//  JHBusAppleBaseViewController.h
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/7.
//  Copyright © 2017年 pk. All rights reserved.
//  Base ViewController,带导航

#import "JHLiveBaseNavigationBar.h"
//#import "JHStoreListNoDataView.h"
#import "JHLiveAdaptUI.h"


@interface SHBaseViewController : UIViewController

@property (nonatomic,strong) JHLiveBaseNavigationBar * busNavigationBar;
@property (nonatomic,strong) NSString * navTitle;

//暂无数据view
//@property (nonatomic,strong) JHStoreListNoDataView * noDataView;
//无网效果的背景view
@property (nonatomic,strong) UIView * noInternetBGView;

//实例化方法
-(instancetype)initWithTitle:(NSString *)navTitle;

- (void)backBtnClicked:(UIButton *)btn;

@end
