//
//  ADModel.h
//  GoodView
//
//  Created by mac on 2018/11/25.
//  Copyright © 2018 mac. All rights reserved.
//  轮播广告模型

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADModel : JSONModel

@property (nonatomic,strong) NSString * ad_name;
@property (nonatomic,strong) NSString * ad_code;
//0表示网页、1表示景区
@property (nonatomic,strong) NSString * ad_type;
//景区返回景区对象，网页返回链接
@property (nonatomic,strong) NSString * ad_link;
//景区返回景区对象，网页返回链接
@property (nonatomic,strong) NSString * scenic;

@end

NS_ASSUME_NONNULL_END
