//
//  GroupCell.h
//  SHOP
//
//  Created by caiyc on 16/12/1.
//  Copyright © 2016年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *button;
-(void)bindData:(NSDictionary *)diction;
@property(copy,nonatomic)void (^click)();
@end
