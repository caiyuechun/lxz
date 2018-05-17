//
//  SeviceFeeViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/8.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SeviceFeeViewController.h"

@interface SeviceFeeViewController ()

@end

@implementation SeviceFeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  goods_note
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"费用及须知" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    [self.webView loadHTMLString:self.goodDic[@"goods_note"] baseURL:[NSURL URLWithString:BASE_SERVICE]];
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
