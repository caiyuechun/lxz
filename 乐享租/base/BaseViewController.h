//
//  BaseViewController.h
//  SHOP
//
//  Created by caiyc on 16/11/25.
//  Copyright © 2016年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
@interface BaseViewController : UIViewController

@property(nonatomic,copy)void(^success)(id jsonObject);
@property(nonatomic,assign)BOOL isNotMain;
@property(nonatomic,strong)UIView *naviView;
@property(nonatomic,strong)UILabel *notiLb;

//get请求方式
-(void)getRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes;
-(void)getRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params;
//post请求方式
-(void)postRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes;
-(void)postRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params;

- (void)initNavgationBarWithTitle:(NSString *)titleStr;

-(void)setNavgationBackGroundImgWithImgName:(NSString *)imgName;
-(void)setNavgationBackGroundImgWithImg:(UIImage *)img;
-(void)backRootController;
-(void)setNavgationBack;
-(UIButton *)getNavgationBackBtn;
-(void)backBtnAction:(id)sender;

-(void)setNavgationLeftWithName:(NSString *)name font:(UIFont *)font color:(UIColor *)color size:(CGSize)size action:(SEL)action;
-(void)setNavgationRightWithName:(NSString *)name font:(NSString *)font color:(UIColor *)color size:(CGSize)size action:(SEL)action;
-(void)setNavgationLeftWithImgName:(NSString *)normalImgName highlighted:(NSString *)highlightedImaName size:(CGSize)size action:(SEL)action;

-(void)setNavgationRightWithImgName:(NSString *)normalImgName highlighted:(NSString *)highlightedImaName size:(CGSize)size action:(SEL)action;
-(void)initTabBarItemWithTitle:(NSString *)titleStr normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg  tag:(NSInteger)tag;

-(void)setNavgationRightWithImgName:(NSString *)normalImgName highlighted:(NSString *)highlightedImaName size:(CGSize)size action:(SEL)action
                      normalImgName:(NSString *)normalImgName2 highlighted:(NSString *)highlightedImaName2 size:(CGSize)size2 action:(SEL)action2;
//多个网络请求并发
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)( id response))success
                 failure:(void (^)(NSError * error))failure;
- (void)getWithparameters:(id)parameters
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError * error))failure;//直接传参数的请求类型
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *error))failure;
- (void)postWithparameters:(id)parameters
                   success:(void (^)(id response))success
                   failure:(void (^)(NSError * error))failure;//直接传参数的请求类型
-(void)pushView:(UIViewController *)viewController;//从二级页面进入三级页面
-(void)pushSecondVC:(UIViewController *)VC;//从主页进入二级页面
-(void)pushViewAndAnimate:(UIViewController *)viewController;//带有动画
-(void)initNaviView:(UIColor *)color title:(NSString *)title haveLeft:(BOOL)left right:(NSString *)right  rightAction:(SEL)rightAction;
-(void)initNaviView:(UIColor *)navColor hasLeft:(BOOL)haveLeft leftColor:(UIColor *)leftColor title:(NSString *)title titleColor:(UIColor *)titleColor right:(NSString *)right rightColor:(UIColor *)rightColor rightAction:(SEL)rightAction;
-(void)setNotifationBage;
-(void)setNotifationBageNum:(NSInteger)num;
@end
