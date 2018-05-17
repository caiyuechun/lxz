//
//  AppDelegate.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "AppDelegate.h"
#import "CPNavigation.h"
#import "IndexViewController.h"
#import "GroupViewController.h"
#import "SocailViewController.h"
#import "UserViewController.h"
#import "ShareViewController.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ZMCreditSDK/ALCreditService.h>
#import "MMExampleLeftSideDrawerViewController.h"
#import "SetViewController.h"
@interface AppDelegate (){
  
    CPNavigation *nav1;
    CPNavigation *nav2;
    CPNavigation *nav3;
    CPNavigation *nav4;
    CPNavigation *nav5;
    CPNavigation *rootNav;

    
}
@property(nonatomic, strong) UITabBarController *rootTabbarCtr;

@end

@implementation AppDelegate
-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}
-(NSString *)URLEncodedString:(NSString *)str
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
-(void)initRootVc{
//[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    IndexViewController *VC1 = [[IndexViewController alloc] init];
    nav1 = [[CPNavigation alloc] initWithRootViewController:VC1];
    nav1.navigationBarHidden = 1;
    //    InfoViewController *VC2 = [[InfoViewController alloc] init];
    GroupViewController *VC2 = [[GroupViewController alloc] init];
    nav2 = [[CPNavigation alloc] initWithRootViewController:VC2];
   // navCon = nav1;
    nav2.navigationBarHidden = 1;
    
   
    ShareViewController *VC3 = [[ShareViewController alloc]init];
    nav3 = [[CPNavigation alloc]initWithRootViewController:VC3];
    nav3.navigationBarHidden = 1;
    
    
    SocailViewController *VC4 = [[SocailViewController alloc] init];
    nav4 = [[CPNavigation alloc] initWithRootViewController:VC4];
    nav4.navigationBarHidden = 1;
    
    // PersonViewController *VC5 = [[PersonViewController alloc] init];
    UserViewController *VC5 = [[UserViewController alloc]init];
    nav5 = [[CPNavigation alloc] initWithRootViewController:VC5];
    nav5.navigationBarHidden = 1;
    
    VC1.title = @"首页";
    VC2.title = @"分类";
    VC3.title = @"共享";
    VC4.title = @"论坛";
    VC5.title = @"我的";
     NSArray *viewCtrs = @[nav1,nav2,nav3,nav4,nav5];
    self.rootTabbarCtr  = [[UITabBarController alloc] init];
    //4.
    [self.rootTabbarCtr setViewControllers:viewCtrs animated:YES];
    self.window.rootViewController = self.rootTabbarCtr;
    UITabBar *tabbar = self.rootTabbarCtr.tabBar;
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:2];
     UITabBarItem *item4 = [tabbar.items objectAtIndex:3];
     UITabBarItem *item5 = [tabbar.items objectAtIndex:4];
    
    item1.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e600", 25, [UIColor grayColor])];
    item2.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e631", 25,[UIColor grayColor])];
    item3.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e697", 25, [UIColor grayColor])];
    item4.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e633", 25, [UIColor grayColor])];
    //    item4.badgeValue = @"1";
    item5.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e607", 25, [UIColor grayColor])];
     [[UITabBar appearance]setBackgroundColor:[UIColor whiteColor]];
    self.rootTabbarCtr.tabBar.tintColor = RGB(177, 162, 120);
    rootNav = [[CPNavigation alloc]initWithRootViewController:self.rootTabbarCtr];
    rootNav.navigationBarHidden = 1;
//    MMExampleLeftSideDrawerViewController *setvc = [[MMExampleLeftSideDrawerViewController alloc]init];
//    self.drawerController = [[MMDrawerController alloc]
//                             initWithCenterViewController:rootNav
//                             leftDrawerViewController:setvc
//                            rightDrawerViewController:nil];
//    [self.drawerController setShowsShadow:NO];
//    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
//    [self.drawerController setMaximumRightDrawerWidth:200.0];
//    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//    
//    [self.drawerController
//     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//         MMDrawerControllerDrawerVisualStateBlock block;
//         block = [[MMExampleDrawerVisualStateManager sharedManager]
//                  drawerVisualStateBlockForDrawerSide:drawerSide];
//         if(block){
//             block(drawerController, drawerSide, percentVisible);
//         }
//     }];
    PPRevealSideViewController *slide = [[PPRevealSideViewController alloc]initWithRootViewController:rootNav];
    self.window.rootViewController =slide;


}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[ALCreditService sharedService]resgisterApp];
    [self initRootVc];
    /**初始化ShareSDK应用
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    
    [ShareSDK registerActivePlatforms:@[
                                      
                                        @(SSDKPlatformTypeWechat)
                                        
                                        
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;

             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {

             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4ecb2fc4f406d0c3"
                                       appSecret:@"821f1ed192dc5d1085eb1438df92bf4c"];
                 break;

                 break;
         }
     }];
    [WXApi registerApp:@"wx4ecb2fc4f406d0c3"];
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
        //解析resultDic
        // 解析 auth code
        NSString *result = resultDic[@"result"];
        NSString *authCode = nil;
        if (result.length>0) {
            NSArray *resultArr = [result componentsSeparatedByString:@"&"];
            for (NSString *subResult in resultArr) {
                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                    authCode = [subResult substringFromIndex:10];
                    break;
                }
            }
        }
        NSLog(@"授权结果 authCode = %@", authCode?:@"");
    }];
    
    
    NSString *str =  [url absoluteString];
    if([str containsString:@"true"])
    {
      [[NSNotificationCenter defaultCenter]postNotificationName:@"credited" object:nil];
    }
//    NSArray*resultArr = [str componentsSeparatedByString:@"&"];
//    
//    for(NSString*subResult in resultArr) {
//        
//        if( [subResult hasPrefix:@"passed="]) {
//            NSDictionary *dic = @{@"code":subResult};
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"credited" object:dic];
//            //authCode = [subResult substringFromIndex:10];
//            
//          //  break;
//            
//        }
//        
//    }

   
    
    return 1;
}
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
//
//}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
