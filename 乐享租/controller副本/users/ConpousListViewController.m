//
//  ConpousListViewController.m
//  chuangyi
//
//  Created by caiyc on 17/9/9.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "ConpousListViewController.h"
#import "conponsCell.h"
#import "LoginViewController.h"
#import "AllCounposViewController.h"
#import "ConpoussCell.h"
//#import "SearchResultViewController.h"
@interface ConpousListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSouce;
@property(nonatomic,strong)UILabel *movieLb;
@property(nonatomic,strong)NSString *types;
@end

@implementation ConpousListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.types = @"0";
    self.view.backgroundColor = viewcontrollerColor;
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:@"优惠券" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.dataSouce = [NSMutableArray array];
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setFrame:CGRectMake(screen_width-leftSpece-btnSize-30,(naviHei-btnSize)/2+10 , btnSize+30, btnSize)];
//    [rightBtn  setTitle:@"去领取" forState:UIControlStateNormal];
//    [rightBtn setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    
//    [rightBtn addTarget:self action:@selector(getAll) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.naviView addSubview:rightBtn];

    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(self.dataArr)
    {
        self.dataSouce = [NSMutableArray arrayWithArray:self.dataArr];
        NSLog(@"传递的优惠券数据=%@",self.dataSouce);
        self.topView.hidden = 1;
        self.tableView.frame = CGRectMake(0, 65, self.tableView.frame.size.width, screen_height-65);
        [self.tableView reloadData];
    }else
    {
        [self topViews];
        [self loadData];
            }
    // Do any additional setup after loading the view from its nib.
}
-(void)getAll{
    AllCounposViewController *vc = [[AllCounposViewController alloc]init];
    [self pushView:vc];
}
-(void)loadData{
    NSDictionary *user_info = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *param = @{@"user_id":user_info[@"user_id"],@"type":self.types};
    [self getWithURLString:@"/user/getCouponList" parameters:param success:^(id response) {
        NSLog(@"优惠券数据=%@",response);
        [WToast showWithText:response[@"msg"]];
        self.dataSouce = response[@"result"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
-(void)topViews{
    self.topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.topView];
    NSArray *titleArr = @[@"未使用",@"已使用",@"已过期"];
    CGFloat wid = screen_width/titleArr.count;
    for(int i =0;i<titleArr.count;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(wid*i, 0, wid, 50);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.topView addSubview:btn];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if(i==0)
        {
            btn.selected = 1;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
    }
    self.movieLb = [[UILabel alloc]init];
    self.movieLb.frame = CGRectMake((wid-100)/2, 49+naviHei+2, 100, 1);
    self.movieLb.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.movieLb];


}
-(void)clickItem:(UIButton *)btn{
    for(UIButton *btns in [self.topView subviews])
    {
        if(btns.tag!=btn.tag)
        {
            btns.selected = 0;
        }
        else
        {
            if(btn.selected)
            {
                btns.selected = 1;
            }
            else
            {
                btns.selected = !btns.selected;
            }
        }
        
    }

    self.types = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    [self loadData];
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.movieLb.frame = CGRectMake((screen_width/3-100)/2+btn.tag*(screen_width/3), 49+naviHei+2, 100, 1);
       // self.botomScro.contentOffset = CGPointMake(btn.tag*screen_width, 0);
        //self.movieLb.center = CGPointMake(btn.center.x, 39);
    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"conponsCell";
    ConpoussCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ConpoussCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.row]];
//    if(self.dataArr)
//    {
//      //  [cell bindData:self.dataSouce[indexPath.row] AndType:self.types];
//     //   [cell bindData:self.dataSouce[indexPath.row] andType:@"1"];
//    }else
//    {
//   // [cell bindData:self.dataSouce[indexPath.row] AndType:self.types];
//    }
    cell.use = ^(){
    if(![XTool GetDefaultInfo:USER_INFO])
    {
        [WToast showWithText:@"请登录"];
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushView:vc];
    }
        else
        {
            if(self.needback)
            {
                self.conpous(self.dataSouce[indexPath.row]);
                [self.navigationController popViewControllerAnimated:YES];

            }else
            {
//            NSString *counpId = [NSString stringWithFormat:@"%@",self.dataSouce[indexPath.row][@"id"]];
//            NSDictionary *param = @{@"user_id":[NSString stringWithFormat:@"%@",[XTool GetDefaultInfo:USER_INFO][USER_ID]],@"coupid":counpId};
//            
//            [self postWithURLString:@"/user/gaincoupon" parameters:param success:^(id response)
//             {
//                 if(response)
//                 {
//                    // [WToast showWithText:@"领取成功"];
//                    // self.conpousView.hidden= 1;
//                 }
//             } failure:^(NSError *error) {
//                 
//             }];
        }
        }

     
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(self.needback==1){
//        SearchResultViewController *vc = [[SearchResultViewController alloc]init];
//        [self pushSecondVC:vc];
//    }else{
//    self.conpous(self.dataSouce[indexPath.row]);
//    [self.navigationController popViewControllerAnimated:YES];
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
