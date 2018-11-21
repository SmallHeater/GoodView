//
//  JHLiveAdaptUI.m
//  JHLivePlayLibrary
//
//  Created by pk on 2017/12/22.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "JHLiveAdaptUI.h"

@implementation JHLiveAdaptUI

+ (BOOL)isPhoneX{
    CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
    BOOL isIphoneX = CGRectGetHeight(statusFrame) > 20 ? YES : NO;
    return isIphoneX;
}

+ (CGFloat)heightOfLiuHai{
    CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
    CGFloat isIphoneX = CGRectGetHeight(statusFrame) > 20 ? YES : NO;
    CGFloat height = isIphoneX ? CGRectGetHeight(statusFrame) - 20 : 0;
    return height;
}

+ (CGFloat)heightOfEmptyBottom{
    
    if ([self isPhoneX]) {
        
        return 34;
    }
    else{
        
        return 0;
    }
}

+ (CGFloat)heightOfStatusBarFrame{
    CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
    return CGRectGetHeight(statusFrame);
}

+ (CGFloat)heightOfTabbar{
    if ([self isPhoneX]) {
        return 34 + 49;
    }
    return 49.0;
}

+ (CGFloat)heightOfNavigationBar{
    CGFloat naviBar = [self heightOfStatusBarFrame] + 44;
    return naviBar;
}
@end
