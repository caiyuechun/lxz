//
//  SocailNoImgCell.h
//  乐享租
//
//  Created by caiyc on 18/5/11.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocailNoImgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *see_Count;
@property (weak, nonatomic) IBOutlet UILabel *like_Count;
@property (weak, nonatomic) IBOutlet UIImageView *thunm;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *like_Lab;
@property (weak, nonatomic) IBOutlet UILabel *seeCount_Lab;
-(void)bindData:(NSDictionary *)dic;
@end
