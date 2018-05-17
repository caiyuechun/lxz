//
//  PayViewController.h
//  SHOP
//
//  Created by caiyc on 17/4/14.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface PayViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UILabel *cashNum;
@property (weak, nonatomic) IBOutlet UILabel *aliSelectLb;
- (IBAction)payOffline:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *hide_View;
@property (weak, nonatomic) IBOutlet UILabel *weixinSelectLb;
@property(nonatomic,strong)NSString *orderStr;
@property(nonatomic,strong)NSString *cashStr;
@property(nonatomic,strong)NSString *order_Id;
@property(assign)BOOL ischarge;

@end
