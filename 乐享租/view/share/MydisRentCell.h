//
//  MydisRentCell.h
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MydisRentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UIButton *handel_Btn;
@property (weak, nonatomic) IBOutlet UILabel *status_Lab;
@property (weak, nonatomic) IBOutlet UILabel *name_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
-(void)bindData:(NSDictionary *)dic;
@end
