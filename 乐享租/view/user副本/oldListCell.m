//
//  oldListCell.m
//  乐享租
//
//  Created by caiyc on 18/4/26.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "oldListCell.h"

@implementation oldListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icon.layer.masksToBounds = 1;
    self.icon.layer.cornerRadius = 25;
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic
{
    NSString *nick_str = dic[@"nickname"];
    NSString *newStr ;
    if(nick_str.length>1){
        newStr =   [nick_str stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
    }
    self.nickLb.text = newStr;
    self.time.text = dic[@"on_time"];
    self.content.text = [dic[@"goods_remark"]isEqualToString:@""]?@"咋内内容":dic[@"goods_remark"];
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
    [self.icon sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"logo"]];
    
    NSLog(@"内容===%@",dic[@"content"]);
    
    //    //评论的图片先隐藏
    if([dic[@"imgs"]isKindOfClass:[NSArray class]])
    {
        self.imgScroView.contentSize = CGSizeMake(90*[dic[@"imgs"]count]+90, 125);
        self.imgScroView.showsHorizontalScrollIndicator = 0;
        for(int i =0;i<[dic[@"imgs"]count];i++)
        {
            UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(8*(i+1)+80*i, 24, 80, 80)];
            NSString *urlStr = [NSString stringWithFormat:@"%@",dic[@"imgs"][i]];
            [images sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"logo"]];
            [images setContentScaleFactor:[[UIScreen mainScreen] scale]];
            images.contentMode =  UIViewContentModeScaleAspectFill;
            images.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            images.clipsToBounds  = YES;
           // images.contentMode = UIViewContentModeScaleAspectFit;
            [self.imgScroView addSubview:images];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(100*i, 12, 100, 100);
            [self.imgScroView addSubview:btn];
            btn.tag = i;
           // [btn addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    if([dic[@"goods_remark"]isEqualToString:@""])
    {
        CGFloat commentHei = 20;
        self.content.frame = CGRectMake(self.content.frame.origin.x, 61, screen_width-20, commentHei);
        if([dic[@"imgs"]count]>0)
        {
            self.imgScroView.frame = CGRectMake(76, commentHei+61, screen_width, 125);
        }else self.imgScroView.frame = CGRectMake(76, commentHei+61, screen_width, 0);
    }else
    {
        CGFloat commentHei = [self.content getAttributedStringHeightWidthValue:screen_width-20];
        self.content.frame = CGRectMake(self.content.frame.origin.x, 61, screen_width-20, commentHei);
        if([dic[@"imgs"]count]>0)
        {
            self.imgScroView.frame = CGRectMake(76, commentHei+61, screen_width, 125);
        }
        else self.imgScroView.frame = CGRectMake(76, commentHei+61, screen_width, 0);
    }
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(76, self.imgScroView.frame.origin.y+10+self.imgScroView.frame.size.height, 100, 30);
    [cancelBtn setTitle:@"去发货" forState:UIControlStateNormal];
    // cancelBtn.backgroundColor = PRICECOLOR;
    cancelBtn.layer.cornerRadius = 15;
    cancelBtn.layer.masksToBounds = 1;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(develive) forControlEvents:UIControlEventTouchUpInside];
    if([dic[@"deliver"]integerValue]==1){
        [self addSubview:cancelBtn];
    }
    //[self addSubview:cancelBtn];

    self.moveLine.frame = CGRectMake(10, self.imgScroView.frame.size.height+self.imgScroView.frame.origin.y+5, screen_width-10, 1);
    self.contentView.frame = CGRectMake(0, 0, screen_width, self.imgScroView.frame.size.height+self.imgScroView.frame.origin.y);
    
}
-(void)develive{
    self.delevier();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
