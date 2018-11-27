//
//  CarouselCell.h
//  GoodView
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 mac. All rights reserved.
//  首页轮播cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ADModel;

@interface CarouselCell : UITableViewCell

//设置轮播区数据
-(void)setCarouselData:(NSMutableArray<ADModel *> *)array;

@end

NS_ASSUME_NONNULL_END
