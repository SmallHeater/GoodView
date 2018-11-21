//
//  JHLiveBaseRequest.m
//  JHLivePlayDemo
//
//  Created by pk on 2017/9/7.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "JHLiveBaseRequest.h"
#import "JHProjectCommonData.h"
#import "APIRequest.h"
#import "PKLoadingView.h"

#define INTERNETERROR  @"您的网络好像不太给力，稍后重试"
#define NetWorkRemind  @"网络异常,请稍后再试"

@implementation JHLiveBaseRequest

+ (NSString *)appid{
    return [JHProjectCommonData getProjectInfoDicAppID];
}

+ (NSString *)userId{
    return [[LoginAndRegister sharedLoginAndRegister] getUserID];
}

+ (NSString *)orgIdInAppInfo{
    return [NSBundle mainBundle].infoDictionary[@"ORGID"];
}

+ (NSString *)userName{
    NSDictionary * dict = [LoginAndRegister  currentUserMessage];
    return [dict objectForKey:@"userName"];
}

+ (NSString *)userIcon{
    NSDictionary * dict = [LoginAndRegister currentUserMessage];
    return [dict objectForKey:@"userHeadurl"];
}

+ (NSString *)appName{
    
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
}

+ (NSString *)areaCodeInMainPlistInfo{
    NSDictionary * dict = [NSBundle mainBundle].infoDictionary[@"storeMapProperties"];
    if ([dict.allKeys containsObject:@"storeAreaCode"]) {
        return [dict objectForKey:@"storeAreaCode"];
    }
    return @"";
}


+ (NSString *)addUrlProtocolAndEnvWithStr:(NSString *)urlStr{
    //#ifdef DEBUG
    //    NSString * strUrl = [NSString stringWithFormat:@"%@%@%@",[JHProjectCommonData getNetworkProtocol],@"dev",urlStr];
    //    return strUrl;
    //#else
    NSString * strUrl = [NSString stringWithFormat:@"%@%@%@",[JHProjectCommonData getNetworkProtocol],[JHProjectCommonData netEnvironment],urlStr];
    return strUrl;
    //#endif
}

+ (BOOL)isNetWorkActivity{
    return [APIRequest isReachable];
}

+ (BOOL)isWifi{
    
    return [APIRequest isWIFIRechable];
}


static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                          [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

static NSURL* NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters)
{
    NSString* URLString = [NSString stringWithFormat:@"%@?%@",
                           [URL absoluteString],
                           NSStringFromQueryParameters(queryParameters)
                           ];
    return [NSURL URLWithString:URLString];
}

+ (NSURLSessionTask *)sendRequestWithURLString:(NSString *)urlStr parameters:(NSDictionary *)para httpMethod:(HTTPMETHOD)method showLoading:(BOOL)showLoading isCallBackInMainQueue:(BOOL)isCallBackInMainQueue  completionHandler:(requestCompletionHandler)completionHandler {
    
    //update by pk at 20180910
    NSMutableDictionary * mutablePata = [NSMutableDictionary dictionaryWithDictionary:para];
    
    
    //此处添加网络检测
    if ([self isNetWorkActivity] == NO && showLoading == YES) {
        showLoading = NO;
        [MBProgressHUD displayHudError:NetWorkRemind];
    }
    
    NSURL* URL;
    if ([urlStr rangeOfString:@"restapi.amap.com"].location != NSNotFound) {
        
        //高德
        URL = [NSURL URLWithString:urlStr];
    }
    else{
        
        URL = [NSURL changProtocolURLWithString:urlStr];
    }
    if (method == GET) {
        
        if (mutablePata && [mutablePata isKindOfClass:[NSDictionary class]] && mutablePata.allKeys.count > 0) {
            
            URL = NSURLByAppendingQueryParameters(URL, mutablePata);
        }
    }else{
        
        NSDictionary * clientInfo = @{
                                      @"version":@"v1.0.0",
                                      @"versionNum":@100,
                                      @"device":@"ios"
                                      };
        [mutablePata setObject:clientInfo forKey:@"clientInfo"];
    }
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    //    request.timeoutInterval = 10;
    request.timeoutInterval = 60;
    // Headers
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    switch (method) {
        case GET:
            request.HTTPMethod = @"GET";
            
            break;
        case POST:
            request.HTTPMethod = @"POST";
            break;
        default:
            request.HTTPMethod = @"POST";
            break;
    }
    if (para && para.allKeys.count > 0) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:mutablePata options:kNilOptions error:NULL];
    }
    
    // Connection
    NSURLSession * urlSession = [NSURLSession  sessionWithConfiguration:[NSURLSessionConfiguration
                                                                         defaultSessionConfiguration]];
    
    MBProgressHUD *hud = nil;
    if (showLoading == YES) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        [hud show:YES];
        //        [[PKLoadingView loginView] showInView:[UIApplication sharedApplication].keyWindow];
    }else{
        [hud hide:YES];
        [hud removeFromSuperview];
        
        //        [[PKLoadingView loginView] hide];
    }
    
    NSURLSessionTask * task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (isCallBackInMainQueue == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [hud removeFromSuperview];
                //                [[PKLoadingView loginView] hide];
                completionHandler(data,response,error);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [hud removeFromSuperview];
                //                [[PKLoadingView loginView] hide];
            });
            completionHandler(data,response,error);
        }
        
    }];
    [task resume];
    return task;
}

