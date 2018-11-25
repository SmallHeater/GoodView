//
//  NSString+SHTool.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NSString+SHTool.h"

@implementation NSString (SHTool)


/**
 *  非空判断
 *
 *  @return 空 为 YES , 非空 NO
 */
- (BOOL)isEmpty {
    
    
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}


+ (BOOL)contentIsNullORNil:(NSString *)content
{
    if ([content isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([content isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([content isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

@end
