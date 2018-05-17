//
//  MyPublishOldViewController.h
//  乐享租
//
//  Created by caiyc on 18/4/26.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface MyPublishOldViewController : BaseViewController
- (IBAction)selectCond:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *down_Lab1;
@property (weak, nonatomic) IBOutlet UILabel *down_Lab2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
