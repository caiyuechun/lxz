//
//  GoodsFlashCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/4.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "GoodsFlashCell.h"

@implementation GoodsFlashCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
-(void)bindData:(NSArray *)FlashArray
{
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_width)];
    scroView.contentSize = CGSizeMake(screen_width*FlashArray.count, screen_width);
    scroView.delegate = self;
    scroView.pagingEnabled = 1;
    scroView.showsHorizontalScrollIndicator = 0;
    scroView.tag = 1;
    if(FlashArray.count>0)
    {
        for(int i =0;i<FlashArray.count;i++)
        {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width*i, 0, screen_width, screen_width)];
         //   image.image = [UIImage imageNamed:@"114.jpg"];
           // image.backgroundColor = [UIColor grayColor];
            NSString *imageUrl = [FlashArray[i]objectForKey:@"image_url"];
            
            [image sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
         //   image.contentMode = UIViewContentModeScaleAspectFit;
            // image.image = [UIImage imageNamed:[NSString stringWithFormat:@"flash%d",i+1]];
            [scroView addSubview:image];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screen_width*i, 0, screen_width, screen_width);
            
            [btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            [scroView addSubview:btn];
            btn.tag = i;
        }
    }
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screen_width/2-20, screen_width-20, 0, 20)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = FlashArray.count;
    [_pageControl setCurrentPageIndicatorTintColor:BASE_COLOR];
    [_pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    
    //        self.backgroundColor = [UIColor redColor];
    
        //botomView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:scroView];
    [self addSubview:_pageControl];
   
    

    //  [self addSubview:botomView];

self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)clickItem:(UIButton *)sender
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
