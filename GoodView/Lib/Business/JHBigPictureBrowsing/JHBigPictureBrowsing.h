//
//  JHBigPictureBrowsing.h
//  JHBigPictureBrowsing
//
//  Created by xianjunwang on 2018/3/30.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  大图浏览器

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JHBigPictureBrowsing : NSObject

//展示大图浏览view
+(void)showViewWithArray:(NSMutableArray *)array andSelectedIndex:(NSUInteger)index;

@end
