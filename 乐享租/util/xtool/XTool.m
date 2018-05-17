//
//  XTool.m
//  tools
//
//  Created by caiyc on 16/9/9.
//  Copyright © 2016年 caiyc. All rights reserved.
//

#import "XTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation XTool
/*
 获得机型大小
 */
+(CGRect)GetSceneRect
{
    return [[UIScreen mainScreen] bounds];
}
/*
 *保存default信息
 *srt:需保存的文字
 *key:关键字
 */
+(void)SaveDefaultInfo:(id)str Key:(NSString*)_key
{
    NSUserDefaults *standardUserDefault = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefault setValue:str forKey:_key];
    
    [standardUserDefault synchronize];
}
/*
 *获得保存default信息
 *key:关键字
 */
+(id)GetDefaultInfo:(NSString*)_key
{
    id temp  =  [[NSUserDefaults standardUserDefaults] objectForKey:_key];
    if(  temp == nil )
    {
        return nil;
    }
    return temp;
}
/*
 * 攻能：图片等比例缩放，上下左右留白
 * size:缩放的width,height
 * _pimage:需要改变的图片
 */
+(UIImage*)scaleToSize:(CGSize)size ParentImage:(UIImage*)_PImage
{
    CGFloat width = CGImageGetWidth(_PImage.CGImage);
    CGFloat height = CGImageGetHeight(_PImage.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [_PImage drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
/*
 字符串MD5 加密
 */
+(NSString*) md5:(NSString *)str

{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
 //   return nil;
//    const char *cStr = [str UTF8String];
//    
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    
//    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
//    
//    NSString* tmp = [NSString stringWithFormat:
//                     
//                     @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//                     
//                     result[0], result[1], result[2], result[3], result[4],
//                     
//                     result[5], result[6], result[7],
//                     
//                     result[8], result[9], result[10], result[11], result[12],
//                     
//                     result[13], result[14], result[15]
//                     
//                     ];
//    
//    tmp = [tmp lowercaseString];
//    return tmp;
}

/*
 url格式化编译
 */
+(NSString *) urlEncoderString:(NSString *)str
{
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                              (CFStringRef)str,
                                                                                              NULL,
                                                                                              (CFStringRef)@";/?:@&=$+{}<>,",
                                                                                              kCFStringEncodingUTF8));
    /* 上面意思就是把 str转化为网络上可以传输的标准格式
     CFStringRef就是一个C语言的NSString类
     CF = CoreFoundation
     (CFStringRef)@";/?:@&=$+{}<>," 表示这些不用转化
     */
    return result;
}

//为空判断
+(BOOL)IsEmpty:(id)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    } else {
        return NO;
    }
    
}
//判断字符串中是否有中文字符
+ (BOOL)isHaveChineseInString:(NSString *)str {
    
    for(int i=0; i< [str length];i++) {
        
        int a = [str characterAtIndex:i];
        
        if( a >0x4e00 && a < 0x9fff) {
            
            return YES;
            
        }
        
    } return NO;
    
}
//判断字符串中是否有空格
+ (BOOL)isHaveSpaceInString:(NSString *)string{
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

//判断字符串是否纯数字
+ (BOOL)isPureInteger:(NSString *)str {
    NSScanner *scanner = [NSScanner scannerWithString:str];
    NSInteger val;
    return [scanner scanInteger:&val] && [scanner isAtEnd];
}
// 保存小型数据到本地“FileDocuments”目录
+ (void)saveDataToLocal:(id)data toFileName:(NSString *)filename {
    // 指向文件目录
    NSString *plistFilePath= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FileDocuments"];
    
    // 判断目录是否存在,不存在创建目录
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistFilePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:plistFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 文件保持路径
    NSString *filePath= [plistFilePath stringByAppendingPathComponent:filename];
    [data writeToFile:filePath atomically:YES];     //写入文件
}
// 读取本地“FileDocuments”目录下的文件
+ (NSString *)readFileOfFileDocuments:(NSString *)filename {
    // 指向文件目录
    NSString *plistFilePath= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FileDocuments"];
    
    // 文件路径
    NSString *filePath= [plistFilePath stringByAppendingPathComponent:filename];
    // 文件存在判断
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // 读取文件
        return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    } else {
        return @"";
    }
}
//判断是否为整形：
+(BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}


