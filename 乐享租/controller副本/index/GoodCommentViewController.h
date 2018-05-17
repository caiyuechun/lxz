//
//  GoodCommentViewController.h
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodCommentViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSString *goodId;
@end
