//
//  MyWebViewController.m
//  CaoPanBao
//
//  Created by zhuojian on 14-4-30.
//  Copyright (c) 2014年 Mark. All rights reserved.
//

#import "MyWebViewController.h"
//#import "H5ViewController.h"



@interface MyWebViewController ()<UINavigationControllerDelegate>

@end

@implementation MyWebViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.isBack2History = YES;
    return self;
}

-(instancetype)init{
    self = [super init];
    self.isBack2History = YES;
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 显示导航条
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    if([self.navigationController.childViewControllers count]>1){
         [self leftNavBtnWithIcon:@"nav_back" highlightedIcon:@"nav_back" target:self action:@selector(doBack:)];
    }
}




-(void)doBack:(id)sender
{
    
    if ([self.viewWeb canGoBack] && _isBack2History) {
        
        [self.viewWeb goBack];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



+(instancetype)controllerWithUrl:(NSString *)url{
    MyWebViewController* controller=[[self alloc] initWithNibName:@"MyWebViewController" bundle:nil];
    controller.url=url;
    controller.isBack2History = YES;
    return controller;
}



- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    self.viewWeb.backgroundColor=[UIColor blackColor];
    
    [super viewDidLoad];
    
    self.viewWeb.delegate=self;
//    self.isBack2History = YES;
   
    [self checkUrl];
    
    if ([[self.method uppercaseString] isEqualToString:@"GET"]) {
        NSURL *url = [NSURL URLWithString:self.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.viewWeb loadRequest:request];
    }else{
        NSArray *arr = [self.url componentsSeparatedByString:@"?"];
        NSURL *url = [NSURL URLWithString:arr[0]];
        NSMutableURLRequest *postReq = [[NSMutableURLRequest alloc]initWithURL: url];
        [postReq setHTTPMethod: @"POST"];
        if (arr.count>1) {
            [postReq setHTTPBody: [arr[1] dataUsingEncoding: NSUTF8StringEncoding]];
        }
        [self.viewWeb loadRequest:postReq];
    }

    // Do any additional setup after loading the view from its nib.
}

-(void)clearCache{
        //强制清缓存和Cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]){
            [storage deleteCookie:cookie];
        }
        //清除UIWebView的缓存
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(void)checkUrl{
    NSString *str ;
    if ([self.url hasPrefix:@"http"]||[self.url hasPrefix:@"https"]) {
        str = [NSString stringWithFormat:@"%@",self.url];
    }else{
        str = [NSString stringWithFormat:@"http://%@",self.url];
    }
    
    NSRange range = [self.url rangeOfString:@"session_id"];
//    if ([[UserInfoManager shareUserInfoManager] getSessionID]&&range.location==NSIntegerMax) {
//        range = [self.url rangeOfString:@"?"];
//        if (range.location!=NSIntegerMax) {
//            str = [NSString stringWithFormat:@"%@&session_id=%@",str,[[UserInfoManager shareUserInfoManager] getSessionID]];
//        }else{
//            str = [NSString stringWithFormat:@"%@?session_id=%@",str,[[UserInfoManager shareUserInfoManager] getSessionID]];
//        }
//    }
    self.url = str;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - webview delegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_fontScale) {
        NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",_fontScale*100];
        [webView stringByEvaluatingJavaScriptFromString:str];
    }
        //网页加载完成调用此方法
        
        //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"jsListener"] = [JSListener listnerWithController:self];
}



