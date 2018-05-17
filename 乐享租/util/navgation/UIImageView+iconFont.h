//
//  UIImageView+iconFont.h
//  PoliceExpressUser
//
//  Created by caiyc on 16/9/27.
//  Copyright © 2016年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (iconFont)
+ (UIImage*)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color;
+ (UIImage*)tabBarImageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color;
@end
