//
//  CityModel.h
//  GoodView
//
//  Created by mac on 2018/11/25.
//  Copyright © 2018 mac. All rights reserved.
//  城市模型

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityModel : JSONModel

@property (nonatomic,strong) NSString * city_key;
@property (nonatomic,strong) NSString * city_name;
@property (nonatomic,strong) NSString * initials;
@property (nonatomic,strong) NSString * pinyin;
@property (nonatomic,strong) NSString * short_name;


@end

NS_ASSUME_NONNULL_END
