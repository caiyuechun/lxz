//
//  ListViewController.h
//  chuangyi
//
//  Created by yncc on 17/8/14.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSString *typeStr;
@end
