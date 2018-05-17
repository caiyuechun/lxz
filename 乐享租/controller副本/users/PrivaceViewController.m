//
//  PrivaceViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "PrivaceViewController.h"
#import "Index_RecomdCell.h"
#import "PGoodDetailViewController.h"
@interface PrivaceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *dataSouce;

@end

@implementation PrivaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSouce = [NSMutableArray array];
      [self initNaviView:nil hasLeft:1 leftColor:nil title:@"特权商城" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    [self.questiion_Lab LabelWithIconStr:@"\U0000e78f" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
    self.cover_View.hidden = 1;
    self.cover_View.backgroundColor = RGBA(0, 0, 0, .5);
    self.alert_View.layer.masksToBounds = 1;
    self.alert_View.layer.cornerRadius = 5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCover)];
    [self.cover_View addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)refresh{
    self.pageIndex=1;
    [self loadData];
}
-(void)loadData{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"p":[NSString stringWithFormat:@"%ld",self.pageIndex]};
    [self postWithURLString:@"/goods/privilegelist" parameters:param success:^(id response) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if(response){
            NSDictionary *user_Data = response[@"result"][@"user_data"];
            self.goumai_Count.text = [NSString stringWithFormat:@"购买%@次",user_Data[@"buy_num"]];
            self.yigou_Count.text = [NSString stringWithFormat:@"已购%@次",user_Data[@"buy_sure"]];
            self.kegou_Count.text = [NSString stringWithFormat:@"可购%@次",user_Data[@"total"]];
            
            if(self.pageIndex==1){
                [self.dataSouce removeAllObjects];
            }
            [ self.dataSouce addObjectsFromArray:response[@"result"][@"goods_list"]];
            [self.tableView reloadData];
            self.pageIndex++;
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    }];
}
-(void)hideCover{
    self.cover_View.hidden = 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellID = @"cell";
    Index_RecomdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Index_RecomdCell" owner:self options:nil]lastObject];
    }
   // NSDictionary *dic = self.dataSouce[indexPath.row];
    [cell bindData:self.dataSouce[indexPath.row]];
//    [cell.img sd_setImageWithURL:[NSURL URLWithString:dic[@"original_img"]] placeholderImage:nil];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PGoodDetailViewController *vc = [[PGoodDetailViewController alloc]init];
    NSDictionary *dic = self.dataSouce[indexPath.row];
    vc.goodsID = [NSString stringWithFormat:@"%@",dic[@"goods_id"]];
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

- (IBAction)chechQuestion:(UIButton *)sender {
    self.cover_View.hidden = 0;
}
@end
