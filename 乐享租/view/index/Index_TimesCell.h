//
//  Index_TimesCell.h
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Index_TimesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *more_Btn;
@property (weak, nonatomic) IBOutlet UILabel *showLab1;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (strong, nonatomic)  UILabel *secondLabel;
@property (strong, nonatomic)  UILabel *minuteLabel;
@property (strong, nonatomic)  UILabel *hourLabel1;
@property (strong, nonatomic)  UILabel *dayLabel;
-(void)bindData:(NSArray *)data;
@property (weak, nonatomic) IBOutlet UILabel *more_Lab;
@property(copy,nonatomic)void (^clickitem)(NSInteger index);
@property(nonatomic,copy)void (^more)();
@end
