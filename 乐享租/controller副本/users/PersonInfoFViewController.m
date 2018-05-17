//
//  PersonInfoFViewController.m
//  乐享租
//
//  Created by caiyc on 18/4/17.
//  Copyright © 2018年 changce. All rights reserved.
//  个人信息过度页面

#import "PersonInfoFViewController.h"
#import "UserInfoViewController.h"
#import "CreditViewController.h"
#import "ZmCreditViewController.h"
@interface PersonInfoFViewController ()
@property (weak, nonatomic) IBOutlet UILabel *credit_Lab;
@property (weak, nonatomic) IBOutlet UILabel *pesoninfo_Lab;

@end

@implementation PersonInfoFViewController
- (IBAction)clickAction:(UIButton *)sender {
    if(sender.tag==0){
        UserInfoViewController *vc = [[UserInfoViewController alloc]init];
        [self pushView:vc];
    }else{
     //   [WToast showWithText:@"暂未开通请期待"];
        
        ZmCreditViewController *vc = [[ZmCreditViewController alloc]init];
        [self pushView:vc];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
         [self initNaviView:nil hasLeft:1 leftColor:nil title:@"个人信息" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.view.backgroundColor = viewcontrollerColor;
    [self.pesoninfo_Lab LabelWithIconStr:@"\U0000e607" inIcon:iconfont andSize:CGSizeMake(42, 42) andColor:RGB(30, 176, 168) andiconSize:30];
    [self.credit_Lab LabelWithIconStr:@"\U0000e630" inIcon:iconfont andSize:CGSizeMake(42, 42) andColor:RGB(246, 130, 0) andiconSize:30];
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
