//
//  ShareDetailViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *ids;
@end
