//
//  CPNavigation.m
//  PoliceExpressUser
//
//  Created by caiyc on 16/9/28.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "CPNavigation.h"
#import "UIBarButtonItem+Extension.h"
#import "UIImage+iconFont.h"
@interface CPNavigation ()<UIGestureRecognizerDelegate>

@end

@implementation CPNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [UINavigationBar appearance].barTintColor=[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:.8];
   // self.navigationBar.barTintColor = [UIColor whiteColor];
   // self.navigationBar.barTintColor = [XTool colorWithHexString:NAGA_BACKGROUND_COLOR] ;//设置导航栏颜色
    self.interactivePopGestureRecognizer.enabled = 1;
    __weak CPNavigation *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }

    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        //viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
//        negativeSpacer.width = -5;
        UIBarButtonItem *item = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"" highImage:@""];
        viewController.navigationItem.leftBarButtonItem = item;
       // viewController.navigationController.interactivePopGestureRecognizer.enabled = 1;
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"" highImage:@""];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"\U0000e61d" inFont:iconfont size:25 color:[UIColor blackColor]] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        // 设置右边的更多按钮
              //  viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    // super 一定要放在最后面调用，不然无法拦截push进来的控制器
    [super pushViewController:viewController animated:animated];
}

-(void)back{

    [self popViewControllerAnimated:0];
    //[self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
