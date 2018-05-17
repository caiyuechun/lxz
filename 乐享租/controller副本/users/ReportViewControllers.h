//
//  ReportViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ReportViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *checkQingk;
@property (weak, nonatomic) IBOutlet UILabel *checkResult;
@property (weak, nonatomic) IBOutlet UILabel *checkReport;
@property (weak, nonatomic) IBOutlet UILabel *checkDes;
@property (weak, nonatomic) IBOutlet UILabel *checkMan;
@property (weak, nonatomic) IBOutlet UILabel *checkTime;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodNumber;
@property (weak, nonatomic) IBOutlet UIScrollView *bottom_ScroView;
@property(nonatomic,strong)NSDictionary *result;
@end
