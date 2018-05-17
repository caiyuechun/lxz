//
//  ShareIndexCell.h
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareIndexCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cat_Name;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *address_Lab;
@property (weak, nonatomic) IBOutlet UIScrollView *img_ScroView;
@property (weak, nonatomic) IBOutlet UILabel *contact_Lab;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *nick_Name;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UILabel *address;
-(void)bindData:(NSDictionary *)dic;
@end
