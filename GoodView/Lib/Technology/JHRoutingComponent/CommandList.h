//
//  CommandList.h
//  JHRoutingComponent
//
//  Created by xianjunwang on 2018/11/8.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//  命令宏

#ifndef CommandList_h
#define CommandList_h

#pragma mark  ----  大图浏览组件命令集合
//大图浏览命令
#define BIGPICTUREBROWSING @"BusinessFoundation://BigPictureBrowsing:(bigPictureBrowsing:)"
#pragma mark  ----  大图浏览组件命令集合

#pragma mark  ----  加密组件命令集合
//水印加密图片命令
#define WATERMARKENCRYPTIONIMAGE @"Technology://EncryptionComponent:(watermarkEncryptionImage:callBack:)"
#pragma mark  ----  加密组件命令集合

#pragma mark  ----  数据采集组件命令集合
//初始化数据采集组件命令
#define INITDATASTATISTICSCOMPONENT @"BusinessFoundation://DataStatisticsComponent:(initDataStatisticsComponent:)"
//上报异常命令
#define REPORTEXCEPTION @"BusinessFoundation://DataStatisticsComponent:(reportException:)"
//记录事件命令
#define RECORDINGEVENT @"BusinessFoundation://DataStatisticsComponent:(recordingEvent:)"
//记录展示页面命令
#define SHOWPAGEVIEW @"BusinessFoundation://DataStatisticsComponent:(showPageView:)"
//记录退出页面命令
#define GOAWAYPAGEVIEW @"BusinessFoundation://DataStatisticsComponent:(goAwayPageView:)"
#pragma mark  ----  数据采集组件命令集合

#pragma mark  ----  相册浏览组件命令集合

//去相册命令
#define GETIMAGE @"BusinessFoundation://PictureSelection:(getImage:callBack:)"

#pragma mark  ----  相册浏览组件命令集合

#pragma mark  ----  账户体系组件命令集合
//得到用户ID命令
#define GETUSERIDCALLBACK @"BusinessFoundation://AccountSystemComponent:(getUserIdCallBack:)"
#pragma mark  ----  账户体系组件命令集合



#endif /* CommandList_h */
