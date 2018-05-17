//
//  UIBarButtonItem+Extension.m
//  BWPNavigationController
//
//  Created by BWP on 16/1/5.
//  Copyright © 2016年 BWP. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"


@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    btn.titleLabel.font = [UIFont fontWithName:iconfont size:25];
    [btn setTitle:@"\U0000e683" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
   // [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    //CGRect frame = btn.frame;
    //frame.size = btn.currentBackgroundImage.size;
    btn.frame = CGRectMake(0, 0, 32, 32);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action btnTitle:(NSString *)str
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    btn.titleLabel.font = [UIFont fontWithName:iconfont size:25];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //[btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    // [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    //CGRect frame = btn.frame;
    //frame.size = btn.currentBackgroundImage.size;
    btn.frame = CGRectMake(0, 0, 32, 32);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
