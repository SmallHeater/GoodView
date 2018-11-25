//
//  LoginViewController.h
//  GoodView
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//  登录页面

#import "SHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnBlock)();

@interface LoginViewController : SHBaseViewController

@property (nonatomic,copy) ReturnBlock block;

@end

NS_ASSUME_NONNULL_END
