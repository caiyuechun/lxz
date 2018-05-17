//
//  ShareIndexCell.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ShareIndexCell.h"

@implementation ShareIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    [self.address_Lab LabelWithIconStr:@"\U0000e604" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:[UIColor whiteColor] andiconSize:15];
    self.icon_Img.layer.masksToBounds = 1;
    self.icon_Img.layer.cornerRadius = 25;
    self.img_ScroView.contentSize = CGSizeMake(130*4, 0);
    self.img_ScroView.showsHorizontalScrollIndicator = 0;
    self.address.layer.masksToBounds = 1;
    self.address.layer.cornerRadius = 5;
//    for(int i =0;i<4;i++){
//        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(100*i+(i*10), 10, 100, 100)];
//        images.image = [UIImage imageNamed:@"113.jpg"];
//        images.contentMode = UIViewContentModeScaleAspectFit;
//        [self.img_ScroView addSubview:images];
//    }
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:dic[@"head_pic"]] placeholderImage:nil];
    self.nick_Name.text = [dic[@"nickname"]isEqualToString:@""]?dic[@"nickname"]:@"租客007";
    self.cat_Name.text = dic[@"label"];
    self.time_Lab.text = dic[@"on_time"];
    self.address.text = dic[@"cityname"];
    self.content.text = dic[@"goods_name"];
    NSArray *img_Arr = dic[@"imgs"];
    for(int i =0;i<img_Arr.count;i++){
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(100*i+(i*10), 10, 100, 100)];
     //   images.image = [UIImage imageNamed:@"113.jpg"];
        [ images sd_setImageWithURL:[NSURL URLWithString:img_Arr[i]] placeholderImage: [UIImage imageNamed:@"logo"]];
        [images setContentScaleFactor:[[UIScreen mainScreen] scale]];
        images.contentMode =  UIViewContentModeScaleAspectFill;
        images.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        images.clipsToBounds  = YES;

       // images.contentMode = UIViewContentModeScaleAspectFit;
        [self.img_ScroView addSubview:images];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
