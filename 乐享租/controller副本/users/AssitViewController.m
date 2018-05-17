//
//  AssitViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/22.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "AssitViewController.h"
#import "AssitCell.h"
#import "AssitDetailViewController.h"
@interface AssitViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation AssitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"帮助" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self .dataSouce = [NSMutableArray array];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
[self postWithURLString:@"/Article/helpList" parameters:nil success:^(id response) {
    if(response){
        [self.dataSouce addObjectsFromArray:response[@"result"]];
        [self.tableView reloadData];
    }
} failure:^(NSError *error) {
    
}];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *CellId = @"cells";
    AssitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AssitCell" owner:self options:nil]lastObject];
    }
    cell.title_Lab.text = [NSString stringWithFormat:@"Q%ld：%@",(long)indexPath.row+1,self.dataSouce[indexPath.row][@"title"]];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AssitDetailViewController *vc = [[AssitDetailViewController alloc]init];
    vc.ids =[NSString stringWithFormat:@"%@",self.dataSouce[indexPath.row][@"article_id"]];
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
