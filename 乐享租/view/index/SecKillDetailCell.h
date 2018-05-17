//
//  SecKillDetailCell.h
//  chuangyi
//
//  Created by caiyc on 17/9/7.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecKillDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel1;
-(void)bindData:(NSDictionary *)dic;
@end
