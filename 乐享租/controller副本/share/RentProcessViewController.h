//
//  RentProcessViewController.h
//  乐享租
//
//  Created by caiyc on 18/5/2.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface RentProcessViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *next_Btn;
- (IBAction)checkAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *check_Lab;
@property (weak, nonatomic) IBOutlet UIWebView *webVIew;
- (IBAction)nextAction:(UIButton *)sender;

@end
