//
//  MyEntryModel.h
//  GoodView
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 mac. All rights reserved.
//  我的页面，我的订单，我的扩音器等条目,个人信息页面条目的模型

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyEntryModel : JSONModel

//图标名
@property (nonatomic,strong) NSString * iconName;
//标题
@property (nonatomic,strong) NSString * title;
//内容
@property (nonatomic,strong) NSString * content;
//头像地址
@property (nonatomic,strong) NSString * imageUrlString;

@end

NS_ASSUME_NONNULL_END
