//
//  BaseViewController.m
//  SHOP
//
//  Created by caiyc on 16/11/25.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BaseViewController ()

@end

@implementation BaseViewController
//get请求
-(void)getRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=acceptableContentTypes;
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}
-(void)getRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes=acceptableContentTypes;
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError * error))failure {
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    /**
     *  可以接受的类型
     */
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    //    manager.requestSerializer.timeoutInterval = 5;
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,URLString];
    NSLog(@"urlstr ===%@",urlString);
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"请求返回%@",responseObject);
        if (success) {
            if([[responseObject objectForKey:@"status"]integerValue]==1)
            {
                responseObject = [NSDictionary changeType:responseObject];
                success(responseObject);
            }
            else
            {
                [WToast showWithText:responseObject[@"msg"]];
                success(nil);
            }

         //   success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
           
        }
    }];
}
- (void)getWithparameters:(id)parameters
                 success:(void (^)(id response))success
                 failure:(void (^)(NSError * error))failure {
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
     [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    /**
     *  可以接受的类型
     */
    //manager.requestSerializer=[AFJSONRequestSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    //    manager.requestSerializer.timeoutInterval = 5;
   // NSString *urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,URLString];
    [manager GET:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"...%@",responseObject);
        if (success) {
            NSLog(@"返回信息：%@",responseObject[@"msg"]);
            if([[responseObject objectForKey:@"status"]integerValue]==1)
            {
            success(responseObject);
            }
            else
            {
                success(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    NSLog(@"收到内存警告");
//    if ([self isViewLoaded] && self.view.window == nil) {
//        self.view = nil;
//    }
//    dataArray = nil;
}
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError * error))failure {
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,URLString];
    NSLog(@"...url...%@",urlString);
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@".....response...%@",responseObject);
        if (success) {
            
            if([[responseObject objectForKey:@"status"]integerValue]==1)
            {
                responseObject = [NSDictionary changeType:responseObject];
                success(responseObject);
            }
            else
            {
                [WToast showWithText:[responseObject objectForKey:@"msg"]];
                success(nil);
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        if (failure) {
            failure(error);
        }
    }];
    
}
- (void)postWithparameters:(id)parameters
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError * error))failure {

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

     [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/json", nil]];
    
    
    [manager POST:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            
            if([[responseObject objectForKey:@"status"]integerValue]==1)
            {
                success(responseObject);
            }
            else
            {
                success(nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
        if (failure) {
            failure(error);
        }
    }];
    
}

//post请求
-(void)postRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params andAcceptableContentTypes:(NSSet *)acceptableContentTypes
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=acceptableContentTypes;
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}
-(void)postRequestWithString:(NSString *)urlStr andParams:(NSDictionary *)params
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.acceptableContentTypes=acceptableContentTypes;
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}

- (void)initNavgationBarWithTitle:(NSString *)titleStr
{
    UILabel *labelNavigation = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, ScreenWidth - 200, 64)];
    labelNavigation.text = titleStr;
    //  labelNavigation.textColor = [UIColor_ValueString colorWithHexString:NAGA_TITLE_COLOR];
    labelNavigation.font = [UIFont systemFontOfSize:17];
    labelNavigation.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = labelNavigation;
    [self setNavgationBackGroundImg];
}
/**
 *  设置导航条背景图片
 */
