//
//  UIColor+SHTool.h
//  GoodView
//
//  Created by xianjunwang on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//  小暖风的UIColor扩展类

#import <UIKit/UIKit.h>

@interface UIColor (SHTool)

+(UIColor *)colorFromHexRGB:(NSString *)inColorString alpha:(float)alpha;

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end
