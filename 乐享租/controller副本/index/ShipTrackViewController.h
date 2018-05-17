//
//  ShipTrackViewController.h
//  SHOP
//
//  Created by caiyc on 17/3/28.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ShipTrackViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UITableView *ShipList;
@property(nonatomic,strong)NSString *addressStr;
@property(nonatomic,strong)NSString *orderNums;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)NSString *order_id;

@property(nonatomic,strong)NSString *invoice_no;
@property(nonatomic,strong)NSString *shipCode;
@end
