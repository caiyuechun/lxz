//
//  ConpousListViewController.h
//  chuangyi
//
//  Created by caiyc on 17/9/9.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ConpousListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(assign)BOOL needback;
- (IBAction)changeStat:(UIButton *)sender;
@property(nonatomic,copy)void (^conpous)(NSDictionary *);

@end
