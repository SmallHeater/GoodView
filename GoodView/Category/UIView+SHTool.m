//
//  UIView+SHTool.m
//  GoodView
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 mac. All rights reserved.
//

#import "UIView+SHTool.h"

@implementation UIView (SHTool)

/**
 *  返回当前视图的控制器
 */
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
