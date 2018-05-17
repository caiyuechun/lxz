//
//  UILabel+IconLable.m
//  SHOP
//
//  Created by caiyc on 16/12/8.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "UILabel+IconLable.h"

@implementation UILabel (IconLable)
-(void)LabelWithIconStr:(NSString *)iconString inIcon:(NSString *)iconName andSize:(CGSize)size andColor:(UIColor *)color andiconSize:(CGFloat)iconLarge
{
    //UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //  [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    self.font = [UIFont fontWithName:iconfont size:iconLarge];
    [self setText:iconString ];
    [self setTextColor:color];
    //[btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    // [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    //CGRect frame = btn.frame;
    //frame.size = btn.currentBackgroundImage.size;
    //self.frame = CGRectMake(0, 0, size.width, size.height);
    
    
}

@end
