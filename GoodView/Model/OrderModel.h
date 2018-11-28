//
//  OrderModel.h
//  GoodView
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 mac. All rights reserved.
//  订单模型

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CodeModel;

@interface OrderModel : JSONModel

@property (nonatomic,strong) NSString * order_id;
@property (nonatomic,strong) NSString * order_sn;
@property (nonatomic,strong) NSString * scenic_id;
@property (nonatomic,strong) NSString * user_id;
@property (nonatomic,strong) NSString * add_time;
@property (nonatomic,strong) NSString * is_pay;
@property (nonatomic,strong) NSString * money;
@property (nonatomic,strong) NSString * pay_type;
@property (nonatomic,strong) NSString * synchronize;
@property (nonatomic,strong) NSString * out_trade_no;
@property (nonatomic,strong) NSString * mobile;
@property (nonatomic,strong) NSString * trade_no;
@property (nonatomic,strong) NSString * fancheng;
@property (nonatomic,strong) NSString * user_fmoney;
@property (nonatomic,strong) NSString * admin_fmoney;
@property (nonatomic,strong) NSString * scenic_img;
@property (nonatomic,strong) NSString * scenic_name;
@property (nonatomic,strong) CodeModel * code;

@end

NS_ASSUME_NONNULL_END
