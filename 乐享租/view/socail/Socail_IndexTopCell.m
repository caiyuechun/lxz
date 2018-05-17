//
//  Socail_IndexTopCell.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "Socail_IndexTopCell.h"

@implementation Socail_IndexTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.notice_Lab LabelWithIconStr:@"\U0000e6a0" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor redColor] andiconSize:18];
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    self.notice_title.text = dic[@"notice"][@"title"];
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 180)];
    NSArray *image_Arr = dic[@"ad"];
    scroView.contentSize = CGSizeMake(screen_width*image_Arr.count, 0);
    for(int i =0;i<image_Arr.count;i++)
    {
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width*i, 0, screen_width, 180)];
        [images sd_setImageWithURL:[NSURL URLWithString:image_Arr[i][@"ad_code"]] placeholderImage:nil];
        [scroView addSubview:images];
    }
    [self addSubview:scroView];
    
    UIScrollView *catgroy_ScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 217, screen_width, 100)];
    UILabel *line_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 317, screen_width, 8)];
    line_Lab.backgroundColor = viewcontrollerColor;
    [self addSubview:line_Lab];
    catgroy_ScroView.showsHorizontalScrollIndicator = 0;
    NSArray *imageArrs = dic[@"category"];
    //    NSArray *imageArrs = @[@"cat_1.png",
    //                           @"cat_2.png",
    //                           @"cat_3.png",
    //                           @"cat_4.png",
    //                           @"cat_5.png"
    //                           ];
    //    NSArray *titleArrs = @[@"智能手机",@"数码相机",@"笔记本",@"3C配件",@"家用电器"];
    [catgroy_ScroView setContentSize:CGSizeMake(100*imageArrs.count+50, 100)];
    for(int i =0;i<imageArrs.count;i++){
        UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(100*i, 0, 100, 100)];
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 50, 50)];
        NSString *url = imageArrs[i][@"img"];
        [images sd_setImageWithURL:[NSURL URLWithString:url]];
        //  images.image = [UIImage imageNamed:imageArrs[i]];
        UILabel *title_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 100, 40)];
        title_Lab.text = imageArrs[i][@"cat_name"];
        title_Lab.font = [UIFont systemFontOfSize:15];
        title_Lab.textColor = BASE_GRAY_COLOR;
        [itemView addSubview:title_Lab];
        title_Lab.textAlignment = NSTextAlignmentCenter;
        
        [itemView addSubview:images];
        
        UIButton *item_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        item_Btn.frame = CGRectMake(0, 0, 100, 100);
        item_Btn.tag = i;
        [item_Btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [itemView addSubview:item_Btn];
        [catgroy_ScroView addSubview:itemView];
    }
    [self addSubview:catgroy_ScroView];

    
}
-(void)clickItem:(UIButton *)sender{
    self.clickCatogry(sender.tag);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
