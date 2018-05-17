//
//  PrivaceViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface PrivaceViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *kegou_Count;
@property (weak, nonatomic) IBOutlet UILabel *yigou_Count;
@property (weak, nonatomic) IBOutlet UILabel *goumai_Count;
@property (weak, nonatomic) IBOutlet UIView *alert_View;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *cover_View;
@property (weak, nonatomic) IBOutlet UILabel *questiion_Lab;
- (IBAction)chechQuestion:(UIButton *)sender;

@end
