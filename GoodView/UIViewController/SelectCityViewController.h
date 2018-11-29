//
//  SelectCityViewController.h
//  GoodView
//
//  Created by xianjunwang on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//  选择城市页面

#import "SHBaseViewController.h"

typedef void(^SelectedCity)(NSString * city);

@interface SelectCityViewController : SHBaseViewController

//选中城市的回调
@property (nonatomic,copy) SelectedCity city;

//定位城市
-(instancetype)initWithTitle:(NSString *)navTitle locationCity:(NSString *)locationCity;

@end
