//
//  SysNoticeViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//  系统消息

#import "SysNoticeViewController.h"
#import "SysNotiCell.h"
@interface SysNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation SysNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"系统消息" titleColor:nil right:@"" rightColor:nil rightAction:nil];

    
    self.pageIndex = 1;
    self.dataSouce = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadlistData)];
    [self loadlistData];

    // Do any additional setup after loading the view from its nib.
}
-(void)loadlistData{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"p":[NSString stringWithFormat:@"%ld",self.pageIndex]};
    [self postWithURLString:@"/user/mymessage" parameters:param success:^(id response) {
        [self.tableView.mj_footer endRefreshing];
        if(response){
            
            [self.dataSouce addObjectsFromArray:response[@"result"]];
            [self.tableView reloadData];
            self.pageIndex++;
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellId = @"cells";
    SysNotiCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SysNotiCell" owner:self options:nil]lastObject];
    }
//    [cell bindData:self.dataSouce[indexPath.row]];
//    MySocailDisCell *weakCell = cell;
//    cell.check=^(){
//        weakCell.check_Lab.textColor = BUTTON_COLOR;
//        
//    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
