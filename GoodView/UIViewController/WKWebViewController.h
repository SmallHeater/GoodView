//
//  WKWebViewController.h
//  GoodView
//
//  Created by xianjunwang on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//  封装wkwebview的控制器

#import "SHBaseViewController.h"

@interface WKWebViewController : SHBaseViewController

-(instancetype)initWithTitle:(NSString *)navTitle andURLStr:(NSString *)urlStr;

@end
