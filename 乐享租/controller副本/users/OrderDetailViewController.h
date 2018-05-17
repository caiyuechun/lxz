//
//  OrderDetailViewController.h
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *order_id;
@end
