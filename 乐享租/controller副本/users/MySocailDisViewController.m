//
//  MySocailDisViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//  我发布的帖子

#import "MySocailDisViewController.h"
#import "MySocailDisCell.h"
#import "SocailDetailViewController.h"
@interface MySocailDisViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation MySocailDisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"我的帖子" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(screen_width-leftSpece-btnSize+10,(naviHei-btnSize)/2+18 , 25, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"cardele"] forState:UIControlStateNormal];
    //[rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
     [self.naviView addSubview:rightBtn];
    
    UIButton *rightBtns = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtns setFrame:CGRectMake(screen_width-leftSpece-btnSize-50+10,(naviHei-btnSize)/2+10 , 35, btnSize)];
    [rightBtns setTitle:@"全选" forState:UIControlStateNormal];
    rightBtns.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtns setTitleColor:BUTTON_COLOR forState:UIControlStateNormal];
    [rightBtns addTarget:self action:@selector(allselect) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:rightBtns];

    self.pageIndex = 1;
    self.dataSouce = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadlistData)];
    [self loadlistData];

    // Do any additional setup after loading the view from its nib.
}
#pragma mark 删除
-(void)delete{
    NSMutableString *ids = [NSMutableString string];
    for(NSDictionary *dic in self.dataSouce){
        if([dic[@"isselect"]isEqualToString:@"1"]){
            [ ids appendString:[NSString stringWithFormat:@"%@",dic[@"article_id"]]];
            [ids appendString:@","];
        }
    
    }
    if(ids.length==0){
        [WToast showWithText:@"请选择文章"];
        return;
    }
    NSString *newStr = [ids substringWithRange:NSMakeRange(0, ids.length-1)];
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"ids":newStr};
    [self postWithURLString:@"/article/delarticle" parameters:param success:^(id response) {
        if(response){
           
            self.pageIndex = 1;
            [self.dataSouce removeAllObjects];
            [self loadlistData];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 全选
-(void)allselect{
    for(int i =0;i<self.dataSouce.count;i++){
        NSMutableDictionary *dic = self.dataSouce[i];
        [dic setObject:@"1" forKey:@"isselect"];
        [self.dataSouce replaceObjectAtIndex:i withObject:dic];
//        if([dic[@"isselect"]isEqualToString:@"1"]){
//            [ ids appendString:[NSString stringWithFormat:@"%@",dic[@"article_id"]]];
//            [ids appendString:@","];
//        }
        
    }
    [self.tableView reloadData];

}
-(void)loadlistData{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"page":[NSString stringWithFormat:@"%ld",self.pageIndex]};
    [self postWithURLString:@"/Article/mypublist" parameters:param success:^(id response) {
        [self.tableView.mj_footer endRefreshing];
        if(response){
            NSMutableArray *arr = response[@"result"];
            for(int i =0;i<arr.count;i++){
                NSMutableDictionary *dic = arr[i];
                [dic setObject:@"0" forKey:@"isselect"];
                [arr replaceObjectAtIndex:i withObject:dic];
            }
            [self.dataSouce addObjectsFromArray:arr];
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
    MySocailDisCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MySocailDisCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.row]];
    MySocailDisCell *weakCell = cell;
    cell.check=^(){
        
        NSMutableDictionary *dic = self.dataSouce[indexPath.row];
        NSString *str = dic[@"isselect"];
        if([str isEqualToString:@"0"]){
        [dic setObject:@"1" forKey:@"isselect"];
            weakCell.check_Lab.textColor = BUTTON_COLOR;
        }else{
         [dic setObject:@"0" forKey:@"isselect"];
            weakCell.check_Lab.textColor = BASE_GRAY_COLOR;
        }
        [self.dataSouce replaceObjectAtIndex:indexPath.row withObject:dic];
        
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SocailDetailViewController *vc = [[SocailDetailViewController alloc]init];
    vc.article_id = [NSString stringWithFormat:@"%@",self.dataSouce[indexPath.row][@"article_id"]];
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
