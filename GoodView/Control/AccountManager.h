//
//  AccountManager.h
//  GoodView
//
//  Created by mac on 2018/11/24.
//  Copyright © 2018 mac. All rights reserved.
//  账户管理类

#import <Foundation/Foundation.h>
#import "JHUserModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AccountManager : NSObject

//用户是否已登录
@property (nonatomic,assign) BOOL isLogIn;
//用户数据模型
@property (nonatomic,strong) JHUserModel * userModel;


+(AccountManager *)sharedManager;

//判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobileNum;

@end

NS_ASSUME_NONNULL_END
