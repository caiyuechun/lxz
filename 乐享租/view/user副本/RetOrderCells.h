//
//  RetOrderCells.h
//  乐享租
//
//  Created by caiyc on 18/5/8.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetOrderCells : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *reason_Lab;
@property (weak, nonatomic) IBOutlet UILabel *order_Sn;
-(void)bindData:(NSDictionary *)diction;
@end
