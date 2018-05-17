//
//  OrderListViewController.h
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface DistubeDViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic)  UILabel *moveLa;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)changeStatus:(UIButton *)sender;
@property(nonatomic,strong)NSString *sattus;

@end
