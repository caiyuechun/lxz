//
//  Index_EditRecmodCell.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "Index_EditRecmodCell.h"

@implementation Index_EditRecmodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg:)];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg:)];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg:)];

    [self.img1 addGestureRecognizer:tap];
    [self.img2 addGestureRecognizer:tap1];
    [self.img3 addGestureRecognizer:tap2];
    self.img1.userInteractionEnabled = 1;
    self.img2.userInteractionEnabled = 1;
    self.img3.userInteractionEnabled = 1;
    // Initialization code
}
-(void)clickimg:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag;
    self.clickitems(index);
}
-(void)bindData:(NSDictionary *)dic{
    NSArray *left = dic[@"adleft"];
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:left[0][@"ad_code"]] placeholderImage:[UIImage imageNamed:@"left-1"]];
    [self.img2 sd_setImageWithURL:[NSURL URLWithString:left[1][@"ad_code"]] placeholderImage:nil];
    NSDictionary *right = dic[@"adright"];
    [self.img3 sd_setImageWithURL:[NSURL URLWithString:right[@"ad_code"]] placeholderImage:nil];

}
- (IBAction)clickAction:(UIButton *)sender {
    self.clickitems(sender.tag);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clicks:(UIButton *)sender {
}
@end
