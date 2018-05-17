//
//  GoodDetailViewController.m
//  chuangyi
// 111111
//  Created by caiyc on 17/8/4.
//  Copyright © 2017年 changce. All rights reserved.
//   222222222

#import "GoodDetailViewController.h"
#import "GoodsFlashCell.h"
#import "GoodsInfoCell.h"
#import "GoodSpecCell.h"
#import "envalteCell.h"
#import "specViews.h"
#import "ProcssCell.h"
//#import "packageViewController.h"
#import "ShopCarViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "GoodCommentViewController.h"
#import "SecKillDetailCell.h"
//#import "IndexViewController.h"
//#import "SettlementViewController.h"
#import "LoginViewController.h"
#import "SettlementZViewController.h"
//#import "IndexViewController.h"
//#import "ChatWebViewController.h"
//#import "ReportViewController.h"
#import "SeviceFeeViewController.h"

@interface GoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *goodDic;
@property(nonatomic,strong)GoodsInfoCell *goodInfocCell;
@property (strong, nonatomic)  UITableView *tableView;
@property(nonatomic,strong)UIScrollView *bottomScroView;
@property(nonatomic,strong)envalteCell *envateCell;
@property(nonatomic,strong)NSMutableArray *comentArr;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIWebView *web;
@property(nonatomic,strong)UIView *SpecPopView;//规格弹出视图
@property(nonatomic,strong)NSString * countNum;
@property(nonatomic,strong)NSString *specStr;
@property(assign)BOOL buyrightNow;
@property(nonatomic,strong)UIScrollView *imageScro;
@property(nonatomic,strong)UIView *seviceView;//服务说明
@property(nonatomic,strong)UIWebView *serviceWeb;
@property(nonatomic,strong)NSString *date_id;//租期id

@end

