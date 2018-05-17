//
//  SelectCatViewController.m
//  乐享租
//
//  Created by caiyc on 18/4/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SelectCatViewController.h"

@interface SelectCatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *leftData;
@property(nonatomic,strong)NSMutableArray *rightData;
@property(assign)NSInteger selectIdnex;
@end

@implementation SelectCatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"选择分类" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    self.leftData = [NSMutableArray array];
    self.rightData = [NSMutableArray array];
    
    self.left_Tableview.delegate = self;
    self.left_Tableview.dataSource = self;
    self.left_Tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.right_TableView.delegate = self;
    self.right_TableView.dataSource = self;
     self.right_TableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData
{
    NSDictionary *parameter = @{@"parent_id":@"0"};
    
    [self postWithURLString:@"/Goods/goodsCategoryList" parameters:parameter success:^(id response) {
        if(response)
        {
            
            //                    分类列表
            [self.leftData removeAllObjects];
            [self.leftData addObjectsFromArray:response[@"result"]];
            [self oncerequest];
            [self.left_Tableview reloadData];
            
            
            SLog(@"分类信息：%@",response);
        }
    } failure:^(NSError *error) {
        SLog(@"错误：%@",error);
        
        
    }];
}
-(void)oncerequest{
    NSString *data = [self.leftData objectAtIndex:self.selectIdnex][@"id"];
    NSDictionary *parameter = @{@"parent_id":data};
    
    [self postWithURLString:@"/Goods/goodsCategoryList" parameters:parameter success:^(id response) {
        if(response)
        {
            if ([[response objectForKey:@"status"]intValue]==1) {
                [self.rightData removeAllObjects];
                
                [self.rightData addObjectsFromArray:response[@"result"]];
             //   NSLog(@"------------断点------------%@",self.contetnData);
                [self.left_Tableview reloadData];
                
            }
            
            SLog(@"分类信息：%@",response);
        }
    } failure:^(NSError *error) {
        SLog(@"错误：%@",error);
        
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.leftData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 50)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 0, screen_width, 50);
    [btn setTitle:self.leftData[section][@"name"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.tag = section;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
  //  btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headView addSubview:btn];
    return headView;
}
-(void)click:(UIButton *)sender{
    self.selectIdnex =sender.tag;
    [self oncerequest];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==self.selectIdnex){
        return self.rightData.count;
    }else
    return 0;
//    if(tableView==self.left_Tableview){
//        return self.leftData.count;
//    }else return self.rightData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 static NSString *CellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
   // [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//    if(tableView==self.left_Tableview){
//        cell.textLabel.text = self.leftData[indexPath.row][@"name"];
//    }else{
    cell.textLabel.text = self.rightData[indexPath.row][@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = RGB(120, 120, 120);
//    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectCat(self.rightData[indexPath.row]);
    [self.navigationController popViewControllerAnimated:0];
//    if(tableView==self.left_Tableview){
//        self.selectIdnex = indexPath.row;
//        [self oncerequest];
//    }else{
////        NSString *cat_id = [NSString stringWithFormat:@"%@", self.rightData[indexPath.row][@"id"]];
//        self.selectCat(self.rightData[indexPath.row]);
//        [self.navigationController popViewControllerAnimated:0];
//    }
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
