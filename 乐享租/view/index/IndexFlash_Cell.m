//
//  IndexFlash_Cell.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "IndexFlash_Cell.h"

@implementation IndexFlash_Cell
-(void)bindData:(NSDictionary *)dic{
    
    NSArray *imageArr = dic[@"ad"];
    NSMutableArray *image_Arrs = [NSMutableArray array];
    for(int i =0;i<imageArr.count;i++){
        [ image_Arrs addObject:imageArr[i][@"ad_code"]];
    }
    DCCycleScrollView *banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, screen_width, 180) shouldInfiniteLoop:YES imageGroups:image_Arrs];
    
    banner.autoScrollTimeInterval = 5;
    banner.autoScroll = YES;
    banner.isZoom = YES;
    banner.itemSpace = 1;
    banner.imgCornerRadius = 10;
    banner.itemWidth = self.frame.size.width - 30;
    banner.delegate = self;
    [self addSubview:banner];
    
    UIScrollView *catgroy_ScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, screen_width, 100)];
    catgroy_ScroView.showsHorizontalScrollIndicator = 0;
    NSArray *imageArrs = dic[@"categorylist"];
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
        NSString *url = imageArrs[i][@"image"];
        [images sd_setImageWithURL:[NSURL URLWithString:url]];
      //  images.image = [UIImage imageNamed:imageArrs[i]];
        UILabel *title_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 100, 40)];
        title_Lab.text = imageArrs[i][@"name"];
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
- (void)awakeFromNib {
    [super awakeFromNib];
//    NSArray *imageArr = @[@"114.jpg",
//                          @"left-1.jpg",
//                          @"left-2.jpg",
//                          @"114.jpg",
//                          ];
//    DCCycleScrollView *banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, screen_width, 180) shouldInfiniteLoop:YES imageGroups:imageArr];
//   
//    banner.autoScrollTimeInterval = 5;
//    banner.autoScroll = YES;
//    banner.isZoom = YES;
//    banner.itemSpace = 10;
//    banner.imgCornerRadius = 10;
//    banner.itemWidth = self.frame.size.width - 60;
//    banner.delegate = self;
//    [self addSubview:banner];
//    
//    UIScrollView *catgroy_ScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, screen_width, 100)];
//    catgroy_ScroView.showsHorizontalScrollIndicator = 0;
//    NSArray *imageArrs = @[@"cat_1.png",
//                          @"cat_2.png",
//                          @"cat_3.png",
//                          @"cat_4.png",
//                          @"cat_5.png"
//                          ];
//    NSArray *titleArrs = @[@"智能手机",@"数码相机",@"笔记本",@"3C配件",@"家用电器"];
//    [catgroy_ScroView setContentSize:CGSizeMake(100*imageArrs.count+50, 100)];
//    for(int i =0;i<imageArrs.count;i++){
//        UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(100*i, 0, 100, 100)];
//        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 50, 50)];
//        images.image = [UIImage imageNamed:imageArrs[i]];
//        UILabel *title_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 100, 40)];
//        title_Lab.text = titleArrs[i];
//        title_Lab.font = [UIFont systemFontOfSize:15];
//        title_Lab.textColor = BASE_GRAY_COLOR;
//        [itemView addSubview:title_Lab];
//        title_Lab.textAlignment = NSTextAlignmentCenter;
//        
//        [itemView addSubview:images];
//        
//        UIButton *item_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        item_Btn.frame = CGRectMake(0, 0, 100, 100);
//        item_Btn.tag = i;
//        [item_Btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
//        [itemView addSubview:item_Btn];
//        [catgroy_ScroView addSubview:itemView];
//    }
//    [self addSubview:catgroy_ScroView];
    // Initialization code
}
-(void)clickItem:(UIButton *)sender{
   self.clickCatogry(sender.tag,1);
}
//点击图片的代理
-(void)cycleScrollView:(DCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"index = %ld",index);
    self.clickCatogry(index,0);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
