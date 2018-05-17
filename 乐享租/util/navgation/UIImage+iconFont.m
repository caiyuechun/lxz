//
//  UIImage+iconFont.m
//  PoliceExpressUser
//
//  Created by caiyc on 16/9/27.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "UIImage+iconFont.h"

@implementation UIImage (iconFont)
+ (UIImage*)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color {
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    label.font = [UIFont fontWithName:fontName size:size];
    label.textAlignment = 1;
    label.text = iconCode;
    if(color){
        label.textColor = color;
    }
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    return retImage;
}
+ (UIImage*)tabBarImageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color {
     CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGSize imageSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.font = [UIFont fontWithName:fontName size:size];
    label.textAlignment = 1;
    label.text = iconCode;
    if(color){
        label.textColor = color;
    }
    [label.layer renderInContext:ctx];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    return retImage;
}
@end
