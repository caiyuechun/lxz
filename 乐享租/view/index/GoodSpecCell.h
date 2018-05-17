//
//  GoodSpecCell.h
//  chuangyi
//
//  Created by caiyc on 17/8/7.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHLUILabel.h"
@interface GoodSpecCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *gou1;
@property (weak, nonatomic) IBOutlet UILabel *guo2;
@property (weak, nonatomic) IBOutlet UILabel *gou3;
@property (weak, nonatomic) IBOutlet UIImageView *right2;
- (IBAction)checkFee:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *taozhuangNum;
- (IBAction)checkReport:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *saveLb;
- (IBAction)clickSpec:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
- (IBAction)clickGrup:(UIButton *)sender;
- (IBAction)clickRule:(UIButton *)sender;
@property(nonatomic,copy)void (^clickSpec)();
@property(nonatomic,copy)void(^clickGroup)();
@property (weak, nonatomic) IBOutlet UILabel *services;
@property(nonatomic,copy)void(^clickRuel)();
@property(nonatomic,copy)void(^checkreport)();
@end
