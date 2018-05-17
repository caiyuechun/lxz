//
//  Index_RecomdCell.h
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Index_RecomdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *botm_Img;
@property (weak, nonatomic) IBOutlet UILabel *price_Lab;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *percent;
-(void)bindData:(NSDictionary *)dic;
@end
