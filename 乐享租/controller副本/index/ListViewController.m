//
//  ListViewController.m
//  chuangyi
//
//  Created by yncc on 17/8/14.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "ListViewController.h"
//#import "GoodListTableViewCell.h"
#import "GoodDetailViewController.h"
#import "RandomCell.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *goodlistArray;
@property (nonatomic,assign) NSInteger pageindex;
//{
//    NSMutableArray *datas;
//}

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewcontrollerColor;
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:self.title titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodListTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodListTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 275;
    
    [self setupRefresh];
   
}
//-(void)viewWillAppear:(BOOL)animated{
// [self.navigationController setNavigationBarHidden:NO];
//}
//-(void)viewDidDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:YES];
//
//}
-(void)setupRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex = 1;
         [self LoadData];
          }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self LoadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(NSMutableArray *)goodlistArray{
    if (!_goodlistArray) {
        _goodlistArray = [NSMutableArray array];
    }
    return _goodlistArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *data =self.goodlistArray;
    NSInteger RowNum = data.count%2==0?data.count/2:data.count/2+1;
    return RowNum;

    //return self.goodlistArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"random";
    RandomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RandomCell" owner:self options:nil]lastObject];
    }
    NSMutableArray *arr =[NSMutableArray array];
    NSDictionary *dic = [self.goodlistArray objectAtIndex:indexPath.row*2];
    [arr addObject:dic];
    if([self.goodlistArray count]>indexPath.row*2+1)
    {
        NSDictionary *dic = [self.goodlistArray objectAtIndex:indexPath.row*2+1];
        [arr addObject:dic];
    }
    [cell bindData:arr andIndex:indexPath.row];
    cell.clickItemBlock = ^(UIButton *sender){
        
        GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
        vc.goodsID =self.goodlistArray[sender.tag][@"goods_id"];
        [self pushView:vc];
        
    };

//    GoodListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodListTableViewCell" forIndexPath:indexPath];
//    [cell bindData:[self.goodlistArray objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

        GoodDetailViewController *vc = [GoodDetailViewController new];
        vc.goodsID = [[self.goodlistArray objectAtIndex:indexPath.row] objectForKey:@"goods_id"];
        [self pushView:vc];
    
}
-(void)LoadData{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:[NSString stringWithFormat:@"%lu",_pageindex] forKey:@"p"];
    [parameter setValue:_typeStr forKey:@"type"];
    if([XTool GetDefaultInfo:USER_INFO]){
       [ parameter setValue:[XTool GetDefaultInfo:USER_INFO][USER_ID] forKey:@"user_id"];
    }
   // [parameter setValue:@"10" forKey:@"pagesize"];
    
    [self getWithURLString:@"/goods/homelist" parameters:parameter success:^(id response) {
        [self endRefresh];
        NSLog(@"%@",response);
        if (_pageindex == 1) {
            [self.goodlistArray removeAllObjects];
        }
        _pageindex++;
    
     //  self.goodlistArray = [response objectForKey:@"result"];
       // NSLog(@"内存地址2：%x",&&self.goodlistArray);
        [self.goodlistArray addObjectsFromArray:[response objectForKey:@"result"]];
     //   NSLog(@"内存地址2：%x",self.goodlistArray);
        if ([[response objectForKey:@"result"] count] < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self endRefresh];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
