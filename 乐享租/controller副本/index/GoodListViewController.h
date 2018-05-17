//
//  GoodListViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *recomend_Lab;
@property (weak, nonatomic) IBOutlet UILabel *sales_Lab;
@property(nonatomic,strong)NSString *catogryId;
@property(nonatomic,strong)NSString *projectId;//专题id
@property(nonatomic,strong)NSString *brand_id;//品牌id
@property(nonatomic,strong)NSString *keyWords;
@end
