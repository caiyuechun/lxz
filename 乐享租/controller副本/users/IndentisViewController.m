//
//  IndentiViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "IndentisViewController.h"

@interface IndentisViewController ()

@end

@implementation IndentisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"身份认证" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.first_Btn.layer.borderWidth = 1;
    self.first_Btn.layer.cornerRadius = 20;
    self.first_Btn.layer.borderColor = viewcontrollerColor.CGColor;
    self.next_Btn.layer.cornerRadius = 20;
    self.next_Btn.layer.masksToBounds = 1;
    self.first_Btn.layer.masksToBounds = 1;
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
