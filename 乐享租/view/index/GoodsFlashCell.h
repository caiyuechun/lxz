//
//  GoodsFlashCell.h
//  chuangyi
//
//  Created by caiyc on 17/8/4.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsFlashCell : UITableViewCell<UIScrollViewDelegate>
{
    UIPageControl *_pageControl;
}
-(void)bindData:(NSArray *)FlashArray;
@end