@implementation GoodDetailViewController
-(void)reloadDatas
{
//    NSDictionary *paramter = nil;
//    if([XTool GetDefaultInfo:USER_INFO])
//    {
//        NSString *uid = [XTool GetDefaultInfo:USER_INFO][USER_ID];
//        paramter = @{@"type":@"0",@"id":self.goodsID,@"user_id":uid};
//    }else
//    {
//        paramter = @{@"type":@"0",@"id":self.goodsID};
//    }
//
//    self.isSecKill = 0;
//    [self getWithURLString:@"/goods/goodsInfo" parameters:paramter success:^(id response) {
//        SLog(@"产品详情输出%@",response);
//        self.goodDic = response[@"result"];
//        [self.tableView reloadData];
//        BOOL iscollect = [self.goodDic[@"goods"][@"icollect"]boolValue];
//        if(iscollect){
//            UIButton *btn = (UIButton *)[self.view viewWithTag:12121];
//            [btn ButtonWithIconStr:@"\U0000e68d" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_COLOR andiconSize:25];
//            
//        }
//        [self.web loadHTMLString:self.goodDic[@"goods"][@"goods_content"] baseURL:nil];
//        specViews *spec = [[specViews alloc]initWithDataSource:response[@"result"]];
//        spec.frame =CGRectMake(0, screen_height/2-100, screen_width, screen_height/2+100);
//        spec.backgroundColor = [UIColor whiteColor];
//        spec.sure=^(NSString *num,NSString *specStr,BOOL buynow){
//            self.specStr = specStr;
//            self.buyrightNow = buynow;
//            NSLog(@"回调的参数%@，%@",num,specStr);
//            
//            self.countNum = num;
//            if([self.goodDic[@"goods"][@"goods_spec_list"]count]==0)
//            {
//                self.specStr = @"";
//                [self requestToCar];
//            }
//            else
//            {
//                if(self.specStr)
//                {
//                    [self requestToCar];
//                }
//            }
//            [self dismiss];
//        };
//        [self.SpecPopView addSubview:spec];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"商品详情错误信息===%@",error);
//    }];
//    NSDictionary *param = @{@"goods_id":self.goodsID,@"p":@"1"};
//    [self postWithURLString:@"/goods/getGoodsComment" parameters:param success:^(id response) {
//        NSLog(@"商品评论数据%@",response);
//        // self.comentArr = response[@"result"];
//        if([response[@"result"]count]>3)
//        {
//            for(int i =0;i<3;i++)
//            {
//                [  self.comentArr addObject:response[@"result"][i]];
//            }
//        }else
//        {
//            self.comentArr = response[@"result"];
//        }
//        [self.tableView reloadData];
//        // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationTop];
//    } failure:^(NSError *error) {
//        
//    }];
//    

}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stoptime" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDatas) name:@"timeoutss" object:nil];
    self.comentArr = [NSMutableArray array];
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:[UIColor grayColor] title:@"" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.naviView.backgroundColor = RGBA(255, 255, 255, 0);
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(10, 15, 40, 40);
    [left ButtonWithIconStr:@"\U0000e642" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:[UIColor grayColor] andiconSize:30];
    [left addTarget:self action:@selector(backtofirst) forControlEvents:UIControlEventTouchUpInside];
  //  [self.naviView addSubview:left];
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.frame = CGRectMake(screen_width-100, 15, 40, 40);
    [right1 ButtonWithIconStr:@"\U0000e668" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    [right1 addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
 //   [self.naviView addSubview:right1];
    UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    right2.frame = CGRectMake(screen_width-50, 15, 40, 40);
    [right2 ButtonWithIconStr:@"\U0000e668" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    [right2 addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:right2];
    
    UIButton *right3 = [UIButton buttonWithType:UIButtonTypeCustom];
    right3.frame = CGRectMake(screen_width-150, 15, 40, 40);
    [right3 ButtonWithIconStr:@"\U0000e668" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    [right3 addTarget:self action:@selector(collectss:) forControlEvents:UIControlEventTouchUpInside];
    right3.tag = 12121;
  //  [self.naviView addSubview:right3];

    self.bottomScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height-60)];
    self.bottomScroView.pagingEnabled = 1;
    self.bottomScroView.showsVerticalScrollIndicator = 0;
    self.bottomScroView.contentSize = CGSizeMake(screen_width, screen_height*2);
    [self.view addSubview:self.bottomScroView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, self.bottomScroView.frame.size.height) style:UITableViewStyleGrouped ];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self.bottomScroView addSubview:self.tableView];
    
    //第二页
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_height-60, screen_width, screen_height-60)];
    secondView.backgroundColor = [UIColor redColor];
    [self.bottomScroView addSubview:secondView];
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_width, secondView.frame.size.height)];
    [secondView addSubview:self.web];
  //  self.web.delegate = self;
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_height-60, screen_width, 60)];
    UILabel *horline = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screen_width, 1)];
    horline.backgroundColor = RGB(225, 225, 225);
    [self.bottomView addSubview:horline];
    NSArray *data =@[@"\U0000e622",@"\U0000e623"];
    for(int i =0;i<2;i++){
        UIButton *shreBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
        shreBtn.frame = CGRectMake(59*i, 0, 60, 60);
        [shreBtn ButtonWithIconStr:data[i] inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:[UIColor grayColor] andiconSize:25];
        [self.bottomView addSubview:shreBtn];
        [shreBtn addTarget:self action:@selector(botomClick:) forControlEvents:UIControlEventTouchUpInside];
        shreBtn.tag = 1024+i;
        UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(59*(i+1), 0, 1, 60)];
        linelabel.backgroundColor = RGB(225, 225, 225);
        [self.bottomView addSubview:linelabel];
    }
    
    CGFloat offwid = (screen_width-120)/2;
    UIButton *addtocar = [UIButton buttonWithType:UIButtonTypeCustom];
    addtocar.frame = CGRectMake(120, 0, offwid, 60);
    [ addtocar setTitle:@"立即租用" forState:UIControlStateNormal];
    addtocar.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addtocar addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
    [addtocar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // addtocar.backgroundColor = PRICE_COLOR;
    [self.bottomView addSubview:addtocar];


    UIButton *buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buybtn.frame = CGRectMake(screen_width-offwid, 0, offwid, 60);
    [ buybtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    buybtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    buybtn.backgroundColor = BASE_COLOR;
    [buybtn addTarget:self action:@selector(addCar:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:buybtn];
    
    [self.view addSubview:self.bottomView];

    //规格弹出视图
    self.SpecPopView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_height, screen_width, screen_height)];
    self.SpecPopView.backgroundColor = RGBA(0, 0, 0, .5);
    [self.view addSubview:self.SpecPopView];
    //self.SpecPopView.hidden = 1;
#pragma mark 覆盖图全局手势暂时注释
//    UITapGestureRecognizer *tapss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//    [self.SpecPopView addGestureRecognizer:tapss];
    
    //评论图片查看滚动图片视图
    self.imageScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.imageScro.hidden = 1;
    [self.view addSubview:self.imageScro];
    self.imageScro.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missImgScro)];
    [self.imageScro addGestureRecognizer:tap];

    //服务说明弹出视图
    self.seviceView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.seviceView.backgroundColor = RGBA(0, 0, 0, .6);
    [self.view addSubview:self.seviceView];
    self.serviceWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, screen_height-200, screen_width, 200)];
    [self.seviceView addSubview:self.serviceWeb];
    self.seviceView.hidden = 1;
    UITapGestureRecognizer *tapsevice = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missSevice)];
    [self.seviceView addGestureRecognizer:tapsevice];
    

    
    NSDictionary *paramter = nil;
    if([XTool GetDefaultInfo:USER_INFO])
    {
        NSString *uid = [XTool GetDefaultInfo:USER_INFO][USER_ID];
        paramter = @{@"id":self.goodsID,@"user_id":uid};
    }else
    {
        paramter = @{@"id":self.goodsID};
    }
    
   // NSDictionary *paramter = @{@"user_id":uid,@"id":@"94"};
    [self getWithURLString:@"/goods/goodsInfo" parameters:paramter success:^(id response) {
        SLog(@"产品详情输出%@",response);
        self.goodDic = response[@"result"];
        [self.tableView reloadData];
        BOOL iscollect = [self.goodDic[@"goods"][@"icollect"]boolValue];
        if(iscollect){
        UIButton *btn = (UIButton *)[self.view viewWithTag:1025];
            [btn ButtonWithIconStr:@"\U0000e623" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_COLOR andiconSize:25];

        }
        [self.web loadHTMLString:self.goodDic[@"goods"][@"goods_content"] baseURL:nil];
        specViews *spec = [[specViews alloc]initWithDataSource:response[@"result"]];
        spec.frame =CGRectMake(0, screen_height/2-100, screen_width, screen_height/2+100);
        spec.backgroundColor = [UIColor whiteColor];
        spec.closeViews = ^(){
            [self dismiss];
        };
        spec.selectDate=^(NSString *ids){
            self.date_id = ids;
        };
        spec.sure=^(NSString *num,NSString *specStr,BOOL buynow){
            self.buyrightNow = buynow;
            self.specStr = specStr;
            NSLog(@"回调的参数%@，%@",num,specStr);
            
            self.countNum = num;
            if([self.goodDic[@"goods"][@"goods_spec_list"]count]==0)
            {
                self.specStr = @"";
                [self requestToCar];
            }
            else
            {
                if(self.specStr)
                {
                    [self requestToCar];
                }
            }
          //  [self dismiss];
        };
        [self.SpecPopView addSubview:spec];

    } failure:^(NSError *error) {
        NSLog(@"商品详情错误信息===%@",error);
    }];
    NSDictionary *param = @{@"goods_id":self.goodsID,@"p":@"1"};
    [self postWithURLString:@"/goods/getGoodsComment" parameters:param success:^(id response) {
        NSLog(@"商品评论数据%@",response);
       
       // self.comentArr = response[@"result"];
        if([response[@"result"]count]>3)
        {
            for(int i =0;i<3;i++)
            {
                [  self.comentArr addObject:response[@"result"][i]];
            }
        }else
        {
            self.comentArr = response[@"result"];
        }
        [self.tableView reloadData];
       // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationTop];
    } failure:^(NSError *error) {
        
    }];

    [self.view bringSubviewToFront:self.naviView];//导航条浮动
    // Do any additional setup after loading the view from its nib.
}
-(void)collectss:(UIButton *)sneder{
    if(![XTool GetDefaultInfo:USER_INFO])
    {
        [WToast showWithText:@"先登录"];
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushView:vc];
        
        return;
    }
    
    //收藏
    BOOL iscollect = [self.goodDic[@"goods"][@"icollect"]boolValue];
    BOOL iselec = 0;
    if(iscollect)
    {
        iselec =1;
    }else iselec=0;
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"goods_id":self.goodsID,@"type":[NSString stringWithFormat:@"%d",iselec]};
    [self postWithURLString:@"/goods/collectGoods" parameters:param success:^(id response) {
        NSLog(@"收藏数据%@",response);
        [WToast showWithText:response[@"msg"]];
        if([response[@"status"]integerValue]==1)
        {
            if(iscollect)
            {
                [sneder ButtonWithIconStr:@"\U0000e690" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:[UIColor grayColor] andiconSize:25];
                NSMutableDictionary *goodDic = [NSMutableDictionary dictionaryWithDictionary:self.goodDic];
                NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: self.goodDic[@"goods"]];
                [dic setObject:@"0" forKey:@"icollect"];
                [goodDic setObject:dic forKey:@"goods"];
                self.goodDic = goodDic;
                
                
            }
            else
            {
                NSMutableDictionary *goodDic = [NSMutableDictionary dictionaryWithDictionary:self.goodDic];
                NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: self.goodDic[@"goods"]];
                [dic setObject:@"1" forKey:@"icollect"];
                [goodDic setObject:dic forKey:@"goods"];
                self.goodDic = goodDic;
                
                [sneder ButtonWithIconStr:@"\U0000e68d" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_COLOR andiconSize:25];
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)contact
{
//    ChatWebViewController *vc = [[ChatWebViewController alloc]init];
//    [self pushView:vc];
}
-(void)backtofirst
{
   // for()
   [self.navigationController popViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 0;
}
//分享
-(void)shareAction
{

    //分享
    //1、创建分享参数
  
    NSArray *imageArray=nil;
    NSString *titless = @"";
    NSString *titles = @"";
    if([self.goodDic[@"gallery"]count]>0)
    {
        imageArray = @[self.goodDic[@"gallery"][0][@"image_url"]];
        titless = self.goodDic[@"goods"][@"goods_remark"];
        titles = self.goodDic[@"goods"][@"goods_name"];
    }else
    {
         imageArray = @[[UIImage imageNamed:@"libao.png"]];
         titless = @"乐享租";
        titles = @"快来和我一起玩转乐享租";
    }
    
   // NSArray* imageArray = @[self.goodDic[@"gallery"][0][@"image_url"]];
//    NSArray* imageArray = @[[UIImage imageNamed:@"libao.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
      //  NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:titless
                                         images:imageArray
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"http://lxz.ynthgy.com/mobile/goods/goodsInfo/id/%@.html",self.goodsID]]
                                          title:titles
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}

    

}
//返回主页
-(void)backHome
{
//    for(UIViewController *vc in self.navigationController.viewControllers)
//    {
//        if([vc isKindOfClass:[IndexViewController class]])
//        {
//            [self.navigationController popToViewController:vc animated:YES];
//        }else
//        {
////              [self.navigationController popToRootViewControllerAnimated:YES];
////            self.tabBarController.hidesBottomBarWhenPushed = 0;
////            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
////            IndexViewController *vc = [[IndexViewController alloc]init];
////            [self.navigationController popToViewController:vc animated:YES];
//          
//        self.tabBarController.selectedIndex = 0;
//             [self.navigationController popToRootViewControllerAnimated:YES];
//        //    self.navigationController popToViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
//          //  [[NSNotificationCenter defaultCenter]postNotificationName:@"change" object:nil];
//        }
//    }
//    IndexViewController *vc = [[IndexViewController alloc]init];
//    [self.navigationController popToViewController:vc animated:YES];
}
-(void)missSevice
{
    self.seviceView.hidden = 1;
}
-(void)missImgScro
{
    self.imageScro.hidden = 1;
}
-(void)botomClick:(UIButton *)sneder
{
    //tag 1024,1025,1026
    if(sneder.tag==10)
    {
        if(![XTool GetDefaultInfo:USER_INFO])
        {
            [WToast showWithText:@"先登录"];
            return;
        }
        //分享
        //1、创建分享参数
        /*
        NSArray* imageArray = @[self.goodDic[@"gallery"][0][@"image_url"]];
        //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
        if (imageArray) {
            
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:self.goodDic[@"goods"][@"goods_remark"]
                                             images:imageArray
                                                url:[NSURL URLWithString:[NSString stringWithFormat:@"http://lmrz.ynthgy.com/index.php/Mobile/Goods/goodsInfo/id/141/user_id/%@.html",[XTool GetDefaultInfo:USER_INFO][USER_ID]]]
                                              title:self.goodDic[@"goods"][@"goods_name"]
                                               type:SSDKContentTypeAuto];
            //有的平台要客户端分享需要加此方法，例如微博
            [shareParams SSDKEnableUseClientShare];
            //2、分享（可以弹出我们的分享菜单和编辑界面）
            [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                     items:nil
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state) {
                               case SSDKResponseStateSuccess:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
                               case SSDKResponseStateFail:
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               default:
                                   break;
                           }
                       }  
             ];}
         */
        
    }
    else if (sneder.tag==1024)
    {
   if(![XTool GetDefaultInfo:USER_INFO])
   {
       [WToast showWithText:@"先登录"];
       LoginViewController *vc = [[LoginViewController alloc]init];
       [self pushView:vc];
       return;
   }
        //购物车
        ShopCarViewController *vc = [[ShopCarViewController alloc]init];
      //  vc.hasLft = 1;
        [self pushView:vc];
    }else
    {
       // [self contact];
        if(![XTool GetDefaultInfo:USER_INFO])
        {
            [WToast showWithText:@"先登录"];
            LoginViewController *vc = [[LoginViewController alloc]init];
            [self pushView:vc];

            return;
        }

        //收藏
        BOOL iscollect = [self.goodDic[@"goods"][@"icollect"]boolValue];
        BOOL iselec = 0;
        if(iscollect)
        {
            iselec =1;
        }else iselec=0;
        NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"goods_id":self.goodsID,@"type":[NSString stringWithFormat:@"%d",iselec]};
        [self postWithURLString:@"/goods/collectGoods" parameters:param success:^(id response) {
            NSLog(@"收藏数据%@",response);
            [WToast showWithText:response[@"msg"]];
            if([response[@"status"]integerValue]==1)
            {
                if(iscollect)
                {
                    [sneder ButtonWithIconStr:@"\U0000e623" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:[UIColor grayColor] andiconSize:25];
                    NSMutableDictionary *goodDic = [NSMutableDictionary dictionaryWithDictionary:self.goodDic];
                    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: self.goodDic[@"goods"]];
                    [dic setObject:@"0" forKey:@"icollect"];
                    [goodDic setObject:dic forKey:@"goods"];
                    self.goodDic = goodDic;
                    
                    
                }
                else
                {
                    NSMutableDictionary *goodDic = [NSMutableDictionary dictionaryWithDictionary:self.goodDic];
                    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: self.goodDic[@"goods"]];
                    [dic setObject:@"1" forKey:@"icollect"];
                    [goodDic setObject:dic forKey:@"goods"];
                    self.goodDic = goodDic;

                    [sneder ButtonWithIconStr:@"\U0000e623" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_COLOR andiconSize:25];
                }
            }
        } failure:^(NSError *error) {
            
        }];
        
    }

    
}
//立即购买
-(void)buyNow
{
     self.SpecPopView.frame = CGRectMake(0, 0, screen_width, screen_height);
    self.buyrightNow = 1;
}
//加入购物车
-(void)addCar:(UIButton *)btn
{
    self.SpecPopView.frame = CGRectMake(0, 0, screen_width, screen_height);
     self.buyrightNow = 0;
}
-(void)dismiss
{
    [self.view endEditing:1];
    // center.y += 64;
    // [self.vc.navigationController setNavigationBarHidden:NO animated:YES];
   // self.SpecPopView.hidden = 1;
//    [UIView animateWithDuration: 0.35 animations: ^{
       self.SpecPopView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
//        //        self.view.center = center;
//        //        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//        
//    } completion: nil];
    
}
-(void)requestToCar
{
    if(![XTool GetDefaultInfo:USER_INFO])
    {
        [WToast showWithText:@"先登录"];
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushView:vc];
        return;
    }
    if(!self.date_id){
        [WToast showWithText:@"请选择时间"];
        return;
    }
    NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];
       NSDictionary *param = @{@"goods_id":self.goodsID,@"goods_num":self.countNum,@"goods_spec":self.specStr,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"buynow":[NSString stringWithFormat:@"%d",self.buyrightNow],@"month_num":self.date_id};
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSString *urlString = [NSString stringWithFormat:@"%@/cart/addCart",BASE_URL];
    NSLog(@"...url...%@",urlString);
    [manager POST:urlString parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@".....response...%@",responseObject);
                    if([responseObject[@"status"]integerValue]==1)
                    {
                        [self dismiss];
                       
                       
                        if(self.buyrightNow)
                        {
                            SettlementZViewController *vc = [[SettlementZViewController alloc]init];
                            [self pushView:vc];
                        }else
                        {
                           //  [self reloadDatas];
                            [WToast showWithText:@"成功加入购物车"];
                        }
                    }else{
                        [WToast showWithText:responseObject[@"msg"]];
                            if([responseObject[@"msg"]isEqualToString:@"商品库存不足"])
                            {
                                [self showAlert];
                            }
                        
                    }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败:%@",error);
       
    }];

