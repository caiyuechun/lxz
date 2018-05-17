//
//  ApplyWithDrawViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ApplyWithDrawViewController.h"

@interface ApplyWithDrawViewController ()

@end

@implementation ApplyWithDrawViewController
- (IBAction)seletType:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
             [self initNaviView:nil hasLeft:1 leftColor:nil title:@"提现申请" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.sumit_Btn.layer.masksToBounds = 1;
    self.sumit_Btn.layer.cornerRadius = 25;
    [self.aliType_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    [self.weixinType_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
//    self.calader_Lab LabelWithIconStr:@"\U0000" inIcon:<#(NSString *)#> andSize:<#(CGSize)#> andColor:<#(UIColor *)#> andiconSize:<#(CGFloat)#>
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

- (IBAction)submitAction:(id)sender {
}
@end
