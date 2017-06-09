//
//  MyWebViewController.h
//  CaoPanBao
//
//  Created by zhuojian on 14-4-30.
//  Copyright (c) 2014年 Mark. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@interface MyWebViewController : AppViewController<UIWebViewDelegate>
@property(nonatomic,strong)IBOutlet UIWebView* viewWeb;
@property (nonatomic,strong) NSString* method;//POST,GET
@property(nonatomic,strong)NSString* url;
@property (nonatomic,assign)float fontScale;
@property (nonatomic)BOOL isBack2History;//修改返回按钮为后退一页，默认为YES
+(instancetype)controllerWithUrl:(NSString*)url;
-(void)clearCache;//强制清缓存和Cookie
@end


@protocol JSListenerProtocol <JSExport>
-(void)onFinish:(NSString*)type :(NSString*)result :(NSString*)param;
@end


@interface JSListener : NSObject<JSListenerProtocol>
+(instancetype)listnerWithController:(MyWebViewController*)web;


@property (weak,nonatomic) MyWebViewController* web;
@end

