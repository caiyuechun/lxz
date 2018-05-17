//
//  ActiveNotiCell.h
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveNotiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
-(void)bindData:(NSDictionary *)dic;
@end
