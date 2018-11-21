//
//  JHEncryptionComponent.h
//  JHEncryptionComponent
//
//  Created by xianjunwang on 2018/10/28.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  加密组件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//加密类型
typedef NS_ENUM(NSUInteger,EncryptionType){
    
    //图片水印加密
    EncryptionType_ImageWatermark = 0
};


@interface JHEncryptionComponent : NSObject

//图片添加文字水印
+(UIImage *)watermarkEncryptionImage:(UIImage *)image andText:(NSString *)text;

@end
