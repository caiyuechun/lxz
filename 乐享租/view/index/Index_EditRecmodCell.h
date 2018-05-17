//
//  Index_EditRecmodCell.h
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Index_EditRecmodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img1;
- (IBAction)clicks:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^clickitems)(NSInteger);
@end
