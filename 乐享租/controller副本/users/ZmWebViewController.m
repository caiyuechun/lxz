//
//  ZmWebViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ZmWebViewController.h"
#import <WebKit/WebKit.h>
@interface ZmWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZmWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //http://lxz.ynthgy.com/home/index/zmsure
//    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"授权" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lxz.ynthgy.com/home/index/zmsure"]];
//    [self.webView loadRequest:req];
    WKWebView *web = [[WKWebView alloc]initWithFrame:CGRectMake(0, naviHei, screen_width, screen_height-naviHei)];
    [web loadRequest:req];
    [self.view addSubview:web];
    // Do any additional setup after loading the view from its nib.
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