-(void)setNavgationBackGroundImgWithImgName:(NSString *)imgName
{
    UIImage *nav_bg = [UIImage imageNamed:imgName];
    [self.navigationController.navigationBar setBackgroundImage:nav_bg forBarMetrics:UIBarMetricsDefault];
}
-(void)setNavgationBackGroundImgWithImg:(UIImage *)img{
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
}
-(void)setNavgationBackGroundImg{
    //[self setNavgationBackGroundImgWithImg:[self imageWithColor:[UIColor_ValueString colorWithHexString:NAGA_BACKGROUND_COLOR]]];
}
-(void)setNavgationBack
{
    UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_back setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
    //    [btn_back setImage:[UIImage imageNamed:@"navigation_back_highlight"] forState:UIControlStateHighlighted];
    [btn_back addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn_back.frame = CGRectMake(0, 0, 23 , 40);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
}

-(UIButton *)getNavgationBackBtn
{
    UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_back setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
    //    [btn_back setImage:[UIImage imageNamed:@"navigation_back_highlight"] forState:UIControlStateHighlighted];
    [btn_back addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn_back.frame = CGRectMake(0, 0, 23 , 40);
    
    return btn_back;
}
-(void)backRootController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setNavgationSearchBarWithPlaceholder:(NSString *)placeholder tag:(NSInteger)tag target:(id)target{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(50.0f, 14.0f,self.navigationController.navigationBar.frame.size.width - 100.f , 20.0f);//
    searchBar.placeholder = placeholder;
    searchBar.delegate = target;
    searchBar.tag = 300;
    [self.navigationController.navigationBar addSubview:searchBar];
}

-(void)removeNavgationSearchBar{
    [[self.navigationController.navigationBar viewWithTag:300] removeFromSuperview];
}

-(void)setNavgationLeftWithName:(NSString *)name font:(UIFont *)font color:(UIColor *)color size:(CGSize)size action:(SEL)action
{
    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_left addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn_left.frame = CGRectMake(0, 0, 50 , 44);
    btn_left.titleLabel.font = font;
    [btn_left setTitleColor:color forState:UIControlStateNormal];
    [btn_left setTitle:name forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
    
}
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
//-(void)setNavgationRightWithName:(NSString *)name font:(NSString *)font color:(UIColor *)color size:(CGSize)size action:(SEL)action
//{
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_right addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [btn_right ButtonWithIconStr:name inIcon:iconfont andSize:size andColor:color andiconSize:PAPULARFONTSIZE];
//    btn_right.frame = CGRectMake(0, 0, size.width , size.height);
//    
////    UILabel *labtl = [[UILabel alloc]init];
////    labtl.frame = CGRectMake(20, 0, 10, 30);
////    labtl.backgroundColor = [UIColor redColor];
////    labtl.text = @"Ceshi";
////    [btn_right addSubview:labtl];
////    btn_right.titleLabel.font = font;
////    [btn_right setTitle:name forState:UIControlStateNormal];
////    [btn_right setTitleColor:color forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
//    
//}
//-(void)setNavgationRightWithName:(NSString *)name font:(NSString *)font color:(UIColor *)color size:(CGSize)size action:(SEL)action andNoti:(BOOL)noti
//{
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_right addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [btn_right ButtonWithIconStr:name inIcon:iconfont andSize:size andColor:color andiconSize:PAPULARFONTSIZE];
//    btn_right.frame = CGRectMake(0, 0, size.width , size.height);
//    
//        UILabel *labtl = [[UILabel alloc]init];
//        labtl.frame = CGRectMake(20, 0, 10, 30);
//        labtl.backgroundColor = [UIColor redColor];
//        labtl.text = @"Ceshi";
//        [btn_right addSubview:labtl];
//        //btn_right.titleLabel.font = font;
//        [btn_right setTitle:name forState:UIControlStateNormal];
//        [btn_right setTitleColor:color forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
//
//    
//}
//-(void)setNavgationLeftWithImgName:(NSString *)normalImgName highlighted:(NSString *)highlightedImaName size:(CGSize)size action:(SEL)action
//{
//    
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
//    negativeSpacer.width = -10;
//    
//    UIButton *btn_left = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_left setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
//    [btn_left setImage:[UIImage imageNamed:highlightedImaName] forState:UIControlStateHighlighted];
//    [btn_left addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    btn_left.frame = CGRectMake(0, 0, size.width , size.height);
//    
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn_left];
//    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,left, nil];//解决距离左边太大
//}
//
//-(void)setNavgationRightWithImgName:(NSString *)normalImgName highlighted:(NSString *)highlightedImaName size:(CGSize)size action:(SEL)action
//{
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
//    negativeSpacer.width = -10;
//    
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_right setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
//    [btn_right setImage:[UIImage imageNamed:highlightedImaName] forState:UIControlStateHighlighted];
//    [btn_right addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    btn_right.frame = CGRectMake(0, 0, size.width , size.height);
//    btn_right.layer.masksToBounds = YES;
//    btn_right.layer.cornerRadius = 15.f;
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
//     self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,right,nil];//解决距离右边边太大
//    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
//}
//-(void)setNavgationRightWithImgUrl:(NSString *)normalImgName highlighted:(NSString *)highlightedImaName size:(CGSize)size action:(SEL)action
//{
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    // [btn_right setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:normalImgName] placeholderImage:[UIImage imageNamed:@"home_rihgt_head_img"]];
//    [btn_right setImage:[UIImage imageNamed:highlightedImaName] forState:UIControlStateHighlighted];
//    [btn_right addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    btn_right.frame = CGRectMake(0, 0, size.width , size.height);
//    btn_right.layer.masksToBounds = YES;
//    btn_right.layer.cornerRadius = 15.f;
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_right];
//}
//
//-(void)setNavgationRightWithImgName:(NSString *)normalImgName highlighted:(NSString *)highlightedImaName size:(CGSize)size action:(SEL)action
//                      normalImgName:(NSString *)normalImgName2 highlighted:(NSString *)highlightedImaName2 size:(CGSize)size2 action:(SEL)action2
//{
//    UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_right setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
//    [btn_right setImage:[UIImage imageNamed:highlightedImaName] forState:UIControlStateHighlighted];
//    [btn_right setImage:[UIImage imageNamed:highlightedImaName] forState:UIControlStateSelected];
//    [btn_right addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    btn_right.frame = CGRectMake(0, 0, size.width , size.height);
//    
//    UIButton *btn_right2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_right2 setImage:[UIImage imageNamed:normalImgName2] forState:UIControlStateNormal];
//    [btn_right2 setImage:[UIImage imageNamed:highlightedImaName2] forState:UIControlStateHighlighted];
//    [btn_right2 setImage:[UIImage imageNamed:highlightedImaName2] forState:UIControlStateSelected];
//    [btn_right2 addTarget:self action:action2 forControlEvents:UIControlEventTouchUpInside];
//    btn_right2.frame = CGRectMake(0, 0, size2.width , size2.height);
//    
//    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:btn_right],[[UIBarButtonItem alloc] initWithCustomView:btn_right2]] ;
//}
//-(void)initTabBarItemWithTitle:(NSString *)titleStr normalImg:(NSString *)normalImg selectImg:(NSString *)selectImg  tag:(NSInteger)tag{
//    //构建TabBarItem
//    
//    //Normal文字颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor darkGrayColor],NSForegroundColorAttributeName ,nil] forState:UIControlStateNormal];
//    
//    //Selected文字颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
//    
//    UITabBarItem *item = [[UITabBarItem alloc] init];
//    [item setTitle:titleStr];
//    
//    item.image = [[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item.selectedImage = [[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [item setTag:tag];
//    self.tabBarItem = item;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = viewcontrollerColor;
    //self.isMainVc = 1;
    self.edgesForExtendedLayout = YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout =UIRectEdgeNone;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addShopNum:) name:@"addShopNum" object:nil];
   
   
 //   [self initNaviView:[UIColor whiteColor]];
   // [self preferredStatusBarStyle];

}
-(void)addShopNum:(NSNotification *)no
{
//    NSInteger num = [self.notiLb.text integerValue];
// //   num++;
//    self.notiLb.text = [NSString stringWithFormat:@"%ld",(long)num];
//    self.notiLb.backgroundColor = [UIColor redColor];
//    NSMutableDictionary *response = [[NSMutableDictionary alloc]initWithDictionary: [XTool GetDefaultInfo:SHOPCARDATA]];
//    NSMutableDictionary *totalDic = [[NSMutableDictionary alloc]initWithDictionary:response[@"result"]];
//  //  NSInteger num =  [[response objectForKey:@"result"][@"total_price"][@"num"]integerValue]++;
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary: totalDic[@"total_price"]];
//    [dic setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"num"];
//    [totalDic setObject:dic forKey:@"total_price"];
//    [response setObject:totalDic forKey:@"result"];
//    [XTool SaveDefaultInfo:response Key:SHOPCARDATA];
    [self performSelectorInBackground:@selector(reloadShopChar) withObject:nil];
   // [XTool SaveDefaultInfo:self.notiLb.text Key:@"shopNum"];
}
-(void)deleteShopCar:(NSNotification *)no
{
//    NSInteger num = [self.notiLb.text integerValue];
//    if(num>0)
//    num--;
//    else num = 0;
//    self.notiLb.text = [NSString stringWithFormat:@"%ld",(long)num];
//    self.notiLb.backgroundColor = [UIColor redColor];
   
    [self performSelectorInBackground:@selector(reloadShopChar) withObject:nil];
    // [XTool SaveDefaultInfo:self.notiLb.text Key:@"shopNum"];
}

