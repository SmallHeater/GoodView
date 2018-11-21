//
//  LabelAndLabelView.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/26.
//  Copyright © 2018年 pk. All rights reserved.
//  两个label的view。默认，firstLabel,font:15,textColor:Color_333333;secondLabel,font:14,textColor:Color_ADADAD。

#import <UIKit/UIKit.h>

@interface SHLabelAndLabelView : UIView


//若传入的text为nil,则不显示对应的label
-(instancetype)initWithFrame:(CGRect)frame andFirstLabelFrame:(CGRect)firstLabelFrame andSecondLabelFrame:(CGRect)secondLabelFrame andFirstLabelText:(NSString * )firstLabelText andSecondLabelText:(NSString *)secondLabelText;

//刷新两个label的显示内容,若传入参数为nil,则不刷新对应的label
-(void)refreshFirstLabelText:(NSString *)firstLabelText secondLabelText:(NSString *)secondLabelText;

//刷新label的样式
-(void)refreshFirstLabelFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

-(void)refreshSecondLabelFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

//给label添加事件
-(void)firstLabelAddTarget:(id)target andAction:(SEL)action;
-(void)secondLabelAddTarget:(id)target andAction:(SEL)action;

@end
