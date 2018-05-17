//
//  ContiRentViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/8.
//  Copyright © 2018年 changce. All rights reserved.
// 购买出租的产品

#import "BuyRentViewController.h"
#import "PayZViewController.h"
@interface BuyRentViewController ()
@property(nonatomic,strong)NSDictionary *orderDic;
@property (weak, nonatomic) IBOutlet UILabel *need_Pay;

@property(nonatomic,strong)NSMutableArray *icon_LabArr;
@property(nonatomic,strong)NSString *date_Num;
@end

@implementation BuyRentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"购买" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
   // self.order_FeeView.backgroundColor = viewcontrollerColor;
    
    self.corver_View.hidden  = 1;
    self.corver_View.backgroundColor = RGBA(0, 0, 0, .5);
    self.notice_View.layer.cornerRadius = 5;
    self.notice_View.layer.masksToBounds = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCorver)];
    [self.corver_View addGestureRecognizer:tap];
    
    [self.view bringSubviewToFront:self.corver_View];
    self.icon_LabArr = [NSMutableArray array];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)hideCorver{
    self.corver_View.hidden = 1;
}
-(void)loadData
{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":self.order_id,@"goods_id":self.good_Id};
    [self postWithURLString:@"/user/rent_buy_view" parameters:param success:^(id response) {
        SLog(@"详情数据%@",response);
        if(response)
        {
            self.orderDic = response[@"result"];
            [self reloadView];
        }
       
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)reloadView{
    NSDictionary *goodDic = self.orderDic;
    [self.image sd_setImageWithURL:[NSURL URLWithString:goodDic[@"original_img"]] placeholderImage:nil];
    self.name.text = goodDic[@"goods_name"];
    self.spec.text = [NSString stringWithFormat:@"服务费：%@",goodDic[@"server_price"]];
    self.rent_Price.text = [NSString stringWithFormat:@"租金：%@/月",goodDic[@"shop_price"]];
    [self.noti_Lab LabelWithIconStr:@"\U0000e66b" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:15];
    self.need_Pay.text = [NSString stringWithFormat:@"%@元",goodDic[@"buy_price"]];
    self.date_Lab.text = [NSString stringWithFormat:@"%@元",goodDic[@"ready_price"]];
    self.totalPrice_Lab.text = [NSString stringWithFormat:@"%@元",goodDic[@"market_price"]];
    self.total_Amount.text = [NSString stringWithFormat:@"总计：%@元",goodDic[@"buy_price"]];
    self.notice_Tv.text = goodDic[@"buy_notes"];
//    NSArray *date_Arr = self.orderDic[@"monthlist"];
//    CGRect oldRect = self.date_View.frame;
//    self.date_View.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y, oldRect.size.width, date_Arr.count*50+50);
//    self.order_FeeView.frame = CGRectMake(0, oldRect.origin.y+date_Arr.count*50+50, screen_width, self.order_FeeView.frame.size.height);
//    CGFloat startY = 50;
//    for(int i =0;i<date_Arr.count;i++){
//        UILabel *icon_Lab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-200, startY+50*i, 20, 20)];
//        [icon_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
//        icon_Lab.tag = i;
//        [self.date_View addSubview:icon_Lab];
//        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-170, startY+50*i, 150, 20)];
//        lab.text = [NSString stringWithFormat:@"%@  %@/月", date_Arr[i][@"name"],goodDic[@"shop_price"]];
//        lab.tag = i;
//        lab.font = [UIFont systemFontOfSize:15];
//        [self.date_View addSubview:lab];
//        [self.icon_LabArr addObject:icon_Lab];
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(screen_width-200,startY+50*i , 200, 50);
//        btn.tag = i;
//        [btn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
//        [self.date_View addSubview:btn];
//        
//    
//    }
    
}
-(void)selectDate:(UIButton *)sender{
    NSInteger index = sender.tag;
    self.date_Num =[NSString stringWithFormat:@"%@", self.orderDic[@"monthlist"][index][@"value"]];
    self.date_Lab.text = [NSString stringWithFormat:@"续租%@个月",self.date_Num];
    CGFloat price = [self.date_Num floatValue ]*[self.orderDic[@"goodsinfo"][@"shop_price"]floatValue];
    self.totalPrice_Lab.text = [NSString stringWithFormat:@"租期费用共计：%.2f元",price];
    CGFloat totals = price+[self.orderDic[@"goodsinfo"][@"server_price"]floatValue];
    self.total_Amount.text = [NSString stringWithFormat:@"总计：%.2f",totals];
    
    for(int i =0;i<self.icon_LabArr.count;i++){
        UILabel *labe = self.icon_LabArr[i];
        if(labe.tag==index){
            labe.textColor = BUTTON_COLOR;
        }else{
            labe.textColor = BASE_GRAY_COLOR;
        }
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

- (IBAction)confirm:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要购买改商品?" preferredStyle:1];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
   
     //   [self presentViewController:alert animated:YES completion:nil];
        NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":self.order_id,@"goods_id":self.good_Id};
        [self postWithURLString:@"/user/rent_buy" parameters:param success:^(id response) {
            if(response){
                [WToast showWithText:@"购买成功"];
                
                [self.navigationController popViewControllerAnimated:0];
            }
        } failure:^(NSError *error) {
            
        }];

    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil   ];
   }
- (IBAction)clickRule:(UIButton *)sender {
    self.corver_View.hidden = 0;
}
@end
