//
//  SettlementViewController.h
//  chuangyi
//
//  Created by caiyc on 17/8/9.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface SettlementViewController : BaseViewController
- (IBAction)payNow:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *paybtn;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
