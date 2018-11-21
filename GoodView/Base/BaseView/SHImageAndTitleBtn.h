//
//  ImageAndTitleBtn.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//  Copyright © 2018年 pk. All rights reserved.
//  图片，文字的按钮

#import <UIKit/UIKit.h>

@interface SHImageAndTitleBtn : UIControl

-(instancetype)initWithFrame:(CGRect)frame andImageFrame:(CGRect)imageFrame andTitleFrame:(CGRect)titleFrame andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName andTitle:(NSString *)title andTarget:(id)target andAction:(SEL)action;
//只支持UIControlStateNormal和UIControlStateSelected
- (void)setTitle:(NSString *)title forState:(UIControlState)state;
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

//刷新文字和色值
-(void)refreshTitle:(NSString *)title color:(UIColor *)textColor;

@end
