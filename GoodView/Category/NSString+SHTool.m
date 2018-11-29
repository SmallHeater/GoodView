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

/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param height 指定高度
 *
 *  @return 计算好的宽度
 */
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font inHeight:(CGFloat)height{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize= [text boundingRectWithSize: CGSizeMake(MAXFLOAT, height)
                                         options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
    return labelSize.width;
}

/**
 *  获取文本的显示宽度
 *
 *  @param text 文本
 *  @param font 字体
 *  @param width 指定宽度
 *
 *  @return 计算好的高度
 */
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font inWidth:(CGFloat)width{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize= [text boundingRectWithSize: CGSizeMake(width, MAXFLOAT)
                                         options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
    return labelSize.height;
}

@end
