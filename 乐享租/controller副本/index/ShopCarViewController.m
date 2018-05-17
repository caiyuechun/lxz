//
//  ShopCarViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarCell.h"
#import "SettlementZViewController.h"
#import "GoodListViewController.h"
@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSDictionary *carDic;
@property(assign)BOOL selctAll;
@end

@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"购物车" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(screen_width-leftSpece-btnSize+15,(naviHei-btnSize)/2+13 , btnSize-15, btnSize-15)];
    [rightBtn setImage:[UIImage imageNamed:@"cardele"] forState:UIControlStateNormal];
   // [rightBtn ButtonWithIconStr:right inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor whiteColor] andiconSize:PAPULARFONTSIZE+5];
    
    [rightBtn addTarget:self action:@selector(deleteCar) forControlEvents:UIControlEventTouchUpInside];
    
    [self.naviView addSubview:rightBtn];

    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
     [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    
    self.corver_View.hidden = 1;
    [self loadCar];
    // Do any additional setup after loading the view from its nib.
}
-(void)deleteCar{
    NSMutableString *muti_Str = [NSMutableString string];
    NSInteger select_Num = 0;
    for(int i =0;i<self.dataSource.count;i++){
        if([self.dataSource[i][@"selected"]integerValue]==1){
            [ muti_Str appendFormat:@"%@",self.dataSource[i][@"id"]];
            [muti_Str appendString:@","];
            select_Num++;
        }
    }
    if(select_Num==0){
        [WToast showWithText:@"没有选中的商品"];
        
    }else{
    
    NSString *new_Str = [muti_Str substringWithRange:NSMakeRange(0, muti_Str.length-1)];
        NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"ids":new_Str};
        [self postWithURLString:@"/cart/delCart" parameters:param success:^(id response) {
            
            if(response){
                [WToast showWithText:response[@"msg"]];
                [self loadCar];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)loadCar{
    NSDictionary *parm = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/cart/cartList" parameters:parm success:^(id response) {
        NSLog(@"购物车数据%@",response);
        if([[response objectForKey:@"result"][@"cartList"]count]>0)
        {
            self.carDic = response[@"result"];
            self.dataSource = response[@"result"][@"cartList"];
            
            for(NSDictionary *dic in response[@"result"][@"cartList"])
            {
                if([dic[@"selected"]boolValue]==0)
                {
                    self.selctAll = 0;
                }else
                {
                    self.selctAll = 1;
                    
                }
            }
            if(self.selctAll)
            {
                [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BUTTON_COLOR andiconSize:15];

           //     [self.selectAll ButtonWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(25, 25) andColor:BASE_COLOR andiconSize:20];
            }else
            {
                [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];

             //   [self.selectAll ButtonWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(25, 25) andColor:[UIColor grayColor] andiconSize:20];
            }
            NSString *price = [NSString stringWithFormat:@"¥%@",response[@"result"][@"total_price"][@"total_fee"]];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
            self.priceLb.attributedText = AttributedStr;
            
//            self.bottomView.hidden = 0 ;
//            self.editBtn.hidden = 0;
            [self.tableView reloadData];
            
            NSString *nums =  [NSString stringWithFormat:@"%@",[response objectForKey:@"result"][@"total_price"][@"num"]];
            
            [XTool SaveDefaultInfo:nums Key:SHOPCARNUMS];
            NSDictionary *userDic = @{@"num":nums};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addshopNumber" object:userDic];
            
            self.checkNum.text = [NSString stringWithFormat:@"已选 （%@）",response[@"result"][@"total_price"][@"num"]];
        }else
        {
            self.corver_View.hidden = 0;
//            self.nogoodTableView.hidden = 0;
//            self.bottomView.hidden = 1;
//            self.editBtn.hidden = 1;
//            [self loadgussgoods];
        }
    } failure:^(NSError *error) {
        
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"cell";
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopCarCell" owner:self options:nil]lastObject];
        
    }
    [cell bindData:self.dataSource[indexPath.row]];
    __weak ShopCarCell *weakCell = cell;
    __weak ShopCarViewController *weakSelf = self;
    NSDictionary *indexDic = self.dataSource[indexPath.row];
    //勾选商品
    cell.select = ^(){
     [weakCell.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BUTTON_COLOR andiconSize:15];
        BOOL select =! [indexDic[@"selected"]boolValue];
        NSDictionary *dic = @{@"goodsNum":indexDic[@"goods_num"],@"selected":[NSString stringWithFormat:@"%d",select],@"cartID":indexDic[@"id"]};
        NSMutableString *mutiStr = [[NSMutableString alloc]initWithString: @"["];
        NSString *spec =  [self objcectToJson:dic isEnd:1];
        [mutiStr appendString:spec];
        [mutiStr appendString:@"]"];
        [weakSelf editShopCar:mutiStr];

    };
    cell.numAdd =  ^(NSInteger num){
        NSDictionary *dic = @{@"goodsNum":[NSString stringWithFormat:@"%ld",(long)num],@"selected":indexDic[@"selected"],@"cartID":indexDic[@"id"]};
        NSMutableString *mutiStr = [[NSMutableString alloc]initWithString: @"["];
        NSString *spec =  [self objcectToJson:dic isEnd:1];
        [mutiStr appendString:spec];
        [mutiStr appendString:@"]"];
        [weakSelf editShopCar:mutiStr];

    };
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(void)editShopCar:(NSString *)spec
{
    //[self.dataSource removeAllObjects];
    NSDictionary *parm = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cart_form_data":spec};
    NSLog(@"编辑购物车参数%@",spec);
    [self postWithURLString:@"/cart/cartList" parameters:parm success:^(id response) {
        SLog(@"购物车编辑数据%@",response);
        if(!response)
        {
            return ;
        }
        if([[response objectForKey:@"result"][@"cartList"]count]>0)
        {
            self.carDic = response[@"result"];
            self.dataSource=   response[@"result"][@"cartList"];
            
            NSString *price = [NSString stringWithFormat:@"¥%@",response[@"result"][@"total_price"][@"total_fee"]];
            
            NSString *nums =  [NSString stringWithFormat:@"%@",[response objectForKey:@"result"][@"total_price"][@"num"]];
            [XTool SaveDefaultInfo:nums Key:SHOPCARNUMS];
            NSDictionary *userDic = @{@"num":nums};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addshopNumber" object:userDic];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
            self.priceLb.attributedText = AttributedStr;
            [self.tableView reloadData];
            
            self.checkNum.text = [NSString stringWithFormat:@"已选 （%@）",response[@"result"][@"total_price"][@"num"]];
        }else
        {
//            self.NoGoodview.hidden = 0;
//            self.bottomView.hidden = 1;
        }
    } failure:^(NSError *error) {
        
    }];
    
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
//结算
- (IBAction)cacuAction:(UIButton *)sender {
//    NSString *url = @"alipays://platformapi/startapp?appId=2018042460018473&url=https%253A%252F%252Fmapi.alipay.com%252Fgateway.do%253F_input_charset%253Dutf-8%2526amount%253D1%2526notify_url%253Dhttp%25253A%25252F%25252Flxz.ynthgy.com%25252Fapi%25252Fpayment%25252FalipayNotify%2526order_title%253D%2525E6%252597%2525A0%2525E7%2525BA%2525BF%2525E9%2525A2%252584%2525E6%25258E%252588%2525E6%25259D%252583%2526out_order_no%253D201805031722101525339330%2526out_request_no%253D201805031722101525339330%2526partner%253D2088031889272312%2526pay_mode%253DWIRELESS%2526payee_user_id%253D2088031889272312%2526product_code%253DFUND_PRE_AUTH%2526scene_code%253DHOTEL%2526service%253D%252Balipay.fund.auth.create.freeze.apply%2526sign%253DOtzKeN4kD1Dld611kmljAkWk44Mz7GeJvBPaivG1ls5KjqXutKaz7zT47uHsLyoxTUeZ8R571tC1vuFG4BUATDeLsI5G17n6YU66s1hFA0u2JqJMgPzMoAos5Kf1ZTwbRJlkH2jIh0vs1KHrmVjxRHQE1tFtgcbVVmIhqoiVxU5yOrx%25252FSXoV0lF4iW5Hmw6lDY3imZ5NQSnUyYWLt965%25252FS8lBp9ajPUd%25252BELoWw3LCHgCWT1Aex2%25252BTFYNi0vXgcEwkfyyUsg9Q2YqKJCcymEv%25252FLDP6tH%25252BOz02mHU0Xy%25252BmWDOsVWbd0VtiQsTr0JpcbbpfojAScuHTwtSC5BfoxDxIgw%25253D%25253D%2526sign_type%253DRSA2";
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
//    [WToast showWithText:@"暂未开放"];
//    return;
    SettlementZViewController *vc = [[SettlementZViewController alloc]init];
    [self pushView:vc];
}
-(NSString *)objcectToJson:(NSDictionary*)theData isEnd:(BOOL)isend
{
    NSMutableString *jsonStrs=[NSMutableString string];
    [jsonStrs appendString:@"{"];
    
    for(int i=0;i<[theData allKeys].count;i++)
    {
        NSString *key = [theData allKeys][i];
        
        if(i<theData.count-1){
            [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,theData[key]]];
        }else
        {
            [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
        }
    }
    if(isend){
        [jsonStrs appendString:@"}"];
    }else
        [jsonStrs appendString:@"},"];
    return jsonStrs;
    
}
- (IBAction)gobuygoods:(UIButton *)sender {
    GoodListViewController *vc = [[GoodListViewController alloc]init];
    vc.catogryId = @"0";
    [self pushView:vc];
}
@end
