//
//  JHAccountSystemComponent.h
//  JHAccountSystemComponent
//
//  Created by xianjunwang on 2018/10/29.
//  Copyright © 2018年 xianjunwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHAccountSystemComponent : NSObject

//得到用户ID
+(void)getUserIdCallBack:(void(^)(NSDictionary *retultDic))callBack;

@end
