//
//  SecTimeListCell.h
//  乐享租
//
//  Created by caiyc on 18/5/9.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecTimeListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel1;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
-(void)bindData:(NSDictionary *)dic;
@end
