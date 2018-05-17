//
//  ShopCarViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ShopCarViewController : BaseViewController
- (IBAction)gobuygoods:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *corver_View;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)cacuAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *check_Lab;
@property (weak, nonatomic) IBOutlet UILabel *checkNum;

@end
