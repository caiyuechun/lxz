//
//  ShareIndexCell.h
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareDeTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *cat_Name;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *contact_Lab;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *address_Lab;
@property (weak, nonatomic) IBOutlet UIScrollView *img_ScroView;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^clickImgs)(NSInteger);
@end
