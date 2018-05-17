//
//  ActiveNotiViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ActiveNotiViewController.h"
#import "ActiveNotiCell.h"
#import "SocailDetailViewController.h"
@interface ActiveNotiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation ActiveNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self initNaviView:nil hasLeft:1 leftColor:nil title:@"活动通知" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.dataSouce = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
[self postWithURLString:@"/Article/systemList" parameters:nil success:^(id response) {
    if(response){
        [self.dataSouce addObjectsFromArray:response[@"result"]];
        [self.tableView reloadData];
    }
} failure:^(NSError *error) {
    
}];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    ActiveNotiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ActiveNotiCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 245;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ids = [NSString stringWithFormat:@"%@",self.dataSouce[indexPath.row][@"article_id"]];
    SocailDetailViewController *vc = [[SocailDetailViewController alloc]init];
    vc.article_id = ids;
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
