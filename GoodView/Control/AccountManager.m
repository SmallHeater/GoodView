//
//  AccountManager.m
//  GoodView
//
//  Created by mac on 2018/11/24.
//  Copyright © 2018 mac. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

#pragma mark  ----  生命周期函数

+(AccountManager *)sharedManager{
    
    static AccountManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AccountManager alloc] init];
    
        /*
        Mobile = 1;
        QQ = 0;
        Wechat = 0;
        "address_id" = 0;
        birthday = 0;
        city = 0;
        discount = "1.00";
        "distribut_money" = "0.00";
        district = 0;
        email = "";
        "email_validated" = 0;
        "first_leader" = 0;
        "frozen_money" = "0.00";
        "head_pic" = "";
        "is_distribut" = 1;
        "is_lock" = 0;
        "last_ip" = "";
        "last_login" = 1543066776;
        level = 1;
        "level_name" = "\U6ce8\U518c\U4f1a\U5458";
        mobile = 15010768330;
        "mobile_validated" = 0;
        nickname = 15010768330;
        oauth = Mobile;
        openid = "<null>";
        password = "";
        "pay_points" = 0;
        pid = 0;
        province = 0;
        qq = "<null>";
        "reg_time" = 1542379093;
        "second_leader" = 0;
        sex = 0;
        synchronize = 1;
        "third_leader" = 0;
        token = 6cf2ef21a569acd16f7a3882050fde54;
        "total_amount" = "0.00";
        "user_id" = 1956;
        "user_money" = "0.00";
        */
        
        JHUserModel * model = [[JHUserModel alloc] init];
        model.Mobile = 1;
        model.QQ = 0;
        model.Wechat = 0;
        model.address_id = @"0";
        model.birthday = @"0";
        model.city = @"0";
        model.discount = @"1.00";
        model.distribut_money = @"0.00";
        model.district = @"0";
        model.email = @"";
        model.email_validated = @"0";
        model.first_leader = @"0";
        model.frozen_money = @"0.00";
        model.head_pic = @"";
        model.is_distribut = @"1";
        model.is_lock = @"0";
        model.last_ip = @"";
        model.last_login = @"1543066776";
        model.level = @"1";
        model.level_name = @"注册用户";
        model.jhmobile = @"15010768330";
        model.mobile_validated = @"0";
        model.nickname = @"15010768330";
        model.oauth = @"Mobile";
        model.openid = @"<null>";
        model.password = @"";
        model.pay_points = @"0";
        model.pid = @"0";
        model.province = @"0";
        model.qq = @"<null>";
        model.reg_time = @"1542379093";
        model.second_leader = @"0";
        model.sex = @"0";
        model.synchronize = @"1";
        model.third_leader =@"0";
        model.token = @"6cf2ef21a569acd16f7a3882050fde54";
        model.total_amount = @"0.00";
        model.user_id = @"1956";
        model.user_money = @"0.00";
        manager.userModel = model;
        manager.isLogIn = YES;
        
        
    });
    return manager;
}

#pragma mark  ----  自定义函数
//判断是否是手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
