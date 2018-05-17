//
//  MybolletViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface MybolletViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *keti_Lab;
@property (weak, nonatomic) IBOutlet UILabel *success_Lab;
@property (weak, nonatomic) IBOutlet UILabel *creit_Lab;
@property (weak, nonatomic) IBOutlet UILabel *nick_Lab;
- (IBAction)applyAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *balance_Btn;
@property (weak, nonatomic) IBOutlet UIButton *withDraw_Btn;
- (IBAction)checkDetail:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *credit_Lab;
@property (weak, nonatomic) IBOutlet UIView *credit_View;

@end
