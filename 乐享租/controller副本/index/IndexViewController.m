//
//  IndexViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "IndexViewController.h"
#import "Index_TimesCell.h"
#import "IndexFlash_Cell.h"
#import "Index_RecomdCell.h"
#import "RandomCell.h"
#import "Index_NewCell.h"
#import "RaiseCell.h"
#import "GoodListViewController.h"
#import "Index_EditRecmodCell.h"
#import "GoodDetailViewController.h"
#import "SearchViewController.h"
#import "ListViewController.h"
#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "SocailDetailViewController.h"
#import "ShopCarViewController.h"
#import "OrderListViewController.h"
#import "MybolletViewController.h"
#import "MyDistubeViewController.h"
#import "MessageViewController.h"
#import "SecTimeViewController.h"
#import "AppDelegate.h"
#import "SecKillCell.h"
#import "SetViewController.h"
#import "SlideLeftViewController.h"
#import "ChangePwdViewController.h"
@interface IndexViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *datas;
@property(assign)BOOL isopenDraw;
@end

@implementation IndexViewController
-(void)viewWillAppear:(BOOL)animated{
    if([XTool GetDefaultInfo:USER_INFO])
    {
        NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];;
        [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:user_Dic[@"head_pic"]] placeholderImage:nil];
        self.nick_Lab.text = user_Dic[@"nickname"];
    
        [self.cover_Icon sd_setImageWithURL:[NSURL URLWithString:user_Dic[@"head_pic"]] placeholderImage:nil];
        self.cover_Nick.text = user_Dic[@"nickname"];

       // self.creit_Lab.text = [NSString stringWithFormat:@"信誉额度：%@",user_Dic[@"credit"]];
    }else
    {
        self.icon_Img.image = [UIImage  imageNamed:@"logo"];
        self.nick_Lab.text = @"";
        
    }

    [self loadData];

}
-(void)lefts:(NSNotification *)noti{
    NSDictionary *dic= noti.object;
    NSInteger index = [dic[@"id"]integerValue];
    NSLog(@"......左边点击的索引值==%ld",index);
   // self.isopenDraw = 0;
//    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
//    [app.drawerController closeDrawerAnimated:YES completion:nil];

    switch (index) {
        case 1:
        {
            ShopCarViewController *       vc =[[ShopCarViewController alloc]init];
            [self pushSecondVC:vc];
        }
            break;
        case 0:{
            OrderListViewController*  vc =  [[OrderListViewController alloc]init];
            vc.sattus = @"";
            [self pushSecondVC:vc];
        }
            break;
        case 3:{
                        ChangePwdViewController *vc = [[ChangePwdViewController alloc]init];
                        [self pushSecondVC:vc];
        }
            break;
        case 2:{
            MessageViewController *vc = [[MessageViewController alloc]init];
            [self pushSecondVC:vc];

        }
            break;
        case 4:{
            [XTool SaveDefaultInfo:nil Key:USER_INFO];
                      //  [self.navigationController popViewControllerAnimated:0];
                        [WToast showWithText:@"退出成功"];
            self.icon_Img.image = [UIImage imageNamed:@"logo"];
            self.nick_Lab.text = @"";
//            MyDistubeViewController *vc = [[MyDistubeViewController alloc]init];
//            [self pushSecondVC:vc];
        }
//            break;
//        case 5:{
//            MessageViewController *vc = [[MessageViewController alloc]init];
//            [self pushSecondVC:vc];
//        }
//            break;
            
        default:
            break;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lefts:) name:@"left" object:nil];
    [self.serach_Btn ButtonWithIconStr:@"\U0000e634" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_GRAY_COLOR andiconSize:25];
    //e609
    [self.message_Btn ButtonWithIconStr:@"\U0000e609" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_GRAY_COLOR andiconSize:25];
    [self.message_Btn addTarget:self action:@selector(checkMess) forControlEvents:UIControlEventTouchUpInside];

    self.notiNum_Lab.layer.cornerRadius = 8;
    self.notiNum_Lab.layer.masksToBounds = 1;
    self.notiNum_Lab.text = @"2";
    self.notiNum_Lab.hidden = 1;
    
    self.icon_Img.layer.cornerRadius = 18;
    self.icon_Img.userInteractionEnabled = 1;
    self.icon_Img.layer.masksToBounds = 1;
    
   
    self.cover_Icon.layer.cornerRadius = 25;
    self.cover_Icon.userInteractionEnabled = 1;
    self.cover_Icon.layer.masksToBounds = 1;
    
    
    
    UITapGestureRecognizer *icon_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickIcon)];
    [self.icon_Img addGestureRecognizer:icon_Tap];
    
    self.nick_Lab.text = @"租客007";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initCoverView];
    
   // [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)checkMess{
    MessageViewController *vc = [[MessageViewController alloc]init];
    [self pushSecondVC:vc];
}
//布局左边覆盖视图
-(void)initCoverView{
    self.cover_View.backgroundColor = RGBA(0, 0, 0, .5);
    self.cover_ContentView.backgroundColor = RGBA(255, 255, 255, .9);
    self.cover_View.hidden = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCorver)];
    [self.cover_View addGestureRecognizer:tap];
    NSInteger sizeX = 25;
    UIColor *icon_Color = RGB(80, 80, 80);
    [self.icon_Lab1 LabelWithIconStr:@"\U0000e611" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    [self.icon_Lab2 LabelWithIconStr:@"\U0000e87d" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    [self.icon_Lab3 LabelWithIconStr:@"\U0000e640" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    [self.icon_Lab4 LabelWithIconStr:@"\U0000e698" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    [self.icon_Lab5 LabelWithIconStr:@"\U0000e63b" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    [self.icon_Lab6 LabelWithIconStr:@"\U0000e610" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    
    self.shop_NumLab.layer.masksToBounds = 1;
    self.shop_NumLab.layer.cornerRadius = 10;
    self.shop_NumLab.hidden = 1;
    
    self.noti_NumLab.layer.masksToBounds = 1;
    self.noti_NumLab.layer.cornerRadius = 10;
    self.noti_NumLab.hidden = 1;
    
    self.order_NumLab.layer.masksToBounds = 1;
    self.order_NumLab.layer.cornerRadius = 10;
    self.order_NumLab.hidden = 1;

    self.cover_View.frame =[[UIScreen mainScreen] bounds];
    [[[[[[UIApplication
          sharedApplication] delegate] window] rootViewController] view]
     addSubview:self.cover_View];
}
-(void)hideCorver{
    self.cover_View.hidden = 1;
}
-(void)clickIcon{

    
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
    }else{
        SlideLeftViewController *vc = [[SlideLeftViewController alloc]init];
        [self.revealSideViewController pushViewController:vc onDirection:PPRevealSideDirectionLeft animated:YES];
//        AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication]delegate];
//        self.isopenDraw = !self.isopenDraw;
//        [app.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//        if(self.isopenDraw){
//        [app.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
//        }else{
//         [app.drawerController closeDrawerAnimated:YES completion:nil];
//        }
//        CATransition *animation = [CATransition animation];
//        //设置运动轨迹的速度
//        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//        //设置动画类型为立方体动画
//        animation.type = @"reveal";
//        //设置动画时长
//        animation.duration =.4f;
//        //设置运动的方向
//        
//        animation.subtype =kCATransitionFromRight;
//        //控制器间跳转动画
//        [self.cover_View.layer addAnimation:animation forKey:nil];
//
//        self.cover_View.hidden = 0;
      //  self.tabBarController.tabBar.hidden = 1;
        //        [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];

//        UserInfoViewController *vc = [[UserInfoViewController alloc]init];
//        [self pushSecondVC:vc];
    }
}
-(void)loadData{
    NSDictionary *parm = nil;
    if([XTool GetDefaultInfo:USER_INFO]){
        parm = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    }
    [self postWithURLString:@"/index/home" parameters:parm success:^(id response) {
        NSLog(@"首页数据输出==%@",response);
        if(response){
            self.datas = response[@"result"];
            //消息数量
            if([self.datas[@"user"][@"count"]integerValue]>0){
                self.noti_NumLab.hidden = 0;
                self.noti_NumLab.text = [NSString stringWithFormat:@"%@",self.datas[@"user"][@"count"]];
                self.notiNum_Lab.hidden = 0;
                self.notiNum_Lab.text = [NSString stringWithFormat:@"%@",self.datas[@"user"][@"count"]];
            }else{
             self.noti_NumLab.hidden = 1;
                 self.notiNum_Lab.hidden = 1;
            }
            //购物车数量
            if([self.datas[@"user"][@"carnum"]integerValue]>0){
                self.shop_NumLab.hidden = 0;
                self.shop_NumLab.text = [NSString stringWithFormat:@"%@",self.datas[@"user"][@"carnum"]];
            }else{
            self.shop_NumLab.hidden = 1;
            }
            //订单数量
            if([self.datas[@"user"][@"ordernum"]integerValue]>0){
                self.order_NumLab.hidden = 0;
                self.order_NumLab.text = [NSString stringWithFormat:@"%@",self.datas[@"user"][@"ordernum"]];
            }else{
             self.order_NumLab.hidden = 1;
            }

            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadNum" object:self.datas[@"user"]];;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
//构造头部
-(UIView *)createHeadView:(NSString *)title AndRight:(BOOL)hasright Andsection:(NSInteger)index AndRightAction:(SEL)rightAction{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 50)];
    
    UILabel *titles = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    titles.text = title;
    titles.font = [UIFont systemFontOfSize:15];
    [headView addSubview:titles];
    headView.backgroundColor = [UIColor whiteColor];
    if(hasright){
    UIButton *more_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    more_Btn.frame = CGRectMake(screen_width-73, 0, 65, 50);
    [more_Btn setTitle:@"更多" forState:UIControlStateNormal];
    [more_Btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    more_Btn.titleLabel.font = [UIFont systemFontOfSize:14];
    more_Btn.tag = index;
    [more_Btn addTarget:self action:@selector(moreActions:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:more_Btn];
    UILabel *more_Lab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-25, 15, 21, 21)];
    [more_Lab LabelWithIconStr:@"\U0000e63c" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    [headView addSubview:more_Lab];
    }
    return headView;
   
}
//更多的操作按钮
-(void)moreActions:(UIButton *)sender{
    NSLog(@"点击的按钮索引==%ld",(long)sender.tag);
    NSString *titles = @"";
    NSString *typeStr = @"";
    if(sender.tag==1){
        SecTimeViewController *vc = [[SecTimeViewController alloc]init];
        [self pushSecondVC:vc];
    }else{
    if(sender.tag==2){
    titles = @"编辑精选";
        typeStr = @"is_hot";
    }else if (sender.tag==3){
    titles = @"今日推荐";
        typeStr = @"is_recommend";
    }else{
        titles = @"新奇玩意";
        typeStr = @"is_new";
      //  typeStr = @"is_new";

    }
    ListViewController *vc = [[ListViewController alloc]init];
    vc.title = titles;
    vc.typeStr = typeStr;
    [self pushSecondVC:vc];
    }
//    GoodListViewController *vc = [[GoodListViewController alloc]init];
//    [self pushSecondVC:vc];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0||section==2){
        return CGFLOAT_MIN;
    }else return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0||section==2){
        return [[UIView alloc]initWithFrame:CGRectZero];
    }else{
        BOOL hasRight = 1;
        NSString *titleStr = @"";
        if(section==1){
         titleStr = @"限时抢租";
        }
        if(section==2){
      //  titleStr = @"编辑精选";
        } if (section==3){
        titleStr = @"今日推荐";
        } if (section==4){
        titleStr = @"新奇玩意";
        }if(section==5){
        titleStr = @"随便逛逛";
            hasRight = 0;
        }
        return [self createHeadView:titleStr AndRight:hasRight Andsection:section AndRightAction:@selector(click:)];
    }
}
-(void)click:(UIButton *)sender{

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==2){
        return 0;
    }
    if(section==1){
        NSArray *data = self.datas[@"sec_kill"];
        NSInteger RowNum = data.count%2==0?data.count/2:data.count/2+1;
        return RowNum;
    }
    if(section==3){
        return [self.datas[@"recommend"]count];
    }else if(section==5){
        NSArray *data =self.datas[@"lookgoods"];
        NSInteger RowNum = data.count%2==0?data.count/2:data.count/2+1;
        return RowNum;
    }else
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak IndexViewController *weakSelf = self;
    if(indexPath.section==0){
        IndexFlash_Cell *cell = [[[NSBundle mainBundle]loadNibNamed:@"IndexFlash_Cell" owner:self options:nil]lastObject];
        [cell bindData:self.datas];
        cell.clickCatogry=^(NSInteger index,NSInteger types){
            NSLog(@"...点击的分类索引%ld",index);
           
            
            
//            NSDictionary *dic = imageArr[index];
//            GoodListViewController *vc = [[GoodListViewController alloc]init];
//            vc.catogryId = [NSString stringWithFormat:@"%@", dic[@"id"]];
//            [weakSelf pushSecondVC:vc];

            
                       if(types==0){
                NSArray *imageArr = self.datas[@"ad"];
                NSDictionary *dic = imageArr[index];
                           if([dic[@"ad_link"]isEqualToString:@""])
                           {
                               return ;
                           }

            //1:产品单品，2产品分类，3专题
            if([dic[@"type"]integerValue]==1)
            {
                GoodDetailViewController *vc =[[GoodDetailViewController alloc]init];
                vc.goodsID = [NSString stringWithFormat:@"%@", dic[@"ad_link"]];
                [weakSelf pushSecondVC:vc];
            }else if ([dic[@"type"]integerValue]==2)
            {
                GoodListViewController *vc = [[GoodListViewController alloc]init];
                vc.catogryId = [NSString stringWithFormat:@"%@", dic[@"ad_link"]];
                [weakSelf pushSecondVC:vc];
            }else
            {
                SocailDetailViewController *vc = [[SocailDetailViewController alloc]init];
                vc.article_id =  [NSString stringWithFormat:@"%@", dic[@"ad_link"]];
               [weakSelf pushSecondVC:vc ];
           }
            }else{
                NSDictionary *diction = self.datas[@"categorylist"][index];
                GoodListViewController *vc = [[GoodListViewController alloc]init];
                vc.catogryId = [NSString stringWithFormat:@"%@", diction[@"id"]];
                [weakSelf pushSecondVC:vc];

            }

           // [weakSelf pushSecondVC:vc];
        };
        return cell;
    }
    else if(indexPath.section==1){
        SecKillCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"SecKillCell" owner:self options:nil]lastObject];
        NSMutableArray *arr =[NSMutableArray array];
        NSDictionary *dic = [self.datas[@"sec_kill"] objectAtIndex:indexPath.row*2];
        [arr addObject:dic];
        if([self.datas[@"sec_kill"]count]>indexPath.row*2+1)
        {
            NSDictionary *dic = [self.datas[@"sec_kill"] objectAtIndex:indexPath.row*2+1];
            [arr addObject:dic];
        }
        [cell bindData:arr andIndex:indexPath.row];
        cell.clickItemBlock = ^(UIButton *sender){
            NSInteger index = sender.tag;
            GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
            vc.goodsID = self.datas[@"sec_kill"][index][@"goods_id"];
            [self pushSecondVC:vc];

//            pvc.isSecond = 1;
//            GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
//            vc.goodsID = self.dataSouce[@"sec_kill"][@"list"][sender.tag][@"goods_id"];
//            vc.isSecKill =1;
           // [pvc pushSecondVC:vc];
        };
        return cell;
    }else if(indexPath.section==3){
    static NSString *CellId = @"recomend";
        Index_RecomdCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"Index_RecomdCell" owner:self options:nil]lastObject];
        }
        [ cell bindData:self.datas[@"recommend"][indexPath.row]];
        return cell;
    }else if(indexPath.section==4){
        RaiseCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"RaiseCell" owner:self options:nil]lastObject];
        [cell bindData:self.datas[@"newsgoods"]];
        cell.clickItems=^(NSInteger index){
            GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
            vc.goodsID = self.datas[@"newsgoods"][index][@"goods_id"];
            [self pushSecondVC:vc];
        };

        return cell;
    }else if(indexPath.section==5){
       static NSString *cellID = @"random";
        RandomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RandomCell" owner:self options:nil]lastObject];
           // return cell;
        }
        NSMutableArray *arr =[NSMutableArray array];
        NSDictionary *dic = [self.datas[@"lookgoods"] objectAtIndex:indexPath.row*2];
        [arr addObject:dic];
        if([self.datas[@"lookgoods"] count]>indexPath.row*2+1)
        {
            NSDictionary *dic = [self.datas[@"lookgoods"] objectAtIndex:indexPath.row*2+1];
            [arr addObject:dic];
        }
        [cell bindData:arr andIndex:indexPath.row];
        cell.clickItemBlock=^(UIButton *sender){
            GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
            vc.goodsID = self.datas[@"lookgoods"][indexPath.row][@"goods_id"];
            [weakSelf pushSecondVC:vc];

        };
        return cell;
    }else{
        static NSString *cellID = @"editcell";
        Index_EditRecmodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
       cell = [[[NSBundle mainBundle]loadNibNamed:@"Index_EditRecmodCell" owner:self options:nil]lastObject];
        }
        [cell bindData:self.datas];
        cell.clickitems = ^(NSInteger index){
            NSDictionary *dic = nil;
            if(index==0||index==1){
                NSArray *left = self.datas[@"adleft"];
                dic = left[index];
              //  [self.img1 sd_setImageWithURL:[NSURL URLWithString:left[0][@"ad_code"]] placeholderImage:[UIImage imageNamed:@"left-1"]];
              //  [self.img2 sd_setImageWithURL:[NSURL URLWithString:left[1][@"ad_code"]] placeholderImage:nil];
                

            }else{
            dic = self.datas[@"adright"];
                 //dic = right[0];
            }
            //1:产品单品，2产品分类，3专题
            if([dic[@"type"]integerValue]==1)
            {
                GoodDetailViewController *vc =[[GoodDetailViewController alloc]init];
                vc.goodsID = [NSString stringWithFormat:@"%@", dic[@"ad_link"]];
                [weakSelf pushSecondVC:vc];
            }else if ([dic[@"type"]integerValue]==2)
            {
                GoodListViewController *vc = [[GoodListViewController alloc]init];
                vc.catogryId = [NSString stringWithFormat:@"%@", dic[@"ad_link"]];
                [weakSelf pushSecondVC:vc];
            }else
            {
                SocailDetailViewController *vc = [[SocailDetailViewController alloc]init];
                vc.article_id =  [NSString stringWithFormat:@"%@", dic[@"ad_link"]];
                [weakSelf pushSecondVC:vc ];
            }

        } ;
        return cell;
     
    }
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 300;
    }else if(indexPath.section==1){
        
        NSArray *data = self.datas[@"sec_kill"];
        if(data.count==0){
            return 0;
        }else{
         NSInteger RowNum = data.count%2==0?data.count/2:data.count/2+1;
       // NSInteger num = data.count/2;
        return 285*RowNum;
        }
    }else if(indexPath.section==3){
        return 140;
    }else if (indexPath.section==4){
        return 227;
    }else if(indexPath.section==5) return 275;
    else return  CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==3){
        GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
        vc.goodsID = self.datas[@"recommend"][indexPath.row][@"goods_id"];
        [self pushSecondVC:vc];
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

- (IBAction)searchAction:(UIButton *)sender {
    SearchViewController *vc = [[SearchViewController alloc]init];
    [self pushSecondVC:vc];
}
- (IBAction)left_Action:(UIButton *)sender {
    self.cover_View.hidden = 1;
//    [[[[[[UIApplication
//          sharedApplication] delegate] window] rootViewController] view]
//     remov];
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
        [WToast showWithText:@"请登录"];
        return;
    }
    NSInteger index = sender.tag;
   // UIViewController *vc = nil;
    switch (index) {
        case 0:
        {
     ShopCarViewController *       vc =[[ShopCarViewController alloc]init];
            [self pushSecondVC:vc];
        }
            break;
        case 1:{
          OrderListViewController*  vc =  [[OrderListViewController alloc]init];
            vc.sattus = @"";
        [self pushSecondVC:vc];
        }
            break;
        case 2:{
//            MybolletViewController *vc = [[MybolletViewController alloc]init];
//            [self pushSecondVC:vc];
        }
            break;
        case 3:{}
            break;
        case 4:{
            MyDistubeViewController *vc = [[MyDistubeViewController alloc]init];
            [self pushSecondVC:vc];
        }
            break;
        case 5:{
            MessageViewController *vc = [[MessageViewController alloc]init];
            [self pushSecondVC:vc];
        }
            break;
            
        default:
            break;
    }
}
@end
