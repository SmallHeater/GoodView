//
//  CarouselCell.m
//  GoodView
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CarouselCell.h"
#import "SDCycleScrollView.h"
#import "ADModel.h"
#import "WKWebViewController.h"


@interface CarouselCell ()<SDCycleScrollViewDelegate>

//轮播区
@property (nonatomic,strong) SDCycleScrollView * carouselScrollView;
//数据
@property (nonatomic,strong) NSMutableArray<ADModel *> * dataArray;

@end

@implementation CarouselCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
    }
    return self;
}

#pragma mark  ----  代理
#pragma mark  ----  SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (self.dataArray.count > index) {
     
        ADModel * model = self.dataArray[index];
        if ([model.ad_type isEqualToString:@"0"]) {
            
            //网页
            WKWebViewController * controller = [[WKWebViewController alloc] initWithTitle:model.ad_name andURLStr:@"https:www.baidu.com"];
            [[self viewController].navigationController pushViewController:controller animated:NO];
            //        [self.navigationController pushViewController:controller animated:NO];
        }
        else if ([model.ad_type isEqualToString:@"1"]){
            
            //景区
        }
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self addSubview:self.carouselScrollView];
    [self.carouselScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.offset(0);
    }];
}

//设置轮播区数据
-(void)setCarouselData:(NSMutableArray<ADModel *> *)array{
    
    if (array.count > 0) {
     
        self.carouselScrollView.imageURLStringsGroup = nil;
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < array.count; i++) {
            
            ADModel * model = self.dataArray[i];
            [arr addObject:[[NSString alloc] initWithFormat:@"%@%@",KIMGURL,model.ad_code]];
        }
        self.carouselScrollView.imageURLStringsGroup = arr;
    }
}

#pragma mark  ----  懒加载
-(SDCycleScrollView *)carouselScrollView{
    
    if (!_carouselScrollView) {
        
        _carouselScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 0, 0) delegate:self placeholderImage:[UIImage imageNamed:@"default@2x.png"]];
        _carouselScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _carouselScrollView;
}

-(NSMutableArray<ADModel *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
