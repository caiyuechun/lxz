//
//  MyPublishOldViewController.m
//  乐享租
//
//  Created by caiyc on 18/4/26.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MyPublishOldViewController.h"
#import "oldListCell.h"
#import "DistubeGViewController.h"
#import "DistubeDViewController.h"
#import "DistubeViewController.h"
#import "WriteShipViewController.h"
@interface MyPublishOldViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *popCond_View;
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *cat_Id;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@property(nonatomic,strong)NSMutableArray *cat_Arr;
@property(assign)NSInteger top_Index;

@end

@implementation MyPublishOldViewController
-(void)viewWillAppear:(BOOL)animated{
self.pageIndex = 1;
[self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"我发布的二手" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.down_Lab1 LabelWithIconStr:@"\U0000e6b5" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
      [self.down_Lab2 LabelWithIconStr:@"\U0000e6b5" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    self.popCond_View.hidden =1;
    self.pageIndex = 1;
    self.dataSouce = [NSMutableArray array];
    self.cat_Arr = [NSMutableArray array];
    self.cat_Id = @"";
    self.status = @"";
    self.top_Index = 0;
    


    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"p":[NSString stringWithFormat:@"%ld",self.pageIndex],@"cat_id":self.cat_Id,@"state":self.status};
    [self postWithURLString:@"/goods/myoldlist" parameters:param success:^(id response) {
        if(response){
            if(self.pageIndex==1){
                [self.dataSouce removeAllObjects];
            }
            if(self.cat_Arr.count==0){
            [self.cat_Arr addObjectsFromArray:response[@"result"][@"catelist"]];
            }
            [self.dataSouce addObjectsFromArray:response[@"result"][@"goodslist"]];
            [self.tableView reloadData];
            self.pageIndex++;
        }
    } failure:^(NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"cells";
    oldListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"oldListCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.row]];
    __weak MyPublishOldViewController *weakSelf = self;
    cell.delevier = ^(){
        WriteShipViewController *vc = [[WriteShipViewController alloc]init];
        vc.goodDic = self.dataSouce[indexPath.row];
        [weakSelf pushView:vc];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 255;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DistubeViewController *vc = [[DistubeViewController alloc]init];
   vc.goodDic = self.dataSouce[indexPath.row];
    [self pushView:vc];
}
-(void)initCondView{
    
    for(UIView *view in self.popCond_View.subviews ){
        [view removeFromSuperview];
    }
    
    if(self.top_Index==0){
        self.popCond_View.frame = CGRectMake(0, self.popCond_View.frame.origin.y, screen_width/2, 50*self.cat_Arr.count);
        for(int i =0;i<self.cat_Arr.count;i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 50*i, screen_width/2, 50);
         [   btn setTitle:self.cat_Arr[i][@"name"] forState:UIControlStateNormal];
            [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = i;
            [btn addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.popCond_View addSubview:btn];
            
        }
    }
    else{
        NSArray *arr = @[@"待审核",@"审核通过",@"审核失败"];
        self.popCond_View.frame = CGRectMake(screen_width/2, self.popCond_View.frame.origin.y, screen_width/2, 50*arr.count);
        for(int i =0;i<arr.count;i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 50*i, screen_width/2, 50);
            [   btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = i;
            [btn addTarget:self action:@selector(statusAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.popCond_View addSubview:btn];
            
        }

    }
}
-(void)typeAction:(UIButton *)sender{
    self.popCond_View.hidden = 1;
    self.cat_Id = self.cat_Arr[sender.tag][@"id"];
    self.pageIndex=1;
    [self loadData];
}
-(void)statusAction:(UIButton *)sender{
    self.popCond_View.hidden = 1;
    NSInteger status = sender.tag+1;
    self.status = [NSString stringWithFormat:@"%ld",status];
    self.pageIndex = 1;
    [self loadData];
    
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

- (IBAction)selectCond:(UIButton *)sender {
//    if(sender.tag==0){
//   
//    }
    self.top_Index = sender.tag;
    [self initCondView];
    self.popCond_View.hidden = 0;
}
@end
