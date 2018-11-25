//
//  ScenicModel.h
//  GoodView
//
//  Created by mac on 2018/11/25.
//  Copyright © 2018 mac. All rights reserved.
//  景区数据模型

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScenicModel : JSONModel

@property (nonatomic,strong) NSString * scenic_id;
//景区名称
@property (nonatomic,strong) NSString * scenic_name;
//该景区是否上架
@property (nonatomic,strong) NSString * is_on_sale;
//购买类型：1全部、2只运行电子支付、3只允许激活码
@property (nonatomic,strong) NSString * buy_type;
@property (nonatomic,strong) NSString * is_recommend;
//是否支持手绘图
@property (nonatomic,strong) NSString * is_hand_draw;
//自动跳开景区
@property (nonatomic,strong) NSString * is_jump;
//收听人数
@property (nonatomic,strong) NSString * listen_num;
@property (nonatomic,strong) NSString * scenic_rank;
//景区描述
@property (nonatomic,strong) NSString * scenics_text;
//所在城市
@property (nonatomic,strong) NSString * city;
//原价
@property (nonatomic,strong) NSString * cost_money;
//优惠后的价格（如果有优惠价格，原价中划线显示）
@property (nonatomic,strong) NSString * reduction_money;
//景区中心坐标
@property (nonatomic,strong) NSString * map_centre;
@property (nonatomic,strong) NSString * sort;
@property (nonatomic,strong) NSString * admission;
@property (nonatomic,strong) NSString * riding_text;
@property (nonatomic,strong) NSString * province;
//缩放等级12-16
@property (nonatomic,strong) NSString * map_zoom;
//缩放范围
@property (nonatomic,strong) NSString * zoom_scope;
//景区范围
@property (nonatomic,strong) NSString * scenic_scope;
//多点围栏
@property (nonatomic,strong) NSString * img_scope;
//景区首图
@property (nonatomic,strong) NSString * scenic_img;
@property (nonatomic,strong) NSString * voice_url;
//手绘图url
@property (nonatomic,strong) NSString * map_img;
@property (nonatomic,strong) NSString * goods_remark;
//景点集合
@property (nonatomic,strong) NSArray * spots;
//没有
@property (nonatomic,strong) NSString * scenicLatLng;
//距我多远，显示排序用，没有
@property (nonatomic,strong) NSString * distance;
@property (nonatomic,strong) NSString * km;
//没有
@property (nonatomic,strong) NSString * checked;
//1购买，0未购买
@property (nonatomic,assign) NSUInteger is_pay;
//音频包大小
@property (nonatomic,strong) NSString * bag_size;
//压缩包
@property (nonatomic,strong) NSString * zip_url;
//景区租赁扩音器
@property (nonatomic,strong) NSString * amplifier;
//线路推荐
@property (nonatomic,strong) NSString * route;
//线路推荐
@property (nonatomic,strong) NSString * route1;
//线路推荐
@property (nonatomic,strong) NSString * route2;
//线路推荐名称
@property (nonatomic,strong) NSString * route_name;
//线路推荐名称
@property (nonatomic,strong) NSString * route_name1;
//线路推荐名称
@property (nonatomic,strong) NSString * route_name2;
//支持的播放语言
@property (nonatomic,strong) NSString * lans;

@end

NS_ASSUME_NONNULL_END