//判断是否为浮点形：
+(BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
//邮箱正则
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//电话正则
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((17[0-9])|(13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//车牌正则
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
//身份证正则
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//正则密码
+(BOOL)validatePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//把数组转换为字符串。
+ (NSString *)convertArrayToString:(NSArray *)array{
    NSMutableString *string = [NSMutableString stringWithCapacity:0];
    for( NSInteger i=0;i<[array count];i++ ){
        [string appendFormat:@"%@%@",(NSString *)array[i], (i<([array count]-1))?@",":@""];
    }
    return string;
}
//字符串转换为数组。
+ (NSArray *)convertStringToArray:(NSString *)string sepStr:(NSString *)sepStr
{
    //sepStr 分割符
    return [string componentsSeparatedByString:sepStr];
}
//获取文件的大小。
+ (long)getDocumentSize:(NSString *)folderName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat: @"/%@/", folderName]];
    //    NSDictionary *fileAttributes = [fileManager attributesOfFileSystemForPath:documentsDirectory error:nil];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:documentsDirectory error:nil];
    
    long size = 0;
    if(fileAttributes != nil)
    {
        NSNumber *fileSize = fileAttributes[NSFileSize];
        size = [fileSize longValue];
    }
    return size;
}
//设置lable行间距
+ (void)setLineSpaceWithString:(UILabel *)label height:(CGFloat)heigh
{
    
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:heigh];
    
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
}
//将十六进制颜色值转换为 UIColor 对象
+ (UIColor *)colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
#pragma mark - 对图片进行滤镜处理
// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:name];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}
#pragma mark - 对图片进行模糊处理
// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter;
    if (name.length != 0) {
        filter = [CIFilter filterWithName:name];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![name isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radius) forKey:@"inputRadius"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }else{
        return nil;
    }
}
#pragma mark 调整图片的饱和度，亮度，对比度
/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param image      目标图片
 *  @param saturation 饱和度
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度
 *
 */
+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image
                                 saturation:(CGFloat)saturation
                                 brightness:(CGFloat)brightness
                                   contrast:(CGFloat)contrast{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImage;
}
//创建一张实时模糊效果的view(毛玻璃效果)
//Avilable in iOS 8.0 and later
+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}
//全屏截图
+ (UIImage *)shotScreen{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.bounds.size);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//截取view生成一张图片
+ (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//获取当前时间
//format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
+ (NSString *)currentDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}

/** 
 * 计算上次日期距离现在多久
 * 
 * @param lastTime 上次日期(需要和格式对应) 
 * @param format1 上次日期格式 
 * @param currentTime 最近日期(需要和格式对应)
 * @param format2 最近日期格式 *
 * @return xx分钟前、xx小时前、xx天前 
 使用举例：NSLog(@"\n\nresult: %@", [XTool timeIntervalFromLastTime:@"2015年12月8日 15:50" lastTimeFormat:@"yyyy年MM月dd日 HH:mm" ToCurrentTime:@"2015/12/08 16:12" currentTimeFormat:@"yyyy/MM/dd HH:mm"]);
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime lastTimeFormat:(NSString *)format1 ToCurrentTime:(NSString *)currentTime currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [XTool timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}
+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{ NSTimeZone *timeZone = [NSTimeZone systemTimeZone]; //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:
                [timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    if (minutes <= 10) { return @"刚刚"; }
    else if (minutes < 60){ return [NSString stringWithFormat: @"%ld分钟前",(long)minutes]; }
    else if (hours < 24){ return [NSString stringWithFormat: @"%ld小时前",(long)hours]; }
    else if (day < 30){ return [NSString stringWithFormat: @"%ld天前",(long)day]; }
    else if (month < 12){ NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日"; NSString * time = [df stringFromDate:lastDate]; return time; }
    else if (yers >= 1){ NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;}
    return @"";
}
//磁盘总空间大小
+ (CGFloat)diskOfAllSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;//单位M
}
//磁盘可用空间大小
+ (CGFloat)diskOfFreeSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;//单位M
}
#pragma mark 控件部分
/**
 *  简单的文字按钮
 *
 *  @param rect       frame
 *  @param btntitle   文字
 *  @param parentView 父视图
 *  @param parentVc   所属控制器
 *  @param action     方法
 *  @param tags       tag标识
 *
 *  @return uibutton对象
 */
+(UIButton *)instaceSimpleButton:(CGRect)rect andtitle:(NSString *)btntitle andColor:(UIColor *)color addtoview:(UIView *)parentView parentVc:(UIViewController *)parentVc action:(SEL)action tag:(int )tags
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = rect;
    btn.layer.cornerRadius = 5;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitle:btntitle forState:UIControlStateNormal];
    [btn addTarget:parentVc action:action forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:btn];
    btn.tag = tags;
    return btn;
}
/**
 *  图片按钮
 *
 *  @param FileName  正常状态按键的图片名
 *  @param FileName2 按下状态的图片吗
 *  @param _rect     位置
 *  @param view      父视图
 *  @param VC        所属控制器
 *  @param _sel      方法
 *  @param _Kind     类别
 *  @param _index    tag标识
 *
 *
 *  @return button对象
 */
