//
//  MyOrderCell.h
//  GoodView
//
//  Created by mac on 2018/11/25.
//  Copyright © 2018 mac. All rights reserved.
//  我的订单cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderCell : UITableViewCell

//设置景区图片，景区名，是否支付，价格，支付方式，购买时间
-(void)setIcon:(NSString *)iconUrlStr scenicName:(NSString *)scenicName isPay:(NSString *)isPay price:(NSString *)price payType:(NSString *)type buyTime:(NSString *)time;

@end

NS_ASSUME_NONNULL_END
