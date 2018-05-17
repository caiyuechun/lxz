//
//  PayDetctionViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "PayDetctionViewController.h"

@interface PayDetctionViewController ()

@end

@implementation PayDetctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"支付检测费用" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.botom_ScroView.backgroundColor = [UIColor whiteColor];
    self.pay_Btn.layer.masksToBounds = 1;
    self.pay_Btn.layer.cornerRadius = 25;
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