//   // NSDictionary *param = @{@"goods_id":self.goodsID,@"goods_num":self.countNum,@"goods_spec":self.specStr,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
//
//        NSLog(@"购物车参数%@",param);
//        [self postWithURLString:@"/cart/addCart" parameters:param success:^(id response) {
//            NSLog(@"加入购物车操作%@",response);
//            if([response[@"status"]integerValue]==1)
//            {
//                if(self.buyrightNow)
//                {
//                    SettlementViewController *vc = [[SettlementViewController alloc]init];
//                    [self pushView:vc];
//                }else{
//                [WToast showWithText:response[@"msg"]];
//                    if([response[@"msg"]isEqualToString:@"商品库存不足"])
//                    {
//                        [self showAlert];
//                    }
//                }
//            }
//        } failure:^(NSError *error) {
//            
//        }];
   

}
-(void)showAlert
{
    //弹出预约提示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"商品库存不足，是否立即预约到货提醒" preferredStyle:1];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSData *jsonData = [self.specStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSArray *valeus = [dic allValues];
        NSMutableString *mutiStr = [[NSMutableString alloc]init] ;
        
        
        for(int i =0;i<valeus.count;i++)
        {
            [mutiStr appendString:valeus[i]];
            if(i<valeus.count-1)
            {
                [mutiStr appendString:@"_"];
            }
        }
        
        NSLog(@"预约的规格参数==%@",mutiStr);

        NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
        NSDictionary *paramter = @{@"user_id":userDic[USER_ID],
                                   @"goods_id":self.goodsID,@"spec_key":mutiStr};
        [self getWithURLString:@"/index/bookgoods" parameters:paramter success:^(id response) {
            [WToast showWithText:response[@"msg"]];
        if(response)
        {
            [self dismiss];
        }
        
        } failure:^(NSError *error) {
            
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    

}
-(void)sure
{
    //
    [self dismiss];
    
}
#pragma mark tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==4){
        return self.comentArr.count;
    }else if (section==1){
        NSDictionary *dic = self.goodDic[@"goods"][@"flash_sale"];
        if(dic.count>0){
            return 2;
        }else{
            return 1;
        }
    }
    
    else
    return 1;
//    if(section==1)
//    {
//        if(self.isSecKill==1)
//        {
//            return 2;
//        }else return 1;
//    }else if (section==3)
//    {
//        return self.comentArr.count;
//    }
//    else
//    {
//    return 1;
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if(self.isSecKill==1)
//    {
//        return 5;
//    }else
    return 5;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
      static NSString *cellid = @"cell";
    GoodsFlashCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GoodsFlashCell" owner:self options:nil]lastObject];
    }
        
    NSArray *arr = self.goodDic[@"gallery"];
    [cell bindData:arr];
    return cell;
    }else if(indexPath.section==1){
      //  NSDictionary *dic = self.goodDic[@"goods"][@"flash_sale"];
        if(indexPath.row==1){
            static NSString *cellId = @"secCell";
            SecKillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"SecKillDetailCell" owner:self options:nil]lastObject];
            }
            [cell bindData:self.goodDic];
            return cell;

        }else{
            
        

        GoodsInfoCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"GoodsInfoCell" owner:self options:nil]lastObject];
        if(self.goodDic.count>0){
        [cell bindCell:self.goodDic[@"goods"]];
        }
        cell.checkAllcomm=^(){
            GoodCommentViewController *vc = [[GoodCommentViewController alloc]init];
            vc.goodId = [NSString stringWithFormat:@"%@",self.goodDic[@"goods"][@"goods_id"]];
            [self pushView:vc];
        };
        return cell;
        }
    }else if(indexPath.section==2){
        
        ProcssCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ProcssCell" owner:self options:nil]lastObject];
        
        return cell;
    }else if(indexPath.section==3){
        
        GoodSpecCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"GoodSpecCell" owner:self options:nil]lastObject];
        
        cell.clickSpec = ^(){
            self.SpecPopView.frame = CGRectMake(0, 0, screen_width, screen_height);
        };
        cell.clickRuel=^(){
            
            SeviceFeeViewController *vc = [[SeviceFeeViewController alloc]init];
            
            vc.goodDic = self.goodDic[@"goods"];
            
            [self pushView:vc];
        };
        cell.checkreport = ^(){
            
//            ReportViewController *vc = [[ReportViewController alloc]init];
//            
//            [self pushView:vc];
            
        };

        return cell;
    }else{
        
        self.envateCell = [[[NSBundle mainBundle]loadNibNamed:@"envalteCell" owner:self options:nil]lastObject];
        
        [ self.envateCell bindData:self.comentArr[indexPath.row]];
        
        return self.envateCell;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
// if(section==2||section==3)
// {
//     if(section==3)
//     {
//         return 60;
//     }else
//     return 10;
// }else return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
//    if(section==3)
//    {
//        return 40;
//    }else return CGFLOAT_MIN;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==4)
    {
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 40)];
        headview.backgroundColor = viewcontrollerColor;
        UILabel *lane =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screen_width, 40)];
        lane.text = @"上拉查看商品详情";
        lane.textColor = [UIColor lightGrayColor];
        lane.font = [UIFont systemFontOfSize:15];
        lane.textAlignment = NSTextAlignmentCenter;
        [headview addSubview:lane];
        
        return headview;
    }else return [[UIView alloc]initWithFrame:CGRectZero];}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if(section==2||section==3)