+ (NSURLSessionTask *)sendYingShiRequestWithURLString:(NSString *)urlStr parameters:(NSData *)para httpMethod:(HTTPMETHOD)method showLoading:(BOOL)showLoading isCallBackInMainQueue:(BOOL)isCallBackInMainQueue  completionHandler:(requestCompletionHandler)completionHandler {
    
    //可以在此处添加网络检测
    
    NSURL* URL = [NSURL changProtocolURLWithString:urlStr];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval = 10;
    // Headers
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    switch (method) {
        case GET:
            request.HTTPMethod = @"GET";
            break;
        case POST:
            request.HTTPMethod = @"POST";
            break;
        default:
            request.HTTPMethod = @"POST";
            break;
    }
    
    request.HTTPBody = para;
    // Connection
    NSURLSession * urlSession = [NSURLSession  sessionWithConfiguration:[NSURLSessionConfiguration
                                                                         defaultSessionConfiguration]];
    
    MBProgressHUD *hud = nil;
    if (showLoading == YES) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        [hud show:YES];
        //        [[PKLoadingView loginView] showInView:[UIApplication sharedApplication].keyWindow];
    }else{
        //        [[PKLoadingView loginView] hide];
        [hud hide:YES];
        [hud removeFromSuperview];
    }
    
    NSURLSessionTask * task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (isCallBackInMainQueue == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [hud removeFromSuperview];
                //                [[PKLoadingView loginView] hide];
                completionHandler(data,response,error);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [hud removeFromSuperview];
                //                [[PKLoadingView loginView] hide];
            });
            completionHandler(data,response,error);
        }
        
    }];
    [task resume];
    return task;
}


+ (NSURLSessionTask *)sendRequestWithURLString:(NSString *)urlStr parameters:(NSDictionary *)para httpMethod:(HTTPMETHOD)method completionHandler:(requestCompletionHandler)completionHandler {
    return [self sendRequestWithURLString:urlStr parameters:para httpMethod:method showLoading:NO isCallBackInMainQueue:NO completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completionHandler(data,response,error);
    }];
    
}


+ (NSURLSessionTask *)sendRequestWithURLString:(NSString *)urlStr parameters:(NSDictionary *)para httpMethod:(HTTPMETHOD)method isCallBackInMainQueue:(BOOL)isCallBackInMainQueue completionHandler:(requestCompletionHandler)completionHandler {
    return [self sendRequestWithURLString:urlStr parameters:para httpMethod:method completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (isCallBackInMainQueue == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(data,response,error);
            });
        }else{
            completionHandler(data,response,error);
        }
    }];
    
}

+ (NSURLSessionTask *)sendGetRequestToGetARMRTMPString:(NSString *)urlStr parameters:(NSDictionary *)para  showLoading:(BOOL)showLoading isCallBackInMainQueue:(BOOL)isCallBackInMainQueue  completionHandler:(requestCompletionHandler)completionHandler {
    
    //此处添加网络检测
    if ([self isNetWorkActivity] == NO) {
        showLoading = NO;
        [MBProgressHUD displayHudError:NetWorkRemind];
    }
    
    NSURL* URL = [NSURL URLWithString:urlStr];
    URL = NSURLByAppendingQueryParameters(URL, para);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    // Headers
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    
    // Connection
    NSURLSession * urlSession = [NSURLSession  sessionWithConfiguration:[NSURLSessionConfiguration
                                                                         defaultSessionConfiguration]];
    MBProgressHUD *hud = nil;
    if (showLoading == YES) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"播放协议获取中...";
        [hud show:YES];
    }else{
        [hud hide:YES];
        [hud removeFromSuperview];
    }
    
    NSURLSessionTask * task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (isCallBackInMainQueue == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [hud removeFromSuperview];
                completionHandler(data,response,error);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [hud removeFromSuperview];
            });
            completionHandler(data,response,error);
        }
        
    }];
    [task resume];
    return task;
}

@end
