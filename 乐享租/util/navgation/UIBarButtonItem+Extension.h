//
//  UIBarButtonItem+Extension.h
//  BWPNavigationController
//
//  Created by BWP on 16/1/5.
//  Copyright © 2016年 BWP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action btnTitle:(NSString *)str;
@end