//    {
//        if(section==2)
//        {
//        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 10)];
//        headview.backgroundColor = viewcontrollerColor;
//        return headview;
//        }else
//        {
//            UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 60)];
//            headview.backgroundColor = viewcontrollerColor;
//            UIView *contView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, screen_width, 50)];
//            contView.backgroundColor = [UIColor whiteColor];
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screen_width-100, 50)];
//            // label.text =@"用户评论";
//           label.text = [NSString stringWithFormat:@"用户评论(%@)",self.goodDic[@"goods"][@"comment_count"]];
//            label.font = [UIFont systemFontOfSize:15];
//            label.textColor = RGB(100, 100, 100);
//            [contView addSubview:label];
//            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(screen_width-100, 0, 100, 50);
//            [btn setTitle:@"查看全部 >" forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:14];
//            [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
//            [contView addSubview:btn];
//            [btn addTarget:self action:@selector(checkAll) forControlEvents:UIControlEventTouchUpInside];
//            
//            [headview addSubview:contView];
//            
//            UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(10, 59, screen_width-10, 1)];
//            labe.backgroundColor = viewcontrollerColor;
//            [headview addSubview:labe];
//            return headview;
//
//        }
//    }else return [[UIView alloc]initWithFrame:CGRectZero];
//}
-(void)checkAll
{
//    GoodCommentViewController *vc = [[GoodCommentViewController alloc]init];
//    vc.goodId = self.goodsID;
//    [self pushView:vc];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    return screen_width;
    else if (indexPath.section==1)
    {
        if(indexPath.row==1){
            return 50;
        }else
        return 120;
    }
    else if (indexPath.section==2)
    {
        return 120;

    }else if(indexPath.section==3){
//        if(self.comentArr.count==0)
//        {
//            return 0;
//        }else{
//            return 130;
//        }

        return 90;
    }
    else
    {
       // return 220;
        if(self.comentArr.count==0)
        {
            return 0;
        }
        else return self.envateCell.imgScroView.frame.size.height+self.envateCell.imgScroView.frame.origin.y+10;
    }
//        if(indexPath.row==self.comentArr.count-1)
//        {
//            if([self.comentArr[indexPath.row][@"img"]count]==0)
//            {
//                NSLog(@".....高度----%f",self.envateCell.content.frame.size.height+self.envateCell.content.frame.origin.y);
//                return self.envateCell.imgScroView.frame.size.height+self.envateCell.imgScroView.frame.origin.y;
//            }else
//                return self.envateCell.imgScroView.frame.size.height+self.envateCell.imgScroView.frame.origin.y;
//            
//            
//        }
//        
//    else{
//        if([self.comentArr[indexPath.row][@"img"] isKindOfClass:[NSString class]])
//        {
//            
//            NSLog(@".....高度%f",self.envateCell.content.frame.size.height+self.envateCell.content.frame.origin.y);
//            //return 100;
//            return self.envateCell.content.frame.size.height+61;
//        }else
//           
//            return self.envateCell.content.frame.size.height+61+100;
//        
//
//    }
//    }
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
