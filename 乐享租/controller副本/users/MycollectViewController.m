//
//  MycollectViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MycollectViewController.h"
#import "Index_RecomdCell.h"
#import "GoodDetailViewController.h"
@interface MycollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation MycollectViewController
-(void)viewWillAppear:(BOOL)animated{
    [self refresh];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"我的收藏" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self .pageIndex = 1;
    self.dataSouce = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //[self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view from its nib.
}
-(void)refresh{
    self.pageIndex= 1;
    [self loadData];
}
-(void)loadData{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"p":[NSString stringWithFormat:@"%ld",(long)self.pageIndex]};
    [self postWithURLString:@"/user/getGoodsCollect" parameters:param success:^(id response) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if(response){
            if(self.pageIndex ==1){
                [self.dataSouce removeAllObjects];
            }
            [self.dataSouce addObjectsFromArray:response[@"result"]];
            self.pageIndex++;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellId =@"cell";
    Index_RecomdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Index_RecomdCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.row]];
    cell.percent.hidden = 1;
    cell.botm_Img.hidden = 1;
  //  cell.price_Lab.text =
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
    vc.goodsID = [NSString stringWithFormat:@"%@",self.dataSouce[indexPath.row][@"goods_id"]];
    [self pushSecondVC:vc];

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
