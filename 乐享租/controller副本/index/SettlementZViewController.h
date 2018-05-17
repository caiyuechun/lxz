//
//  SettlementViewController.h
//  chuangyi
//
//  Created by caiyc on 17/8/9.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface SettlementZViewController : BaseViewController
- (IBAction)payNow:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *paybtn;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *corver_View;
@property (weak, nonatomic) IBOutlet UIView *sevice_View;
@property (weak, nonatomic) IBOutlet UITextView *sevice_Tv;

@end
