//
//  LeftSlideCell.h
//  乐享租
//
//  Created by caiyc on 18/5/10.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftSlideCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
- (IBAction)leftAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *nick_Lab;
@property (weak, nonatomic) IBOutlet UILabel *shop_Icon;
@property (weak, nonatomic) IBOutlet UILabel *order_Icon;
@property (weak, nonatomic) IBOutlet UILabel *money_Icon;
@property (weak, nonatomic) IBOutlet UILabel *noti_Icon;
@property (weak, nonatomic) IBOutlet UILabel *noti_Num;
@property (weak, nonatomic) IBOutlet UILabel *shop_Num;
@property (weak, nonatomic) IBOutlet UILabel *order_Num;
@property(nonatomic,copy)void (^leftActions)(NSInteger);
@end
