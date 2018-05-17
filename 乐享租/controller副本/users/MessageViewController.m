//
//  MessageViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTopCell.h"
#import "MessCommentCell.h"
#import "ActiveNotiViewController.h"
#import "SysNoticeViewController.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *notiDic;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self initNaviView:nil hasLeft:1 leftColor:nil title:@"消息" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
[self postWithURLString:@"/user/mynews" parameters:param success:^(id response) {
    if(response){
        self.notiDic = response[@"result"];
        [self.tableView reloadData];
    }
} failure:^(NSError *error) {
    
}];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 2;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 70;
    }else{
        return 110;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
    
        if(indexPath.row==1){
            ActiveNotiViewController *vc = [[ActiveNotiViewController alloc]init];
            [self pushView:vc];
        }else{
            SysNoticeViewController *vc = [[SysNoticeViewController alloc]init];
            [self pushView:vc];
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        MessageTopCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageTopCell" owner:self options:nil]lastObject];
        [cell bindDatas:indexPath.row];
        if(indexPath.row==0){
            cell.decrition_Lab.text = [self.notiDic[@"system"]isEqualToString:@""]?@"暂无消息":self.notiDic[@"system"];
        }else{
            cell.decrition_Lab.text = [self.notiDic[@"active"] isEqualToString:@""]?@"暂无消息":self.notiDic[@"active"];
        }
        return cell;
    }else{
        
       static NSString *cellId = @"cell";
        MessCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MessCommentCell" owner:self options:nil]lastObject];
        }
        return cell;
    }
    
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
