//
//  Socail_ComentCell.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Socail_ComentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *content;
-(void)bindData:(NSDictionary *)dic;
@end
