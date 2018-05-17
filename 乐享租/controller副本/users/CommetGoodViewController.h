//
//  CommetGoodViewController.h
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface CommetGoodViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *type;//1 为评价 0 为退货
@property(nonatomic,strong)NSString *order_Sn;
@end
