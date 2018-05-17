//
//  Socail_DeHeadCell.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Socail_DeHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UILabel *seeCount_Lab;
@property (weak, nonatomic) IBOutlet UILabel *see_Count;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
-(void)bindData:(NSDictionary*)dic;
@end
