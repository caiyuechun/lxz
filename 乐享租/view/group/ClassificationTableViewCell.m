//
//  ClassificationTableViewCell.m
//  chuangyi
//
//  Created by yncc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "ClassificationTableViewCell.h"

@interface ClassificationTableViewCell ()
@end

@implementation ClassificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)bindData:(NSDictionary *)dicInfo{
    [self.lbTitle setText:[dicInfo objectForKey:@"name"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
