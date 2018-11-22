//
//  LoginViewController.m
//  GoodView
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "SHImageAndTitleBtn.h"


@interface LoginViewController ()

//图标
@property (nonatomic,strong) UIImageView * iconImageView;
//手机号输入框
@property (nonatomic,strong) UITextField * phoneNumberTF;
//验证码输入框
@property (nonatomic,strong) UITextField * codeTF;
//说明label
@property (nonatomic,strong) UILabel * remarksLabel;
//登录按钮
@property (nonatomic,strong) UIButton * logInBtn;
//第三方登录
@property (nonatomic,strong) UILabel * leftLine;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * rightLine;

//微信按钮
@property (nonatomic,strong) SHImageAndTitleBtn * wechatBtn;
//QQ按钮
@property (nonatomic,strong) SHImageAndTitleBtn * QQBtn;

@end

@implementation LoginViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    [self setUI];
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.view addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.busNavigationBar.mas_bottom).offset(40);
        make.width.height.offset(110);
        make.left.offset((MAINWIDTH - 110) / 2);
    }];
    
    [self.view addSubview:self.phoneNumberTF];
    [self.phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(30);
        make.height.offset(50);
    }];

    [self.view layoutIfNeeded];
    
    CALayer * bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = [UIColor blackColor].CGColor;
    bottomLayer.frame = CGRectMake(0, CGRectGetHeight(self.phoneNumberTF.frame) - 1, CGRectGetWidth(self.phoneNumberTF.frame), 1);
    [self.phoneNumberTF.layer addSublayer:bottomLayer];
    
    [self.view addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.top.equalTo(self.phoneNumberTF.mas_bottom).offset(0);
        make.height.offset(50);
    }];
    
    [self.view addSubview:self.remarksLabel];
    [self.remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(5);
        make.top.equalTo(self.codeTF.mas_bottom).offset(5);
        make.right.offset(-5);
        make.height.offset(40);
    }];
    
    [self.view addSubview:self.logInBtn];
    [self.logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(25);
        make.top.equalTo(self.remarksLabel.mas_bottom).offset(25);
        make.right.offset(-25);
        make.height.offset(45);
    }];
    
    [self.view addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.equalTo(self.logInBtn.mas_bottom).offset(35);
        make.width.offset((MAINWIDTH - 90) / 2);
        make.height.offset(1);
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.leftLine.mas_right).offset(0);
        make.top.equalTo(self.logInBtn.mas_bottom).offset(25);
        make.width.offset(90);
        make.height.offset(16);
    }];
    
    [self.view addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_right).offset(0);
        make.top.equalTo(self.logInBtn.mas_bottom).offset(35);
        make.width.offset((MAINWIDTH - 90) / 2);
        make.height.offset(1);
    }];
    
    [self.view layoutIfNeeded];
    
    [self.view addSubview:self.wechatBtn];
    [self.view addSubview:self.QQBtn];
}

//获取验证码
-(void)getVerifyCode:(UIButton *)btn{
    
}

//登录按钮的响应
-(void)logInBtnClicked:(UIButton *)btn{
    
}

//三方登录的响应
-(void)thirdLogIn:(SHImageAndTitleBtn *)btn{
    
}

#pragma mark  ----  懒加载
-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor greenColor];
    }
    return _iconImageView;
}

-(UITextField *)phoneNumberTF{
    
    if (!_phoneNumberTF) {
        
        _phoneNumberTF = [[UITextField alloc] init];
        _phoneNumberTF.placeholder = @"请输入手机号";
        _phoneNumberTF.backgroundColor = [UIColor whiteColor];
        _phoneNumberTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _phoneNumberTF.leftViewMode = UITextFieldViewModeAlways;
        
        //验证码Button
        UIButton *verifyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        [verifyBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [verifyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _phoneNumberTF.rightView = verifyBtn;
        _phoneNumberTF.rightViewMode = UITextFieldViewModeAlways;
        [verifyBtn addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneNumberTF;
}

-(UITextField *)codeTF{
    
    if (!_codeTF) {
        
        _codeTF  = [[UITextField alloc] init];
        _codeTF.placeholder = @"请输入验证码";
        _codeTF.backgroundColor = [UIColor whiteColor];
        _codeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _codeTF;
}

-(UILabel *)remarksLabel{
    
    if (!_remarksLabel) {
        
        _remarksLabel = [[UILabel alloc] init];
        _remarksLabel.numberOfLines = 0;
        _remarksLabel.font = [UIFont systemFontOfSize:14.0];
        _remarksLabel.text = @"温馨提示：未注册账号的手机号，登录时会自动注册，且代表您已同意《景好软件协议》。";
    }
    return _remarksLabel;
}

-(UIButton *)logInBtn{
    
    if (!_logInBtn) {
        
        _logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logInBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logInBtn addTarget:self action:@selector(logInBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logInBtn;
}

-(UILabel *)leftLine{
    
    if (!_leftLine) {
        
        _leftLine = [[UILabel alloc] init];
        _leftLine.backgroundColor = [UIColor blackColor];
    }
    return _leftLine;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"第三方登录";
    }
    return _titleLabel;
}

-(UILabel *)rightLine{
    
    if (!_rightLine) {
        
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = [UIColor blackColor];
    }
    return _rightLine;
}

-(SHImageAndTitleBtn *)wechatBtn{
    
    if (!_wechatBtn) {
        
        _wechatBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake((MAINWIDTH - 135 - 40 * 2) / 2, CGRectGetMaxY(self.titleLabel.frame) + 60, 40, 60) andImageFrame:CGRectMake(0, 0, 40, 40) andTitleFrame:CGRectMake(0, 40, 40, 20) andImageName:@"draft@2x.png" andSelectedImageName:@"draft@2x.png" andTitle:@"微信" andTarget:self andAction:@selector(thirdLogIn:)];
    }
    return _wechatBtn;
}

-(SHImageAndTitleBtn *)QQBtn{
    
    if (!_QQBtn) {
        
        _QQBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake((MAINWIDTH - 135 - 40 * 2) / 2 + 135 + 40, CGRectGetMaxY(self.titleLabel.frame) + 60, 40, 60) andImageFrame:CGRectMake(0, 0, 40, 40) andTitleFrame:CGRectMake(0, 40, 40, 20) andImageName:@"draft@2x.png" andSelectedImageName:@"draft@2x.png" andTitle:@"QQ" andTarget:self andAction:@selector(thirdLogIn:)];
    }
    return _QQBtn;
}

@end
