//
//  ContiRentViewController.h
//  乐享租
//
//  Created by caiyc on 18/5/8.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface BuyRentViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *rent_Price;
@property (weak, nonatomic) IBOutlet UITextView *notice_Tv;
@property (weak, nonatomic) IBOutlet UILabel *noti_Lab;
@property (weak, nonatomic) IBOutlet UIView *notice_View;
@property (weak, nonatomic) IBOutlet UIView *date_View;
@property (weak, nonatomic) IBOutlet UIView *order_FeeView;
@property (weak, nonatomic) IBOutlet UIView *corver_View;
@property (weak, nonatomic) IBOutlet UILabel *date_Lab;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice_Lab;
- (IBAction)clickRule:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *total_Amount;
- (IBAction)confirm:(UIButton *)sender;
@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *good_Id;
@end
