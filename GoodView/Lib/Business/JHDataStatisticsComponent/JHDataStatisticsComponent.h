//
//  JHDataStatisticsComponent.h
//  JHDataStatisticsComponent
//
//  Created by xianjunwang on 2018/10/28.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  数据采集组件

#import <Foundation/Foundation.h>

@interface JHDataStatisticsComponent : NSObject

//初始化
+(void)initDataStatisticsComponent:(NSDictionary *)initDic;

//设置关键数据，随崩溃信息上报
+ (void)setUser:(NSDictionary *)initDic;

//记录展示页面,key是pageName，value是页面
+(void)showPageView:(NSDictionary *)initDic;
//记录离开页面
+(void)goAwayPageView:(NSDictionary *)initDic;
//记录单一事件
+ (void)recordingSingleEvent:(NSDictionary *)initDic;
//记录开始事件
+ (void)beginEvent:(NSDictionary *)initDic;
//记录结束事件
+ (void)endEvent:(NSDictionary *)initDic;
//记录流程性事件，传每一步的关键点和用户ID
+(void)recordingEvent:(NSDictionary *)initDic;
//上报异常
+(void)reportException:(NSDictionary *)initDic;

@end
