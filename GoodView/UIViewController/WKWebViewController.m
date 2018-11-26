//
//  WKWebViewController.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>


@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic,strong) NSString * urlStr;

@end

@implementation WKWebViewController

#pragma mark  ----  生命周期函数

-(instancetype)initWithTitle:(NSString *)navTitle andURLStr:(NSString *)urlStr{
    
    self = [super initWithTitle:navTitle];
    if (self) {
        
        self.urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  代理
#pragma mark  ----  WKNavigationDelegate

#pragma mark  ----  在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark  ----  在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}


#pragma mark  ---- 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
}

#pragma mark  ---- 接收到服务器跳转请求之后调用:接收到服务重定向时，会回调此方法
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

#pragma mark ---- 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    [MBProgressHUD hideHUD];
}

#pragma mark  ----  当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

#pragma mark  ----  网页加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    [MBProgressHUD hideHUD];
}

#pragma mark  ----  通过导航跳转失败的时候调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

#pragma mark    ----  这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling ,nil);
}


#pragma mark    ----  当web content处理完成时，会回调
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark  ----  WKUIDelegate

#pragma mark  ----  打开新窗口的委托
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    return nil;
}

#pragma mark  ----   webview关闭时回调
- (void)webViewDidClose:(WKWebView *)webView{
    
}

#pragma mark  ----  调用JS的alert()方法
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
}

#pragma mark  ----  调用JS的confirm()方法
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    
}

#pragma mark  ----   调用JS的prompt()方法，交互。可输入的文本。
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler{
    
}

//允许您的应用确定给定元素是否应显示预览。
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo{
    
    return YES;
}

//允许您的应用提供自定义视图控制器，以显示给定元素何时被窥视。
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions{
    
    return self;
}

//允许您的应用弹出到它创建的视图控制器
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController{
    
}


#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.busNavigationBar.mas_bottom).offset(0);
    }];
}


#pragma mark  ----  懒加载
-(WKWebView *)webView{
    
    if (!_webView) {
        
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}


@end
