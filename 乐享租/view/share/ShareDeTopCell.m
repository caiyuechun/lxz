//
//  ShareIndexCell.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ShareDeTopCell.h"

@implementation ShareDeTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.address_Lab LabelWithIconStr:@"\U0000e604" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:[UIColor whiteColor] andiconSize:15];
    [self.contact_Lab LabelWithIconStr:@"\U0000e609" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:[UIColor whiteColor] andiconSize:15];
    
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
    self.content.text = dic[@"goods"][@"goods_name"];
    self.remark.text = dic[@"goods"][@"goods_remark"];
    self.address.text = dic[@"goods"][@"cityname"];
    NSArray *img_Arr = dic[@"gallery"];
    self.cat_Name.text = dic[@"goods"][@"label"];
    self.img_ScroView.contentSize = CGSizeMake(130*img_Arr.count, 0);
    for(int i =0;i<img_Arr.count;i++){
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(100*i+(i*10), 10, 100, 100)];
        [images sd_setImageWithURL:[NSURL URLWithString:img_Arr[i][@"image_url"]] placeholderImage:[UIImage imageNamed:@"logo"]];
        
        [images setContentScaleFactor:[[UIScreen mainScreen] scale]];
        images.contentMode =  UIViewContentModeScaleAspectFill;
        images.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        images.clipsToBounds  = YES;
      //  images.image = [UIImage imageNamed:@"113.jpg"];
       // images.contentMode = UIViewContentModeScaleAspectFit;
        [self.img_ScroView addSubview:images];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100*i+(i*10), 10, 100, 100);
        btn.tag = i;
        [self.img_ScroView addSubview:btn];
        [btn addTarget:self action:@selector(clickImg:) forControlEvents:UIControlEventTouchUpInside];
    }

//    [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:dic[@"goods"][@"head_pic"]] placeholderImage:nil];
    
}
-(void)clickImg:(UIButton *)sender{
    self.clickImgs(sender.tag);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
