//
//  SocailViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SocailViewController.h"
#import "Socail_IndexCell.h"
#import "Socail_IndexTopCell.h"
#import "SocailDetailViewController.h"
#import "PublishController.h"
#import "LoginViewController.h"
#import "SocailNoImgCell.h"
@interface SocailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *socailData;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSString *cat_id;
@end

@implementation SocailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:NO leftColor:nil title:@"论坛" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.dataSource = [NSMutableArray array];
    self.pageIndex = 1;
    self.cat_id = @"";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadlistData)];
    //RGB(68, 154, 242)
    [self.publish_Btn ButtonWithIconStr:@"\U0000e63b" inIcon:iconfont andSize:CGSizeMake(42, 42) andColor:[UIColor whiteColor] andiconSize:30];
    self.publish_Btn.layer.masksToBounds = 1;
    self.publish_Btn.layer.cornerRadius = 21;
    [self loadData];
    [self loadlistData];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
  [self postWithURLString:@"/Article/home" parameters:nil success:^(id response) {
      NSLog(@"论坛数据===%@",response);
      if(response){
          self.socailData = response[@"result"];
          [self.tableView reloadData];
      }
  } failure:^(NSError *error) {
      
  }];
}
-(void)loadlistData{
    NSDictionary *param = nil;
    if([self.cat_id isEqualToString:@""]){
        param = @{@"p":[NSString stringWithFormat:@"%ld",self.pageIndex]};
    }else{
        param = @{@"p":[NSString stringWithFormat:@"%ld",self.pageIndex],@"cat_id":self.cat_id};
    }
    [self postWithURLString:@"/Article/articleNewsList" parameters:param success:^(id response) {
        NSLog(@"咨询列表数据==%@",response);
        
        [self.tableView.mj_footer endRefreshing];
      //  [WToast showWithText:response[@"msg"]];
        if(response){
            if(self.pageIndex==1){
                [self.dataSource removeAllObjects];
            }
            [self.dataSource addObjectsFromArray:response[@"result"]];
            [self.tableView reloadData];
            self.pageIndex++;
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else{
        return self.dataSource.count;
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10.0f;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak SocailViewController *weakSelf = self;
    if(indexPath.section==0){
   Socail_IndexTopCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"Socail_IndexTopCell" owner:self options:nil]lastObject];
        [cell bindData:self.socailData];
        cell.clickCatogry = ^(NSInteger index){
            NSString *cat_id = [NSString stringWithFormat:@"%@", weakSelf.socailData[@"category"][index][@"cat_id"]];
            weakSelf.cat_id = cat_id;
            self.pageIndex = 1;
            [self loadlistData];
        };
        return cell;
    }else{
        NSDictionary *dic = self.dataSource[indexPath.row];
        if([dic[@"thumb"]isEqualToString:@""]){
            static NSString *cellId = @"cellId";
            SocailNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(!cell){
                cell = [[[NSBundle mainBundle]loadNibNamed:@"SocailNoImgCell" owner:self options:nil]lastObject];
            }
            [cell bindData:self.dataSource[indexPath.row]];
            return cell;
        }

        else{
      static NSString *cellId = @"cell";
        Socail_IndexCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"Socail_IndexCell" owner:self options:nil]lastObject];
        }
        [cell bindData:self.dataSource[indexPath.row]];
        return cell;
    }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 325;
    }else{
        if([self.dataSource[indexPath.row][@"thumb"]isEqualToString:@""]){
            return 90;
        }else
        return 250;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        SocailDetailViewController *vc = [[SocailDetailViewController alloc]init];
        NSDictionary *dic = self.dataSource[indexPath.row];
        vc.article_id = [NSString stringWithFormat:@"%@",dic[@"article_id"]];
        [self pushSecondVC:vc];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//发布论坛文章
- (IBAction)publish_Action:(id)sender {
    if(![XTool GetDefaultInfo:USER_INFO]){
        [WToast showWithText:@"先登录"];
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
    }else{
    PublishController *vc = [[PublishController alloc]init];
    [self pushSecondVC:vc];
    }
}
@end
