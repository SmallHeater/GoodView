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

@end