//
//  LoginViewController.m
//  GoodView
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "SHImageAndTitleBtn.h"
#import "JKCountDownButton.h"
#import "JHUserModel.h"
#import <UMShare/UMShare.h>


@interface LoginViewController ()<UITextFieldDelegate>

//图标
@property (nonatomic,strong) UIImageView * iconImageView;
//手机号输入框
@property (nonatomic,strong) UITextField * phoneNumberTF;
//验证码输入框
@property (nonatomic,strong) UITextField * codeTF;
@property (nonatomic,strong) NSArray *changeArray;
//自己创造的验证码
@property (nonatomic,strong) NSMutableString *changeString;
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
    [self setUI];
}

#pragma mark  ----  代理
#pragma mark  ----  UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.phoneNumberTF] && ![[AccountManager sharedManager] validateMobile:textField.text]) {
        
        [MBProgressHUD showErrorMessage:@"请输入正确的手机号"];
    }
    
    if (self.codeTF.text.length > 0 && self.phoneNumberTF.text.length == 11){
        
        self.logInBtn.userInteractionEnabled = YES;
        self.logInBtn.backgroundColor = Color_1FBF9A;
    }
    else{
        
        self.logInBtn.userInteractionEnabled = NO;
        self.logInBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
    bottomLayer.backgroundColor = Color_F5F5F5.CGColor;
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

//制作验证码
-(void)creatCode{
    
    NSMutableString * getStr = [[NSMutableString alloc] initWithCapacity:5];
    self.changeString = [[NSMutableString alloc] initWithCapacity:6];//申请内存空间，一定要写，要不没有效果，我自己总是吃这个亏
    for (int i = 0; i<6; i++) {
        
        NSInteger index = arc4random()%([self.changeArray count]-1);//循环六次，得到一个随机数，作为下标值取数组里面的数放到一个可变字符串里，在存放到自身定义的可变字符串
        getStr = self.changeArray[index];
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
}

//登录按钮的响应
-(void)logInBtnClicked:(UIButton *)btn{
    
    if([self.phoneNumberTF.text isEmpty] || [self.codeTF.text isEmpty]){
        
        [MBProgressHUD showErrorMessage:@"请输入用户名和验证码!"];
    }else{
        
        if(![self.codeTF.text isEqualToString:self.changeString]){
            
            [MBProgressHUD showErrorMessage:@"验证码错误！"];
        }else{
            
            AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KGENURL]];
            [manager POST:@"User/login" parameters:@{@"username":self.phoneNumberTF.text} progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if([responseObject[@"status"] intValue] == 1){
                    
                    if(![responseObject[@"result"]  isEqual:[NSNull null]]){
                        
                        NSError * error;
                        JHUserModel * model = [[JHUserModel alloc] initWithDictionary:responseObject[@"result"]  error:&error];
                        if (error) {
                            
                            NSLog(@"错误：%@",error);
                            [AccountManager sharedManager].isLogIn = NO;
                        }
                        else{
                            
                            NSDictionary * dic = responseObject[@"result"];
                            model.jhmobile = dic[@"mobile"];
                            [AccountManager sharedManager].isLogIn = YES;
                            [AccountManager sharedManager].userModel = model;
                        }
                    }
                    
                    if (self.block) {
                        
                        self.block();
                    }
                    [self backBtnClicked:nil];
                }else if ([responseObject[@"code"] intValue] == -1){
                    
                    NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
                    [MBProgressHUD showErrorMessage:str];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [MBProgressHUD showErrorMessage:@"登录失败，请检查网络"];
            }];
        }
    }
}

