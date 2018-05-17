//
//  GoodDetailViewController.m
//  chuangyi
// 111111
//  Created by caiyc on 17/8/4.
//  Copyright © 2017年 changce. All rights reserved.
//   222222222

#import "PGoodDetailViewController.h"
#import "GoodsFlashCell.h"
#import "goodInfosCells.h"
#import "GoodSpecCell.h"
#import "envalteCell.h"
//#import "specView.h"
//#import "packageViewController.h"
#import "ShopCarViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "LoginViewController.h"
//#import "GoodCommentViewController.h"
//#import "SecKillDetailCell.h"
//#import "IndexViewController.h"
#import "SettlementViewController.h"
//#import "HomeViewController.h"
//#import "LoginViewController.h"
//#import "IndexViewController.h"


@interface PGoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *goodDic;
@property(nonatomic,strong)goodInfosCells *goodInfocCell;
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

@end

@implementation PGoodDetailViewController
-(void)reloadDatas
{
    NSDictionary *paramter = nil;
    if([XTool GetDefaultInfo:USER_INFO])
    {
        NSString *uid = [XTool GetDefaultInfo:USER_INFO][USER_ID];
        paramter = @{@"type":@"0",@"id":self.goodsID,@"user_id":uid};
    }else
    {
        paramter = @{@"type":@"0",@"id":self.goodsID};
    }

    self.isSecKill = 0;
    [self getWithURLString:@"/goods/goodsInfo" parameters:paramter success:^(id response) {
        SLog(@"产品详情输出%@",response);
        self.goodDic = response[@"result"];
        [self.tableView reloadData];
        BOOL iscollect = [self.goodDic[@"goods"][@"icollect"]boolValue];
        if(iscollect){
            UIButton *btn = (UIButton *)[self.bottomView viewWithTag:1025];
            [btn ButtonWithIconStr:@"\U0000e623" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_COLOR andiconSize:25];
            
        }
        [self.web loadHTMLString:self.goodDic[@"goods"][@"goods_content"] baseURL:nil];

        
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
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDatas) name:@"timeoutss" object:nil];
    self.comentArr = [NSMutableArray array];
  //  [self initNaviView:[UIColor whiteColor] hasLeft:0 leftColor:[UIColor grayColor] title:@"" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:[UIColor grayColor] title:@"详情" titleColor:[UIColor blackColor] right:@"详情" rightColor:nil rightAction:nil];
    self.naviView.backgroundColor = RGBA(255, 255, 255, 0);
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(10, 15, 40, 40);
    [left ButtonWithIconStr:@"\U0000e642" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:[UIColor grayColor] andiconSize:30];
    [left addTarget:self action:@selector(backtofirst) forControlEvents:UIControlEventTouchUpInside];
    //  [self.naviView addSubview:left];
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.frame = CGRectMake(screen_width-100, 15, 40, 40);
    [right1 ButtonWithIconStr:@"\U0000e668" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    [right1 addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    //   [self.naviView addSubview:right1];
    UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    right2.frame = CGRectMake(screen_width-50, 15, 40, 40);
    [right2 ButtonWithIconStr:@"\U0000e668" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    [right2 addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:right2];
    
    
    self.bottomScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, naviHei, screen_width, screen_height-naviHei-60)];
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
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_height-naviHei-60, screen_width, screen_height-naviHei-60)];
    secondView.backgroundColor = [UIColor redColor];
    [self.bottomScroView addSubview:secondView];
    
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screen_width, secondView.frame.size.height)];
    [secondView addSubview:self.web];
  //  self.web.delegate = self;
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_height-60, screen_width, 60)];
    UILabel *horline = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screen_width, 1)];
    horline.backgroundColor = RGB(225, 225, 225);
    [self.bottomView addSubview:horline];
    NSArray *data =@[@"\U0000e7a8",@"\U0000e7b0"];
    for(int i =0;i<2;i++){
        UIButton *shreBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
        shreBtn.frame = CGRectMake(59*i, 0, 60, 60);
        [shreBtn ButtonWithIconStr:data[i] inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:[UIColor grayColor] andiconSize:25];
        [self.bottomView addSubview:shreBtn];
        [shreBtn addTarget:self action:@selector(botomClick:) forControlEvents:UIControlEventTouchUpInside];
        shreBtn.tag = 1024+i;
        UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(59*(i+1), 0, 1, 60)];
        linelabel.backgroundColor = RGB(225, 225, 225);
   //     [self.bottomView addSubview:linelabel];
    }
    CGFloat offwid = (screen_width-120)/2;
    UIButton *addtocar = [UIButton buttonWithType:UIButtonTypeCustom];
    addtocar.frame = CGRectMake(0, 0, screen_width, 60);
    [ addtocar setTitle:@"立即购买" forState:UIControlStateNormal];
    addtocar.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addtocar addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
    [addtocar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addtocar.backgroundColor = PRICE_COLOR;
    [self.bottomView addSubview:addtocar];


    UIButton *buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buybtn.frame = CGRectMake(0, 0, offwid, 60);
    [ buybtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    buybtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    buybtn.backgroundColor = BASE_COLOR;
    [buybtn addTarget:self action:@selector(addCar:) forControlEvents:UIControlEventTouchUpInside];
   // [self.bottomView addSubview:buybtn];
    
    [self.view addSubview:self.bottomView];

    //规格弹出视图
    self.SpecPopView = [[UIView alloc]initWithFrame:CGRectMake(0, screen_height, screen_width, screen_height)];
    self.SpecPopView.backgroundColor = RGBA(0, 0, 0, .5);
    [self.view addSubview:self.SpecPopView];
    //self.SpecPopView.hidden = 1;
    UITapGestureRecognizer *tapss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.SpecPopView addGestureRecognizer:tapss];
    
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
    [self getWithURLString:@"/goods/tgoodsInfo" parameters:paramter success:^(id response) {
        SLog(@"产品详情输出%@",response);
        self.goodDic = response[@"result"];
        [self.tableView reloadData];
        BOOL iscollect = [self.goodDic[@"goods"][@"icollect"]boolValue];
        if(iscollect){
        UIButton *btn = (UIButton *)[self.bottomView viewWithTag:1025];
            [btn ButtonWithIconStr:@"\U0000e7b0" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_COLOR andiconSize:25];

        }
        [self.web loadHTMLString:self.goodDic[@"goods"][@"goods_content"] baseURL:nil];
        

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
   
    } failure:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)backtofirst
{
   // for()
   [self.navigationController popViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 0;
}

-(void)backHome
{
}
-(void)missSevice
{
    self.seviceView.hidden = 1;
}
-(void)missImgScro
{
    self.imageScro.hidden = 1;
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
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"http://lxz.ynthgy.com/Mobile/Goods/pinfo/id/%@.html",self.goodsID]]
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

-(void)botomClick:(UIButton *)sneder
{
    //tag 1024,1025,1026
    if(sneder.tag==10)
    {
//        if(![XTool GetDefaultInfo:USER_INFO])
//        {
//            [WToast showWithText:@"先登录"];
//            return;
//        }
//        //分享
//        //1、创建分享参数
//        NSArray* imageArray = @[self.goodDic[@"gallery"][0][@"image_url"]];
//        //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//        if (imageArray) {
//            
//            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//            [shareParams SSDKSetupShareParamsByText:self.goodDic[@"goods"][@"goods_remark"]
//                                             images:imageArray
//                                                url:[NSURL URLWithString:[NSString stringWithFormat:@"http://lmrz.ynthgy.com/index.php/Mobile/Goods/goodsInfo/id/141/user_id/%@.html",[XTool GetDefaultInfo:USER_INFO][USER_ID]]]
//                                              title:self.goodDic[@"goods"][@"goods_name"]
//                                               type:SSDKContentTypeAuto];
//            //有的平台要客户端分享需要加此方法，例如微博
//            [shareParams SSDKEnableUseClientShare];
//            //2、分享（可以弹出我们的分享菜单和编辑界面）
//            [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                                     items:nil
//                               shareParams:shareParams
//                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                           
//                           switch (state) {
//                               case SSDKResponseStateSuccess:
//                               {
//                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                       message:nil
//                                                                                      delegate:nil
//                                                                             cancelButtonTitle:@"确定"
//                                                                             otherButtonTitles:nil];
//                                   [alertView show];
//                                   break;
//                               }
//                               case SSDKResponseStateFail:
//                               {
//                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                                   message:[NSString stringWithFormat:@"%@",error]
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"OK"
//                                                                         otherButtonTitles:nil, nil];
//                                   [alert show];
//                                   break;
//                               }
//                               default:
//                                   break;
//                           }
//                       }  
//             ];}
        
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
        //vc.isNotMain = 0;
        //vc.hasLft = 1;
        [self pushView:vc];
    }else
    {
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
                    [sneder ButtonWithIconStr:@"\U0000e7b0" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:[UIColor grayColor] andiconSize:25];
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

                    [sneder ButtonWithIconStr:@"\U0000e7b0" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_COLOR andiconSize:25];
                }
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}
//立即购买
-(void)buyNow
{
    NSDictionary *param =@{@"goods_id":self.goodsID,@"goods_num":@"1",@"type":@"2",@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/cart/addnewCart" parameters:param success:^(id response) {
       
        if(response){
             [WToast showWithText:response[@"msg"]];
            SettlementViewController *vc = [[SettlementViewController alloc]init];
            [self pushView:vc];
        }
    } failure:^(NSError *error) {
        
    }];
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
    [UIView animateWithDuration: 0.35 animations: ^{
        self.SpecPopView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        //        self.view.center = center;
        //        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        
    } completion: nil];
    
}
-(void)requestToCar
{
    if(![XTool GetDefaultInfo:USER_INFO])
    {
        [WToast showWithText:@"先登录"];
        return;
    }

          NSDictionary *param = @{@"goods_id":self.goodsID,@"goods_num":self.countNum,@"goods_spec":self.specStr,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"buynow":[NSString stringWithFormat:@"%d",self.buyrightNow]};
   // NSDictionary *param = @{@"goods_id":self.goodsID,@"goods_num":self.countNum,@"goods_spec":self.specStr,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};

        NSLog(@"购物车参数%@",param);
        [self postWithURLString:@"/cart/addCart" parameters:param success:^(id response) {
            NSLog(@"加入购物车操作%@",response);
            if([response[@"status"]integerValue]==1)
            {
                if(!self.buyrightNow)
                {
                    NSInteger nums = [[XTool GetDefaultInfo:SHOPCARNUMS]integerValue];
                    NSInteger numss =[self.countNum integerValue];
                    NSInteger offnum = nums+numss;
                    [XTool SaveDefaultInfo:[NSString stringWithFormat:@"%ld",(long)offnum] Key:SHOPCARNUMS];
                    NSDictionary *userDic = @{@"num":[NSString stringWithFormat:@"%ld",(long)offnum]};
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"addshopNumber" object:userDic];
                    
                }

                
                if(self.buyrightNow)
                {
                    SettlementViewController *vc = [[SettlementViewController alloc]init];
                    [self pushView:vc];
                }else{
                [WToast showWithText:response[@"msg"]];
                }
            }
        } failure:^(NSError *error) {
            
        }];
   

}
-(void)sure
{
    //
    [self dismiss];
    
}
#pragma mark tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==1)
    {
        return 1;

    }else if (section==3)
    {
        return self.comentArr.count;
    }
    else
    {
    return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 4;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
    static NSString *cellid = @"cell";
    GoodsFlashCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GoodsFlashCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.goodDic[@"gallery"]];
    return cell;
    }
    if(indexPath.section==1)
    {
                static NSString *cellid = @"cellsd";
        self.goodInfocCell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if(!self.goodInfocCell)
        {
            self.goodInfocCell = [[[NSBundle mainBundle]loadNibNamed:@"goodInfosCells" owner:self options:nil]lastObject];
        }
        if(self.goodDic.count>0)
        {
        [self.goodInfocCell bindData:self.goodDic[@"goods"]];
        }
        __weak PGoodDetailViewController *weakSelf = self;
        self.goodInfocCell.checkAllcomm = ^(){

            
        };
        return self.goodInfocCell;
        }else if (indexPath.section==2)
    {
    static NSString *cellid = @"cells";
        GoodSpecCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"GoodSpecCell" owner:self options:nil]lastObject];
        }
        return cell;
        
    }
    
    else
    {
        static NSString *cellId = @"cellssssss";
        self.envateCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!self.envateCell)
        {
            self.envateCell = [[[NSBundle mainBundle]loadNibNamed:@"envalteCell" owner:self options:nil]firstObject];
        }
        if(self.comentArr.count>0)
        {
              [self.envateCell bindData:self.comentArr[indexPath.row]];
         //   [self.envateCell bindData:self.comentArr[indexPath.row] andIndex:indexPath.row andCount:self.comentArr.count];
        }
      __weak PGoodDetailViewController * weakSelf = self;
        self.envateCell.checkImage=^(UIButton *sender)
        {
            weakSelf.imageScro.hidden = 0;
            for(UIView *view in [weakSelf.imageScro subviews])
            {
                [view removeFromSuperview];
            }
            [weakSelf.imageScro setContentSize:CGSizeMake(screen_width*[weakSelf.comentArr[indexPath.row][@"img"]count], screen_height)];
            for(int i =0;i<[weakSelf.comentArr[indexPath.row][@"img"]count];i++)
            {
                UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width*i, 0, screen_width, screen_height)];
                images.contentMode = UIViewContentModeScaleAspectFit;
                NSString *urlStr = [NSString stringWithFormat:@"%@",weakSelf.comentArr[indexPath.row][@"img"][i]];
                [images sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                [weakSelf.imageScro addSubview:images];
            }
            
            