+(UIButton*)InstanceButton:(NSString*)FileName  FileName2:(NSString *)FileName2  RECT:(CGRect)_rect AddView:(UIView*)view ViewController:(UIViewController*)VC SEL_:(SEL)_sel Kind:(int)_Kind  TAG:(int)_index
{
    UIButton* button    =   [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame =   _rect;
    
    
    if( _Kind == 1 )
    {
        
        [button setBackgroundImage:[UIImage imageNamed:FileName] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:FileName2] forState:UIControlStateHighlighted];
    }
    else if (_Kind==2)
    {
        [button setImage:[UIImage imageNamed:FileName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:FileName2] forState:UIControlStateHighlighted];

    }
    [button addTarget:VC action:_sel forControlEvents:UIControlEventTouchUpInside];
    button.tag  =  _index;
    [view addSubview:button];
    return button;


}
+(UILabel*)InstanceLabel:(NSString*)_Info RECT:(CGRect)_rect FontName:(NSString*)Name Red:(CGFloat)_red green:(CGFloat)green blue:(CGFloat)blue  FontSize:(int)_FontSize Target:(id)target Lines:(int)_lines TAG:(int)_index Ailgnment:(int)_ailgnment//1：中，2：左，3：右
{
    UILabel* label  =   [[UILabel alloc] initWithFrame:_rect];
    
    
    label.frame =   _rect;
    
    label.text      =   _Info;
    switch (_ailgnment) {
        case 1:
            label.textAlignment =   NSTextAlignmentCenter;
            break;
        case 2:
            label.textAlignment =   NSTextAlignmentLeft;
            break;
        case 3:
            label.textAlignment =   NSTextAlignmentRight;
            break;
        default:
            break;
    }
    label.backgroundColor   =   [UIColor clearColor];
    
    label.numberOfLines =  0;// _lines;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:_FontSize];
   // [FuncPublic ChangeLable:&label FontName:Name Red:_red green:green blue:blue FontSize:_FontSize];
    
    if ([Name  isEqual: @""]) {
        // label.font = [UIFont fontWithName:FONT_ONE size:_FontSize];
    }
    label.tag   =   _index;
    // label.font = [UIFont fontWithName:@"Zapfino" size:_FontSize];
    [(UIView*)target addSubview:label];
    //[label release];
    return label;
}
+(UITextField *)instanceTextField:(CGRect)rect andplaceholder:(NSString *)placeholder andTag:(int)tag addtoView:(UIView *)Pview andPvc:(UIViewController *)vc
{
    UITextField *field = [[UITextField alloc]initWithFrame:rect];
    field.placeholder = placeholder;
    field.tag= tag;
    [Pview addSubview:field];
    return field;
}
+(void)setShadow:(UIView *)view
{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowOpacity=1;
    view.layer.shadowRadius=3;
}
+(void)setViewCorner:(UIView *)view radius:(CGFloat)radius width:(CGFloat)width color:(UIColor *)color
{
    //view.layer.shouldRasterize = 1;
    view.layer.masksToBounds = 1;
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
}
+(CGSize)caculatorStringHeigh:(NSString *)string width:(CGFloat)width CGfloat:(CGFloat)fontsize
{
    //    titleLabel.font = [UIFont systemFontOfSize:14];
    //    NSString *titleContent = @"亲，欢迎您通过以下方式与我们的营销顾问取得联系，交流您再营销推广工作中遇到的问题，营销顾问将免费为您提供咨询服务。";
    //    titleLabel.text = titleContent;
    //    titleLabel.numberOfLines = 0;//多行显示，计算高度
    //    titleLabel.textColor = [UIColor lightGrayColor];
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size;
    return titleSize;
}
//+ (NSString *)platform {
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    
//    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
//    
//    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
//    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
//    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
//    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
//    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
//    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
//    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
//    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
//    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
//    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
//    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
//    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
//    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
//    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
//    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
//    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
//    
//    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
//    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
//    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
//    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
//    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
//    if ([platform isEqualToString:@"iPod7,1"])   return @"iPod Touch 6G";
//    
//    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
//    
//    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
//    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
//    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
//    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
//    
//    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
//    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
//    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
//    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
//    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
//    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
//    
//    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
//    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
//    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
//    
//    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
//    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
//    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
//    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3G";
//    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad Mini 3G";
//    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3G";
//    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad Mini 4G";
//    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4G";
//    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
//    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
//    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro (9.7 inch)";
//    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro (9.7 inch)";
//    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro (12.9 inch)";
//    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro (12.9 inch)";
//    
//    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
//    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
//    return platform;
//}
@end