//三方登录的响应
-(void)thirdLogIn:(SHImageAndTitleBtn *)btn{
    
    if (btn.tag == 1250) {
        
        //微信
        [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
    }
    else if (btn.tag == 1251){
        
        //QQ
        [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
    }
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        //QQ
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
        
        //微信
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

#pragma mark  ----  懒加载
-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo60@2x.png"]];
    }
    return _iconImageView;
}

-(UITextField *)phoneNumberTF{
    
    if (!_phoneNumberTF) {
        
        _phoneNumberTF = [[UITextField alloc] init];
        _phoneNumberTF.delegate = self;
        _phoneNumberTF.placeholder = @"请输入手机号";
        _phoneNumberTF.keyboardType = UIKeyboardTypePhonePad;
        _phoneNumberTF.backgroundColor = [UIColor whiteColor];
        _phoneNumberTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _phoneNumberTF.leftViewMode = UITextFieldViewModeAlways;
        
        JKCountDownButton * countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        countDownCode.frame = CGRectMake(0, 0, 100, 50);
        [countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [countDownCode setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        countDownCode.layer.cornerRadius = 5;
        countDownCode.titleLabel.font = [UIFont systemFontOfSize:13];
        _phoneNumberTF.rightView = countDownCode;
        _phoneNumberTF.rightViewMode = UITextFieldViewModeAlways;
        
        [countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            
            if (self.phoneNumberTF.text.length != 11) {
                
                [MBProgressHUD showErrorMessage:@"请输入正确的手机号"];
            }
            else{
                
                [self creatCode];
                NSString *str = [NSString stringWithFormat:@"您正在登录验证，验证码 %@ 请在15分钟内按照页面提示提交验证码，切勿将验证码泄露于他人",self.changeString];
                [[[AFHTTPSessionManager alloc] init] POST:KGENURL@"User/send_sms" parameters:@{@"mobile":self.phoneNumberTF.text,@"content":str} progress:^(NSProgress * _Nonnull uploadProgress) {


                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                    [sender startCountDownWithSecond:60];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                    [MBProgressHUD showErrorMessage:@"发送验证码失败"];
                }];
            }
            
            [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                
                sender.enabled = NO;
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                
                countDownButton.enabled = YES;
                return @"点击重新获取";
                
            }];
        }];
    }
    return _phoneNumberTF;
}

-(UITextField *)codeTF{
    
    if (!_codeTF) {
        
        _codeTF  = [[UITextField alloc] init];
        _codeTF.delegate = self;
        _codeTF.keyboardType = UIKeyboardTypePhonePad;
        _codeTF.placeholder = @"请输入验证码";
        _codeTF.backgroundColor = [UIColor whiteColor];
        _codeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _codeTF;
}

-(NSArray *)changeArray{
    
    if (!_changeArray) {
        
        //存放十个数，以备随机取
        _changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    }
    return _changeArray;
}

-(UILabel *)remarksLabel{
    
    if (!_remarksLabel) {
        
        _remarksLabel = [[UILabel alloc] init];
        _remarksLabel.numberOfLines = 0;
        _remarksLabel.font = FONT14;
        _remarksLabel.textColor = [UIColor lightGrayColor];
        _remarksLabel.text = @"温馨提示：未注册账号的手机号，登录时会自动注册，且代表您已同意《景好软件协议》。";
    }
    return _remarksLabel;
}

-(UIButton *)logInBtn{
    
    if (!_logInBtn) {
        
        _logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logInBtn setBackgroundColor:[UIColor lightGrayColor]];
        _logInBtn.layer.cornerRadius = 4;
//        _logInBtn.userInteractionEnabled = NO;
        [_logInBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logInBtn addTarget:self action:@selector(logInBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logInBtn;
}

-(UILabel *)leftLine{
    
    if (!_leftLine) {
        
        _leftLine = [[UILabel alloc] init];
        _leftLine.backgroundColor = Color_C4C4C4;
    }
    return _leftLine;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.text = @"第三方登录";
    }
    return _titleLabel;
}

-(UILabel *)rightLine{
    
    if (!_rightLine) {
        
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = Color_C4C4C4;
    }
    return _rightLine;
}

-(SHImageAndTitleBtn *)wechatBtn{
    
    if (!_wechatBtn) {
        
        _wechatBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake((MAINWIDTH - 135 - 40 * 2) / 2, CGRectGetMaxY(self.titleLabel.frame) + 60, 40, 60) andImageFrame:CGRectMake(0, 0, 40, 36) andTitleFrame:CGRectMake(0, 45, 40, 15) andImageName:@"ic_login_wechat@2x.png" andSelectedImageName:@"" andTitle:@"微信" andTarget:self andAction:@selector(thirdLogIn:)];
        _wechatBtn.tag = 1250;
    }
    return _wechatBtn;
}

-(SHImageAndTitleBtn *)QQBtn{
    
    if (!_QQBtn) {
        
        _QQBtn = [[SHImageAndTitleBtn alloc] initWithFrame:CGRectMake((MAINWIDTH - 135 - 40 * 2) / 2 + 135 + 40, CGRectGetMaxY(self.titleLabel.frame) + 60, 40, 60) andImageFrame:CGRectMake(2, 0, 36, 38) andTitleFrame:CGRectMake(0, 45, 40, 15) andImageName:@"ic_login_qq@2x.png" andSelectedImageName:@"" andTitle:@"QQ" andTarget:self andAction:@selector(thirdLogIn:)];
        _QQBtn.tag = 1251;
    }
    return _QQBtn;
}

@end
