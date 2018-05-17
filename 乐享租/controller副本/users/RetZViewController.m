//
//  RetZViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/8.
//  Copyright © 2018年 changce. All rights reserved.
//  退货列表

#import "RetZViewController.h"
#import "RetOrderCells.h"
@interface RetZViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation RetZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"退还记录" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.dataSouce = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self loadData];

    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/user/return_product_list" parameters:param success:^(id response) {
        SLog(@"订单数据%@",response);
        if(response)
        {
            
            self.dataSouce = response[@"result"];
            if(self.dataSouce.count==0)
            {
                [WToast showWithText:@"暂无数据"];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //   return 5;
    return self.dataSouce.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellId = @"Cells";
    RetOrderCells *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RetOrderCells" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.section]];
    return cell;
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
