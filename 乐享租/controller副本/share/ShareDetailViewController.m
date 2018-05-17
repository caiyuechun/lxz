//
//  ShareDetailViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ShareDetailViewController.h"
#import "ShareDeTopCell.h"
#import "Socail_ComentCell.h"
#import "ReportViewController.h"
#import "LoginViewController.h"
#import "SettlementViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
@interface ShareDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *corver_View;
@property(nonatomic,strong)NSDictionary *goodDic;
@property(nonatomic,strong)NSMutableArray *coment_Arr;
@property (weak, nonatomic) IBOutlet UIButton *coment_Btn;
@property (weak, nonatomic) IBOutlet UIView *coment_View;
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;
@property (weak, nonatomic) IBOutlet UITextView *coment_Tv;
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)UIView *Img_Scro_PopView;
@property(nonatomic,strong)UIScrollView *chekImgScro;
@end

@implementation ShareDetailViewController
- (IBAction)comnetAction:(UIButton *)sender {
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushView:vc];
    }else{

    self.corver_View.hidden = 0;
    [self.coment_Tv becomeFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"商品详情" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    [self.coment_Btn ButtonWithIconStr:@"\U0000e63b" inIcon:iconfont andSize:CGSizeMake(42, 42) andColor:RGB(68, 154, 242) andiconSize:30];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadComent)];

    self.coment_Arr = [NSMutableArray array];
    self.pageIndex = 1;
    [self createView];
    [self loadData];
    [self loadComent];
    
    self.coment_Tv.delegate = self;
    self.corver_View.hidden = 1;
    self.coment_View.layer.borderColor = viewcontrollerColor.CGColor;
    self.coment_View.layer.borderWidth = 1;
    self.coment_View.layer.cornerRadius = 5;
    self.corver_View.backgroundColor = RGBA(0, 0, 0, .8);
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCorver)];
    [self.corver_View addGestureRecognizer:taps];

    // Do any additional setup after loading the view from its nib.
}
-(void)hideCorver{
    self.corver_View.hidden = 1;
}
-(void)loadData{
   
    NSDictionary *param = nil;
    if([XTool GetDefaultInfo:USER_INFO]){
 param =   @{@"id":self.ids,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    }else{
    param =   @{@"id":self.ids};
    }
    [self postWithURLString:@"/goods/oldgoodsInfo" parameters:param success:^(id response) {
        SLog(@"详情数据===%@",response);
        if(response){
            self.goodDic = response[@"result"];
            NSArray *img_Arr = self.goodDic[@"gallery"];
            self.chekImgScro.contentSize = CGSizeMake(screen_width*img_Arr.count, 0);
            for(int i =0;i<img_Arr.count;i++){
                UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width*i, 0, screen_width, screen_height)];
                [images sd_setImageWithURL:[NSURL URLWithString:img_Arr[i][@"image_url"]] placeholderImage:nil];
                
                //  images.image = [UIImage imageNamed:@"113.jpg"];
                images.contentMode = UIViewContentModeScaleAspectFit;
                [self.chekImgScro addSubview:images];
                
//                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//                btn.frame = CGRectMake(100*i+(i*10), 10, 100, 100);
//                btn.tag = i;
//                [self.img_ScroView addSubview:btn];
//                [btn addTarget:self action:@selector(clickImg:) forControlEvents:UIControlEventTouchUpInside];
            }

            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadComent{
    NSDictionary *param = @{@"goods_id":self.ids,@"p":[NSString stringWithFormat:@"%lu",self.pageIndex]};
    [self postWithURLString:@"/goods/getoldComment" parameters:param success:^(id response) {
        NSLog(@"评论数据==%@",response);
        [self.tableView.mj_footer endRefreshing];
        if(response){
            if(self.pageIndex==1){
                [self.coment_Arr removeAllObjects];
            }
            [self.coment_Arr addObjectsFromArray:response[@"result"]];
            self.pageIndex++;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(textView.text.length>30){
        [textView endEditing:1];
        [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:@""]];
        //   return NO;
    }else{
        self.num_Lab.text = [NSString stringWithFormat:@"%lu/30",(unsigned long)textView.text.length];
    }
    
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self comentAction];
        [self.view endEditing:1];
        self.corver_View.hidden = 1;
      
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
-(void)comentAction{
    
          NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"content":self.coment_Tv.text,@"goods_id":self.ids};
        [self postWithURLString:@"/goods/addoldcomment" parameters:param success:^(id response) {
            NSLog(@"评论数据====%@",response);
            [WToast showWithText:response[@"msg"]];
            self.pageIndex = 1;
            [self loadComent];
        } failure:^(NSError *error) {
            
        }];
        
        


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
    return 1;
    }else{
        return self.coment_Arr.count;
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
    ShareDeTopCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ShareDeTopCell" owner:self options:nil]lastObject];
        [cell bindData:self.goodDic];
        cell.clickImgs = ^(NSInteger index){
            self.Img_Scro_PopView.hidden = 0;
        };
    return cell;
    }else{
    static NSString *CellId = @"cell";
        Socail_ComentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"Socail_ComentCell" owner:self options:nil]lastObject];
        }
        [cell bindData:self.coment_Arr[indexPath.row]];
        return cell;
    }
//    if(indexPath.section==0){
//    
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
    return 275;
    }else{
        return 120;
    }
}
-(void)createView{
    NSArray *data =@[@"\U0000e668",@"\U0000e623"];
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
    [ addtocar setTitle:@"审核报告" forState:UIControlStateNormal];
    addtocar.titleLabel.textAlignment = NSTextAlignmentCenter;
    [addtocar addTarget:self action:@selector(checkReport) forControlEvents:UIControlEventTouchUpInside];
    [addtocar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // addtocar.backgroundColor = PRICE_COLOR;
    [self.bottomView addSubview:addtocar];
    
    
    UIButton *buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buybtn.frame = CGRectMake(screen_width-offwid, 0, offwid, 60);
    [ buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buybtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    buybtn.backgroundColor = BASE_COLOR;
    [buybtn addTarget:self action:@selector(buyNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:buybtn];
    
    //滑动查看图片的视图
    self.Img_Scro_PopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.Img_Scro_PopView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.Img_Scro_PopView];
    self.chekImgScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.chekImgScro.pagingEnabled = 1;
    [self.Img_Scro_PopView addSubview:self.chekImgScro];
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImgs)];
    [self.Img_Scro_PopView addGestureRecognizer:taps];
    self.Img_Scro_PopView.hidden = 1;
}
-(void)hideImgs{
    self.Img_Scro_PopView.hidden = 1;
}
-(void)botomClick:(UIButton *)sender{
    if(sender.tag==1024){
        [self shares];
       
    }
    else{
        if(![XTool GetDefaultInfo:USER_INFO]){
            LoginViewController *vc = [[LoginViewController alloc]init];
            [self pushView:vc];
        }else{
            
            NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"goods_id":self.ids,@"type":@"1"};
            [self postWithURLString:@"/goods/collectGoods" parameters:param success:^(id response) {
                [WToast showWithText:response[@"msg"]];
            } failure:^(NSError *error) {
                
            }];
        }

    }
}
-(void)shares{
    //分享
    //1、创建分享参数
   
     NSArray* imageArray = @[self.goodDic[@"gallery"][0][@"image_url"]];
     //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
     if (imageArray) {
     
     NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
     [shareParams SSDKSetupShareParamsByText:self.goodDic[@"goods"][@"goods_remark"]
     images:imageArray
     url:[NSURL URLWithString:[NSString stringWithFormat:@"http://lxz.ynthgy.com/index.php/Mobile/Goods/oldInfo/id/%@.html",self.goodDic[@"goods"][@"goods_id"]]]
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
 

}
-(void)buyNow:(UIButton *)sender{
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushView:vc];
    }else{

    NSDictionary *param = @{@"goods_id":self.ids,@"goods_num":@"1",@"type":@"1",@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
        [self postWithURLString:@"/cart/addnewCart" parameters:param success:^(id response) {
           // NSLog(@"立即购买==%@",response);
           // [WToast showWithText:response[@"msg"]];
            SettlementViewController *vc = [[SettlementViewController alloc]init];
            [self pushView:vc];

        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)checkReport{
    
    ReportViewController *vc = [[ReportViewController alloc]init];
    vc.result = self.goodDic[@"goods"];
    [self pushView:vc];
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
