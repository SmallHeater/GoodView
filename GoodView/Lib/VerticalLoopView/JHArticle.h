//
//  JHArticle.h
//  tobacco
//
//  Created by Yehua Zhao on 2017/1/22.
//  Copyright © 2017年 master. All rights reserved.
//

#import "JSONModel.h"

@interface JHArticle : JSONModel

@property (nonatomic,copy) NSString *article_id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;

@end