//                     NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_SERVICE,weakSelf.comentArr[indexPath.row][@"img"][sender.tag]];
//                       [weakSelf.cheImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
//                       weakSelf.CheckImgaeView.hidden = 0;
        };
        return self.envateCell;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 if(section==2||section==3)
 {
     if(section==3)
     {
         return 60;
     }else
     return 10;
 }else return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==3)
    {
        return 40;
    }else return CGFLOAT_MIN;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==3)
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==2||section==3)
    {
        if(section==2)
        {
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 10)];
        headview.backgroundColor = viewcontrollerColor;
        return headview;
        }else
        {
            UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 60)];
            headview.backgroundColor = viewcontrollerColor;
            UIView *contView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, screen_width, 50)];
            contView.backgroundColor = [UIColor whiteColor];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screen_width-100, 50)];
            // label.text =@"用户评论";
           label.text = [NSString stringWithFormat:@"用户评论(%@)",self.goodDic[@"goods"][@"comment_count"]];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = RGB(100, 100, 100);
            [contView addSubview:label];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screen_width-100, 0, 100, 50);
            [btn setTitle:@"查看全部 >" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
            [contView addSubview:btn];
            [btn addTarget:self action:@selector(checkAll) forControlEvents:UIControlEventTouchUpInside];
            
            [headview addSubview:contView];
            
            UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(10, 59, screen_width-10, 1)];
            labe.backgroundColor = viewcontrollerColor;
            [headview addSubview:labe];
            return headview;

        }
    }else return [[UIView alloc]initWithFrame:CGRectZero];
}
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
      
        NSLog(@"产品详情信息高度%f",self.goodInfocCell.price.frame.origin.y+self.goodInfocCell.price.frame.size.height);
        CGFloat hei = 0.0;
        if(self.goodInfocCell.price.frame.origin.y+self.goodInfocCell.price.frame.size.height<80)
        {
            hei =85;
        }else
        {
            hei = self.goodInfocCell.price.frame.origin.y+self.goodInfocCell.price.frame.size.height+5;
        }
        return hei;
       
    }
    else if (indexPath.section==2)
    {
        return 0;
    }
    else
    {
        if(self.comentArr.count==0)
        {
            return 0;
        }
        else return self.envateCell.imgScroView.frame.size.height+self.envateCell.imgScroView.frame.origin.y+10;
    }
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
