//
//  OrderPriceInfoCell.h
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPriceInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *paytypes;
@property (weak, nonatomic) IBOutlet UILabel *consignee;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *paytype;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *orderamout;
@property (weak, nonatomic) IBOutlet UILabel *sendtype;
@property (weak, nonatomic) IBOutlet UILabel *couponsPrice;
@property (weak, nonatomic) IBOutlet UILabel *counsPrice;
@property (weak, nonatomic) IBOutlet UILabel *shipPrice;
@property (weak, nonatomic) IBOutlet UILabel *interLb;
-(void)bindData:(NSDictionary *)dic;
@end
