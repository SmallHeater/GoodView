//
//  JHBusinessNavigationBar.h
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/7.
//  Copyright © 2017年 pk. All rights reserved.
//  自定义导航view，绿色背景,带标题，返回按钮

#import <UIKit/UIKit.h>

@interface JHLiveBaseNavigationBar : UIView
//标题
@property (nonatomic,strong) NSString * navTitle;
@property (nonatomic,strong) UIButton * backBtn;



//若使用本view，说明需要显示返回按钮，必须传target和SEL。
-(instancetype)initWithTitle:(NSString *)title andBackbtnAction:(SEL)action andBackBtnTarget:(id)target;


@end
