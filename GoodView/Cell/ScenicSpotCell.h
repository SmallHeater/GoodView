//
//  ScenicSpotCell.h
//  GoodView
//
//  Created by xianjunwang on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//  附近景区cell

#import <UIKit/UIKit.h>

@interface ScenicSpotCell : UITableViewCell

//图片地址，景区名，景区描述，听得人数，距离
-(void)setImage:(NSString *)imageUrlStr scenicName:(NSString *)name scenicContent:(NSString *)content listen:(NSString *)listen distance:(NSString *)distance;

@end
