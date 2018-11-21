//
//  JHPictureSelectionComponent.h
//  JHPictureSelectionComponent
//
//  Created by xianjunwang on 2018/10/16.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  图片选择组件

#import "JHPictureSelectionComponentInitModel.h"

@interface JHPictureSelectionComponent : NSObject

+(void)getImagesWithInitModel:(JHPictureSelectionComponentInitModel *)initModel callBack:(void(^)(NSMutableArray * dataArray))result;

@end
