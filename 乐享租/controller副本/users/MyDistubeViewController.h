//
//  MyDistubeViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/22.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface MyDistubeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *down_Lab;
@property (weak, nonatomic) IBOutlet UIView *order_View;
@property (weak, nonatomic) IBOutlet UILabel *right_Lab;
- (IBAction)checkMyScoail:(UIButton *)sender;

@end
