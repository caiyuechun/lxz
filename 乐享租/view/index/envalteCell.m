//
//  envalteCell.m
//  SHOP
//
//  Created by caiyc on 17/3/15.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "envalteCell.h"

@implementation envalteCell

- (void)awakeFromNib {
    [super awakeFromNib];
     [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds = 1;
   // self.backgroundColor = [UIColor grayColor];
   //self.nickLb.text = @"你大爷";
   // self.content.text = @"这次购物非常满意，五星好评";
//    [self.start1 LabelWithIconStr:@"\U0000e68a" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor grayColor] andiconSize:15];
//    [self.start1 LabelWithIconStr:@"\U0000e68a" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor grayColor] andiconSize:15];
//    [self.start1 LabelWithIconStr:@"\U0000e68a" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor grayColor] andiconSize:15];
//    [self.start1 LabelWithIconStr:@"\U0000e68a" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor grayColor] andiconSize:15];
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic andIndex:(NSInteger)idx andCount:(NSInteger)count
{
    NSString *str = dic[@"username"];
    if(str.length>1){
        [str stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
    }
    self.nickLb.text = str;
    self.content.text = dic[@"content"];
  //  self.time.text = dic[@"add_time"];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"head_pic"]] placeholderImage:[UIImage imageNamed:@"goods_icon"]];
    NSLog(@"内容===%@",dic[@"content"]);
   
//  //评论的图片先隐藏
//    if([dic[@"img"]count]>0)
//    {
//    self.imgScroView.contentSize = CGSizeMake(90*[dic[@"img"]count]+90, 90);
//        self.imgScroView.showsHorizontalScrollIndicator = 0;
//    for(int i =0;i<[dic[@"img"]count];i++)
//    {
//        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(8*(i+1)+80*i, 5, 80, 80)];
//        NSString *urlStr = [NSString stringWithFormat:@"%@",dic[@"img"][i]];
//        [images sd_setImageWithURL:[NSURL URLWithString:urlStr]];
//        [self.imgScroView addSubview:images];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(100*i, 0, 100, 100);
//        [self.imgScroView addSubview:btn];
//        btn.tag = i;
//        [btn addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    }
    if([dic[@"content"]isEqualToString:@""])
    {
         CGFloat commentHei = 20;
         self.content.frame = CGRectMake(self.content.frame.origin.x, 61, screen_width-20, commentHei);
        
    }else
    {
    CGFloat commentHei = [self.content getAttributedStringHeightWidthValue:screen_width-20];
    self.content.frame = CGRectMake(self.content.frame.origin.x, 61, screen_width-20, commentHei);
//        if([dic[@"img"]count]>0)
//        {
//            self.imgScroView.frame = CGRectMake(0, commentHei+61, screen_width, 100);
//        }
    }


    
}
-(void)bindData:(NSDictionary *)dic
{
    NSString *nick_str = dic[@"username"];
    NSString *newStr ;
    if(nick_str.length>1){
     newStr =   [nick_str stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
    }
    self.nickLb.text = newStr;
   self.content.text = [dic[@"content"]isEqualToString:@""]?@"咋内内容":dic[@"content"];
  //  self.time.text = [NSDate dateChangetime: dic[@"add_time"]];
    NSString *str = dic[@"head_pic"];
    NSString *urlStr = @"";
    if([str rangeOfString:@"http://"].location !=NSNotFound)//_roaldSearchText
    {
        
        urlStr = str;
    }
    else
    {
        urlStr = [NSString stringWithFormat:@"%@%@",BASE_SERVICE,str];
    }
    NSLog(@"头像地址%@",urlStr);
    [self.icon sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"1131.jpg"]];
    
    NSLog(@"内容===%@",dic[@"content"]);
    
    //    //评论的图片先隐藏
    if([dic[@"img"]isKindOfClass:[NSArray class]])
    {
        self.imgScroView.contentSize = CGSizeMake(90*[dic[@"img"]count]+90, 125);
        self.imgScroView.showsHorizontalScrollIndicator = 0;
        for(int i =0;i<[dic[@"img"]count];i++)
        {
            UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(8*(i+1)+80*i, 24, 80, 80)];
            NSString *urlStr = [NSString stringWithFormat:@"%@",dic[@"img"][i]];
            [images sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"113.jpg"]];
            images.contentMode = UIViewContentModeScaleAspectFit;
            [self.imgScroView addSubview:images];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100*i, 12, 100, 100);
            [self.imgScroView addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    if([dic[@"content"]isEqualToString:@""])
    {
        CGFloat commentHei = 20;
        self.content.frame = CGRectMake(self.content.frame.origin.x, 61, screen_width-20, commentHei);
        if([dic[@"img"]count]>0)
        {
            self.imgScroView.frame = CGRectMake(0, commentHei+61, screen_width, 125);
        }else self.imgScroView.frame = CGRectMake(0, commentHei+61, screen_width, 0);
    }else
    {
        CGFloat commentHei = [self.content getAttributedStringHeightWidthValue:screen_width-20];
        self.content.frame = CGRectMake(self.content.frame.origin.x, 61, screen_width-20, commentHei);
        if([dic[@"img"]count]>0)
        {
            self.imgScroView.frame = CGRectMake(0, commentHei+61, screen_width, 125);
        }
        else self.imgScroView.frame = CGRectMake(0, commentHei+61, screen_width, 0);
    }
    self.moveLine.frame = CGRectMake(10, self.imgScroView.frame.size.height+self.imgScroView.frame.origin.y+5, screen_width-10, 1);
    self.contentView.frame = CGRectMake(0, 0, screen_width, self.imgScroView.frame.size.height+self.imgScroView.frame.origin.y);

}
-(void)checkImage:(UIButton *)sender
{
    self.checkImage(sender);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
