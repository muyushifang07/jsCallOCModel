//
//  JSModelViewController.m
//  JavaScriptCoreDemo
//
//  Created by giifidev on 2018/8/21.
//  Copyright © 2018年 reborn. All rights reserved.
//

#import "JSModelViewController.h"
#import "ELLiveJSModel.h"

#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height

@interface JSModelViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) JSContext *context;
@end

@implementation JSModelViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"indexModel";
    self.view.backgroundColor = [UIColor whiteColor];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.webView];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"indexModel" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 获取html title设置导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 捕捉异常回调
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息: %@",exceptionValue);
    };

    // model 的方法JS与OC交互
    ELLiveJSModel *jsModel = [ELLiveJSModel new];
    self.context[@"testobject"] = jsModel;

    // 注意：jsModel 是在OC的对象名字，testobject 是在JS中的对象名字

    // 模拟JS调用方法
    NSString *jsCallOCModelFunction = @"testobject.description()";
    JSValue *valu = [self.context evaluateScript:jsCallOCModelFunction];
    NSLog(@"vali----:%@",[valu toString]);  // 返回值

    NSLog(@"尚未赋值X的log:%f",jsModel.x);

    // 模拟JS调用方法 给testobject.x赋值
    NSString *jsCallOCModelFunction1 = @"testobject.x=30";
    [self.context evaluateScript:jsCallOCModelFunction1];
    NSLog(@"jsCallOCFunction1----%f",jsModel.x);

    // JS双参数调用的例子
    NSString *jsCallOCModelFunction2 = @"testobject.makePointXPointY('20','50')";
    [self.context evaluateScript:jsCallOCModelFunction2];
    NSLog(@"jsCallOCFunction2----%f",jsModel.x);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error == %@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
