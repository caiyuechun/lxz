//
//  ReportViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self initNaviView:nil hasLeft:1 leftColor:nil title:@"审核报告" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.goodNumber.text = self.result[@"goods_sn"];
    self.goodName.text = self.result[@"goods_name"];
    self.checkTime.text = self.result[@"check_time"];
    self.checkMan.text = self.result[@"check_man"];
    self.checkDes.text = self.result[@"check_desc"];
    self.checkQingk.text = self.result[@"check_situation"];
    self.checkReport.text = self.result[@"check_book"];
    self.checkResult.text = self.result[@"check_result"];
    self.checkDes.layer.borderColor = viewcontrollerColor.CGColor;
    self.checkDes.layer.masksToBounds = 1;
    self.checkDes.layer.borderWidth = 0.8;
    self.checkDes.layer.cornerRadius = 5;
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