-(void)webViewDidStartLoad:(UIWebView *)webView{

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

//该表网页的字体大小
- (void)changeWeb:(UIWebView *)webView FontSize:(NSString *)size
{
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    if ([H5ViewController isClosed:request]) {
//        [self closed];
//        return NO;
//    }
//    if ([H5ViewController isSessionTimeout:request]) {
////        [self closed];
//        [AppUtil switchIndex:NO];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [AppMock launchSessionTimeoutViewController:[ViewControllerManager sharedManager].currentController1];       //跳转登陆界面2
//        });
//        return NO;
//    }
    
    
    NSString *requestString = [[request URL] absoluteString];
    NSRange range = [requestString rangeOfString:@"/campaign/articlelist"];
    if (range.length>0) {
        _isBack2History = NO;
    }else{
    
        _isBack2History = YES;
    }
    NSString *codeString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *components = [codeString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"auth"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"N"])
        {
            NSString* reason = [components objectAtIndex:3];
//            [WpCommonFunction messageBoxWithMessage:reason];
//            [WpCommonFunction]
      //      [WpCommonFunction showNotifyHUDAtViewBottom:self.view withErrorMessage:reason];
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle:@"Alert from Cocoa Touch" message:[components objectAtIndex:2]
//                                  delegate:self cancelButtonTitle:nil
//                                  otherButtonTitles:@"OK", nil];
//            [alert show];
//            [[NSNotificationCenter defaultCenter]postNotificationName:kBindCPBFail object:nil];
        }else
        {
//            [[NSNotificationCenter defaultCenter]postNotificationName:kBindCPBSuccess object:nil];
        }
        return NO;
    }
    
    if ([components count]>1 && [(NSString*)[components objectAtIndex:0]isEqualToString:@"qualification"]) {
        
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"Y"]){
            
            
            [self back];
            
        }
        
    }
    
//    if ([(NSString *)[components objectAtIndex:1] isEqualToString:kH5Url2Simulation]) {
//        [self.navigationController popViewControllerAnimated:NO];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kH5Url2Simulation object:nil];
//        return NO;
//    }
//    
//    if ([(NSString *)[components objectAtIndex:1] isEqualToString:kH5Url2Buy]) {
//        [self.navigationController popViewControllerAnimated:NO];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kH5Url2Buy object:nil];
//        return NO;
//    }
//    
//    if ([(NSString *)[components objectAtIndex:1] isEqualToString:kH5Url2Cer]) {
//        [self.navigationController popViewControllerAnimated:NO];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kH5Url2Cer object:nil];
//        return NO;
//    }
    
    return YES;
}


-(void)bindSuccess{
//    [WpCommonFunction showNotifyHUDAtViewBottom:self.view withErrorMessage:@"绑定成功"];
//    [AppUtil exitAccount:YES];
}

-(void)bindFail{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kHasIfQualification object:nil];

}

-(void)closed{
    [self.navigationController popViewControllerAnimated:YES];
}


@end


@implementation JSListener
+(instancetype)listnerWithController:(MyWebViewController *)web{
    JSListener *listner = [[JSListener alloc] init];
    listner.web = web;
    return listner;
}
-(void)onFinish:(NSString*)type :(NSString*)result :(NSString*)param{

//    NSDictionary *dict= [param objectFromJSONString];
//    if ([result isEqualToString:@"Y"] && [[dict objectForKey:@"type"] isEqualToString:@"applogin"]) {
//        [self.web.navigationController popViewControllerAnimated:YES];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [[NSNotificationCenter defaultCenter] postNotificationName:kSSOLoginNotification object:[dict objectForKey:@"token"]];
//        });
//    }
//
//    if ([result isEqualToString:@"Y"] && [[type uppercaseString] isEqualToString:@"FINISH"]) {
//        DEFINED_WEAK_SELF
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_self.web.navigationController popViewControllerAnimated:YES];
//        });
//    }
//    
//    if ([result isEqualToString:@"Y"] && [type isEqualToString:@"gotoStrategy"]) {
//        
//        DEFINED_WEAK_SELF
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_self.web.navigationController popToRootViewControllerAnimated:NO];
//            [[AppUtil findIndex] go2PublishStrategy:NO];
//        });
//        
//
//
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [[AppUtil findIndex] go2PublishStrategy:NO];
////        });
//    }
}
@end