-(void)reloadShopChar
{
    NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *dic = @{@"user_id":userDic[USER_ID]};
    [self postWithURLString:@"/Cart/cartList" parameters:dic success:^(id response) {
        NSLog(@"获取数据:---------%@",response);
        if(response)
        {
            [XTool SaveDefaultInfo:response Key:SHOPCARDATA];
            NSInteger num = [[response objectForKey:@"result"][@"cartList"]count];
            self.notiLb.text = [NSString stringWithFormat:@"%ld",(long)num];
            self.notiLb.backgroundColor = [UIColor redColor];
            NSString *nums =  [NSString stringWithFormat:@"%@",[response objectForKey:@"result"][@"total_price"][@"num"]];
            NSDictionary *userDic = @{@"num":nums};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addshopNumber" object:userDic];

        }
    } failure:^(NSError *error) {
        
    }];

}
//-(void)initNaviView:(UIColor *)color title:(NSString *)title haveLeft:(BOOL)left right:(NSString *)right  rightAction:(SEL)rightAction
//{
//     self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, naviHei)];
//     self.naviView.backgroundColor = RGB(225, 29, 66);
//   // self.naviView.backgroundColor = color;
//    [self.view addSubview:self.naviView];
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((screen_width-200)/2, 20, 200, naviHei-20)];
//    label.text = title;
//    label.textAlignment = 1;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:18];
//    [self.naviView addSubview:label];
//    
//    if(left)
//    {
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setFrame:CGRectMake(leftSpece,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
//      //  [leftBtn setImage:[UIImage imageNamed:@"backs"] forState:UIControlStateNormal];
//        [leftBtn ButtonWithIconStr:@"\U0000e7c8" inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor whiteColor] andiconSize:PAPULARFONTSIZE];
//
//    //[leftBtn ButtonWithIconStr:@"\U0000e683" inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor whiteColor] andiconSize:PAPULARFONTSIZE];
//    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.naviView addSubview:leftBtn];
//    }
//    if(![right isEqualToString:@""])
//    {
//        NSLog(@"right==%@",right);
////        NSMutableString *str =@"\"U0000e";
////     str =   [str stringByAppendingString:right];
//        //NSString *str = @"\U0000e682";
//       // NSString *str = [NSString stringWithFormat:@"\U0000e%@",right];
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setFrame:CGRectMake(screen_width-leftSpece-btnSize,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
//    [rightBtn ButtonWithIconStr:right inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor whiteColor] andiconSize:PAPULARFONTSIZE];
//    [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
//   // [rightBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.naviView addSubview:rightBtn];
//    }
//
////    UILabel *speLine = [[UILabel alloc]init];
////    speLine.backgroundColor = separaterColor;
////    speLine.frame = CGRectMake(0, naviHei-1, screen_width, 1);
////    [self.naviView addSubview:speLine];
//  
//    
//}
-(void)initNaviView:(UIColor *)navColor hasLeft:(BOOL)haveLeft leftColor:(UIColor *)leftColor title:(NSString *)title titleColor:(UIColor *)titleColor right:(NSString *)right rightColor:(UIColor *)rightColor rightAction:(SEL)rightAction
{
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, naviHei)];
    //self.naviView.backgroundColor = navColor;
    self.naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.naviView];
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((screen_width-200)/2, 20, 200, naviHei-20)];
//    label.text = title;
//    label.textAlignment = 1;
//    label.textColor = RGB(100, 100, 100);
//    label.font = [UIFont systemFontOfSize:18];
    CustomLable *label = [[CustomLable alloc]initWithFrame:CGRectMake((screen_width-200)/2, 20, 200, naviHei-20)];
    label.text = title;
    label.textAlignment = 1;
   //  label.textColor = RGB(100, 100, 100);
    [self.naviView addSubview:label];
    
    if(haveLeft)
    {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setFrame:CGRectMake(leftSpece,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(leftSpece,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
        [label LabelWithIconStr:@"\U0000e642" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor blackColor] andiconSize:20];
        [self.naviView addSubview:label];
//        [leftBtn ButtonWithIconStr:@"\U0000e642" inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor blackColor] andiconSize:PAPULARFONTSIZE];
        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.naviView addSubview:leftBtn];
    }
    if(![right isEqualToString:@""])
    {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(screen_width-leftSpece-btnSize,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
        [rightBtn ButtonWithIconStr:right inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor whiteColor] andiconSize:PAPULARFONTSIZE+5];

        [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
        
        [self.naviView addSubview:rightBtn];
    }

}
-(void)setNotifationBage
{
    //每次进来都调用购物车数据
   self.notiLb = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-leftSpece-15, (naviHei-btnSize)/2+12, 15, 15)];
    [self.naviView addSubview:self.notiLb];
    //
    self.notiLb.layer.cornerRadius =7.5;
    self.notiLb.layer.masksToBounds = 1;
    self.notiLb.textColor = [UIColor whiteColor];
    self.notiLb.font = [UIFont systemFontOfSize:11];
    self.notiLb.textAlignment = 1;
