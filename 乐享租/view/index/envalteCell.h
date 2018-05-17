//
//  envalteCell.h
//  SHOP
//
//  Created by caiyc on 17/3/15.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHLUILabel.h"
@interface envalteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moveLine;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet SHLUILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *start1;
@property (weak, nonatomic) IBOutlet UILabel *start2;
@property (weak, nonatomic) IBOutlet UILabel *start3;
@property (weak, nonatomic) IBOutlet UIScrollView *imgScroView;
@property (weak, nonatomic) IBOutlet UILabel *start4;
@property (weak, nonatomic) IBOutlet UILabel *start5;
@property (weak, nonatomic) IBOutlet UILabel *nickLb;

-(void)bindData:(NSDictionary *)dic andIndex:(NSInteger)idx andCount:(NSInteger)count;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^checkImage)(UIButton *);
@end
