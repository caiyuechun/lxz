//
//  UserViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface UserViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *creit_Lab;
@property (weak, nonatomic) IBOutlet UILabel *message_Lab;
- (IBAction)checkMeaaAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *nick_Lab;
- (IBAction)refundAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *money_Lab;
- (IBAction)mymoneyAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *order_View;
@property (weak, nonatomic) IBOutlet UIView *funView;

@end
