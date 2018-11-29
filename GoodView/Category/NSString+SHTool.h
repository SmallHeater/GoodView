//
//  NSString+SHTool.h
//  GoodView
//
//  Created by xianjunwang on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//  小暖风的NSString扩展类

#import <Foundation/Foundation.h>

@interface NSString (SHTool)

/**
 *  非空判断
 *
 *  @return 空 为 YES , 非空 NO
 */
- (BOOL)isEmpty;

+ (BOOL)contentIsNullORNil:(NSString *)content;


/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param height 指定高度
 *
 *  @return 计算好的宽度
 */
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font inHeight:(CGFloat)height;

/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param width 指定宽度
 *
 *  @return 计算好的高度
 */
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font inWidth:(CGFloat)width;


@end