//    NSDictionary *response = [XTool GetDefaultInfo:SHOPCARDATA];
//    NSInteger num =  [[response objectForKey:@"result"][@"total_price"][@"num"]integerValue];
//    
//        if(num>0)
//        {
//            self.notiLb.backgroundColor = [UIColor redColor];
//            self.notiLb.text = [NSString stringWithFormat:@"%ld",num];
//        }
    
    

    
}
-(void)setNotifationBageNum:(NSInteger)num
{
 //   self.notiLb.text = @"5";
    if(num>0)
    {
    self.notiLb.backgroundColor = [UIColor redColor];
    self.notiLb.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
}
//控制导航左边按钮
//-(void)setIsNotMain:(BOOL)isNotMain
//{
//    if(isNotMain)
//    {
//        [self setNavgationLeftWithImgName:@"btnback" highlighted:@"" size:CGSizeMake(40, 40) action:@selector(back)];
//        [self setNavgationRightWithImgName:@"btnback" highlighted:@"" size:CGSizeMake(40, 40) action:@selector(back)];
//    }
//}
-(void)back{
//    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
//    [app.drawerController closeDrawerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
-(BOOL)prefersStatusBarHidden{
    [super prefersStatusBarHidden];
    return YES; //状态栏隐藏  NO显示
}
-(void)pushView:(UIViewController *)viewController
{
//    viewController.view.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:1 animations:^{
//        viewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    [app.drawerController closeDrawerAnimated:NO completion:nil];

    self.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:viewController animated:1];
   // self.hidesBottomBarWhenPushed = 0;
}
-(void)pushSecondVC:(UIViewController *)VC
{
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    [app.drawerController closeDrawerAnimated:NO completion:nil];

    self.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = 0;
}
-(void)pushViewAndAnimate:(UIViewController *)viewController{
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    [app.drawerController closeDrawerAnimated:NO completion:nil];

//        viewController.view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
//        //x和y的最终值为1
//        [UIView animateWithDuration:1 animations:^{
//            viewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
//        }];
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = @"reveal";
    //设置动画时长
    animation.duration =.4f;
    //设置运动的方向
    animation.subtype =kCATransitionFromRight;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    self.hidesBottomBarWhenPushed = 1;
    [self.navigationController pushViewController:viewController animated:0];
    self.hidesBottomBarWhenPushed = 0;
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
