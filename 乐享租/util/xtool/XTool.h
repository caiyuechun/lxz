//
//  XTool.h
//  tools
//
//  Created by caiyc on 16/9/9.
//  Copyright © 2016年 caiyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XTool : NSObject
+(CGRect)GetSceneRect;
+(void)SaveDefaultInfo:(id)str Key:(NSString*)_key;
+(id)GetDefaultInfo:(NSString*)_key;
+(UIImage*)scaleToSize:(CGSize)size ParentImage:(UIImage*)_PImage;
+(NSString*) md5:(NSString *)str;
+(NSString *) urlEncoderString:(NSString *)str;
+(BOOL)IsEmpty:(id)string;
+ (void)saveDataToLocal:(id)data toFileName:(NSString *)filename;
+ (NSString *)readFileOfFileDocuments:(NSString *)filename;
+(BOOL)isPureInt:(NSString*)string;
+(BOOL)isPureFloat:(NSString*)string;
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validateCarNo:(NSString *)carNo;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+(BOOL)validatePassWordLegal:(NSString *)pass;
+ (NSString *)convertArrayToString:(NSArray *)array;
+ (NSArray *)convertStringToArray:(NSString *)string sepStr:(NSString *)sepStr;
+ (long)getDocumentSize:(NSString *)folderName;
+ (BOOL)isHaveChineseInString:(NSString *)str;
+ (BOOL)isHaveSpaceInString:(NSString *)string;
+ (void)setLineSpaceWithString:(UILabel *)label height:(CGFloat)heigh;
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast;
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;
+ (UIImage *)shotScreen;
+ (UIImage *)shotWithView:(UIView *)view;
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame;
+ (NSString *)currentDateWithFormat:(NSString *)format;
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime lastTimeFormat:(NSString *)format1 ToCurrentTime:(NSString *)currentTime currentTimeFormat:(NSString *)format2;
+ (CGFloat)diskOfAllSizeMBytes;
+ (CGFloat)diskOfFreeSizeMBytes;
+(UIButton *)instaceSimpleButton:(CGRect)rect andtitle:(NSString *)btntitle andColor:(UIColor *)color addtoview:(UIView *)parentView parentVc:(UIViewController *)parentVc action:(SEL)action tag:(int )tags;
+(UIButton*)InstanceButton:(NSString*)FileName  FileName2:(NSString *)FileName2  RECT:(CGRect)_rect AddView:(UIView*)view ViewController:(UIViewController*)VC SEL_:(SEL)_sel Kind:(int)_Kind  TAG:(int)_index;
+(UILabel*)InstanceLabel:(NSString*)_Info RECT:(CGRect)_rect FontName:(NSString*)Name Red:(CGFloat)_red green:(CGFloat)green blue:(CGFloat)blue  FontSize:(int)_FontSize Target:(id)target Lines:(int)_lines TAG:(int)_index Ailgnment:(int)_ailgnment;
+(UITextField *)instanceTextField:(CGRect)rect andplaceholder:(NSString *)placeholder andTag:(int)tag addtoView:(UIView *)Pview andPvc:(UIViewController *)vc;
+(void)setShadow:(UIView *)view;
+(void)setViewCorner:(UIView *)view radius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color;
+(CGSize)caculatorStringHeigh:(NSString *)string width:(CGFloat)width CGfloat:(CGFloat)fontsize;
@end
