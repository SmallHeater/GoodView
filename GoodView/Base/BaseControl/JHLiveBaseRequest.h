//
//  JHLiveBaseRequest.h
//  JHLivePlayDemo
//
//  Created by pk on 2017/9/7.
//  Copyright © 2017年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTTPMETHOD) {
    GET,
    POST
};

typedef void(^requestCompletionHandler)(NSData * data, NSURLResponse * response, NSError * error);

@interface JHLiveBaseRequest : NSObject

+ (NSString *)appid;

+ (NSString *)userId;

+ (NSString *)orgIdInAppInfo;

+ (NSString *)userName;

+ (NSString *)userIcon;

+ (NSString *)appName;

+ (NSString *)areaCodeInMainPlistInfo;

+ (NSString *)addUrlProtocolAndEnvWithStr:(NSString *)urlStr;

+ (BOOL)isNetWorkActivity;
+ (BOOL)isWifi;

+ (NSURLSessionTask *)sendRequestWithURLString:(NSString *)urlStr parameters:(NSDictionary *)para httpMethod:(HTTPMETHOD)method showLoading:(BOOL)showLoading isCallBackInMainQueue:(BOOL)isCallBackInMainQueue  completionHandler:(requestCompletionHandler)completionHandler;

//萤石接口专用
+ (NSURLSessionTask *)sendYingShiRequestWithURLString:(NSString *)urlStr parameters:(NSData *)para httpMethod:(HTTPMETHOD)method showLoading:(BOOL)showLoading isCallBackInMainQueue:(BOOL)isCallBackInMainQueue  completionHandler:(requestCompletionHandler)completionHandler;

+ (NSURLSessionTask *)sendRequestWithURLString:(NSString *)urlStr parameters:(NSDictionary *)para httpMethod:(HTTPMETHOD)method completionHandler:(requestCompletionHandler)completionHandler;

+ (NSURLSessionTask *)sendRequestWithURLString:(NSString *)urlStr parameters:(NSDictionary *)para httpMethod:(HTTPMETHOD)method isCallBackInMainQueue:(BOOL)isCallBackInMainQueue completionHandler:(requestCompletionHandler)completionHandler;

+ (NSURLSessionTask *)sendGetRequestToGetARMRTMPString:(NSString *)urlStr parameters:(NSDictionary *)para  showLoading:(BOOL)showLoading isCallBackInMainQueue:(BOOL)isCallBackInMainQueue  completionHandler:(requestCompletionHandler)completionHandler;

@end
