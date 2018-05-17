//
//  AppDelegate.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) MMDrawerController * drawerController;
@end

