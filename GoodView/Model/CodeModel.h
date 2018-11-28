//
//  CodeModel.h
//  GoodView
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 mac. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CodeModel : JSONModel

@property (nonatomic,strong) NSString * code_id;
@property (nonatomic,strong) NSString * value;
@property (nonatomic,strong) NSString * is_issue;
@property (nonatomic,strong) NSString * add_time;
@property (nonatomic,strong) NSString * use_time;
@property (nonatomic,strong) NSString * codename;
@property (nonatomic,strong) NSString * is_use;
@property (nonatomic,strong) NSString * scenics_id;
@property (nonatomic,strong) NSString * barcode;
@property (nonatomic,strong) NSString * user_id;
@property (nonatomic,strong) NSString * synchronize;

@end

NS_ASSUME_NONNULL_END
