//
//  MyOrderCell.m
//  GoodView
//
//  Created by mac on 2018/11/25.
//  Copyright © 2018 mac. All rights reserved.
//  高165

#import "MyOrderCell.h"

@interface MyOrderCell ()

//头像
@property (nonatomic,strong) UIImageView * avatar;
//用户名
@property (nonatomic,strong) UILabel * nameLabel;
//已授权
@property (nonatomic,strong) UILabel * stateLabel;
//虚线分割线
@property (nonatomic,strong) CAShapeLayer * firstLayer;
//商品名
@property (nonatomic,strong) UILabel * commodityLabel;
//件数
@property (nonatomic,strong) UILabel * countLabel;
//付款
@property (nonatomic,strong) UILabel * paymentLabel;
//虚线分割线
@property (nonatomic,strong) CAShapeLayer * secondLayer;
//支付方式
@property (nonatomic,strong) UILabel * paymentMethodLabel;
//购买时间
@property (nonatomic,strong) UILabel * buyTimeLabel;
//底部分割线
@property (nonatomic,strong) UILabel * bottomLineLabel;




@end

@implementation MyOrderCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.offset(5);
        make.width.height.offset(40);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.top.offset(10);
        make.height.offset(18);
        make.width.offset(200);
    }];
    
    [self addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(13);
        make.right.offset(-10);
        make.height.offset(15);
        make.width.offset(80);
    }];
    
    [self addSubview:self.commodityLabel];
    [self.commodityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.offset(50);
        make.right.offset(-40);
        make.height.offset(40);
    }];
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.commodityLabel.mas_top);
        make.right.offset(0);
        make.height.offset(15);
        make.width.offset(20);
    }];
    
    [self addSubview:self.paymentLabel];
    [self.paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.commodityLabel.mas_bottom).offset(10);
        make.right.offset(-10);
        make.height.offset(15);
        make.left.offset(10);
    }];
    
    
    [self addSubview:self.paymentMethodLabel];
    [self.paymentMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.avatar.mas_left);
        make.bottom.offset(-13);
        make.height.offset(15);
        make.width.offset(150);
    }];
    
    [self addSubview:self.buyTimeLabel];
    [self.buyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.paymentMethodLabel.mas_top);
        make.left.equalTo(self.paymentMethodLabel.mas_right);
        make.right.offset(-10);
        make.height.equalTo(self.paymentMethodLabel.mas_height);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(1);
        make.bottom.offset(-1);
        make.height.offset(1);
    }];
    
    [self setNeedsDisplay];
}

//绘制虚线
- (void)drawRect:(CGRect)rect {
    
    // 可以通过 setNeedsDisplay 方法调用 drawRect:
    // 绘制虚线1
    CGContextRef context =UIGraphicsGetCurrentContext();
    // 设置线条的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, Color_F5F5F5.CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    // 设置虚线绘制起点
    CGContextMoveToPoint(context, CGRectGetMinX(self.nameLabel.frame), 40.0);
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
    CGFloat lengths[] = {5,2};
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(context, MAINWIDTH,40.0);
    // 绘制
    CGContextStrokePath(context);
    // 关闭图像
    CGContextClosePath(context);
    
    // 绘制虚线2
//    CGContextRef context =UIGraphicsGetCurrentContext();
    // 设置线条的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, Color_F5F5F5.CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    // 设置虚线绘制起点
    CGContextMoveToPoint(context, 0, CGRectGetMaxY(self.paymentLabel.frame) + 10);
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
//    CGFloat lengths[] = {5,2};
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(context, MAINWIDTH,CGRectGetMaxY(self.paymentLabel.frame) + 10);
    // 绘制
    CGContextStrokePath(context);
    // 关闭图像
    CGContextClosePath(context);
}

#pragma mark  ----  懒加载
-(UIImageView *)avatar{
    
    if (!_avatar) {
        
        _avatar = [[UIImageView alloc] init];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 20;
        _avatar.backgroundColor = Color_F5F5F5;
    }
    return _avatar;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT18;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"钓鱼台";
    }
    return _nameLabel;
}

-(UILabel *)stateLabel{
    
    if (!_stateLabel) {
        
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = FONT15;
        _stateLabel.textAlignment = NSTextAlignmentRight;
        _stateLabel.textColor = [UIColor lightGrayColor];
        _stateLabel.text = @"已授权";
    }
    return _stateLabel;
}

-(UILabel *)commodityLabel{
    
    if (!_commodityLabel) {
        
        _commodityLabel = [[UILabel alloc] init];
        _countLabel.font = FONT16;
        _commodityLabel.textColor = [UIColor lightGrayColor];
        _commodityLabel.text = @"导游授权";
    }
    return _commodityLabel;
}

-(UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = FONT14;
        _countLabel.text = @"1";
    }
    return _countLabel;
}

-(UILabel *)paymentLabel{
    
    if (!_paymentLabel) {
        
        _paymentLabel = [[UILabel alloc] init];
        _paymentLabel.font = FONT14;
        _paymentLabel.textAlignment = NSTextAlignmentRight;
        _paymentLabel.text = @"共一件商品，实付￥8.00";
    }
    return _paymentLabel;
}

-(UILabel *)paymentMethodLabel{
    
    if (!_paymentMethodLabel) {
        
        _paymentMethodLabel = [[UILabel alloc] init];
        _paymentMethodLabel.font = FONT14;
        _paymentMethodLabel.textColor = [UIColor lightGrayColor];
        _paymentMethodLabel.text = @"支付方式：（余额）";
    }
    return _paymentMethodLabel;
}

-(UILabel *)buyTimeLabel{
    
    if (!_buyTimeLabel) {
        
        _buyTimeLabel = [[UILabel alloc] init];
        _buyTimeLabel.font = FONT14;
        _buyTimeLabel.textColor = [UIColor lightGrayColor];
        _buyTimeLabel.textAlignment = NSTextAlignmentRight;
        _buyTimeLabel.text = @"购买时间:2018-11-08 12:23:45";
    }
    return _buyTimeLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_F5F5F5;
    }
    return _bottomLineLabel;
}

@end
