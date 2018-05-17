//
//  SocailCatogyViewController.m
//  乐享租
//
//  Created by caiyc on 18/4/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SocailCatogyViewController.h"

@interface SocailCatogyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSouce;

@end

@implementation SocailCatogyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self initNaviView:nil hasLeft:1 leftColor:nil title:@"选择分类" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.dataSouce = [NSMutableArray array];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
 [self postWithURLString:@"/Article/articlecategory" parameters:nil success:^(id response) {
     NSLog(@"分类信息==%@",response);
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
    static NSString *CellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    cell.textLabel.text = self.dataSouce[indexPath.row][@"cat_name"];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ids = [NSString stringWithFormat:@"%@", self.dataSouce[indexPath.row][@"cat_id"]];
    NSString *name = self.dataSouce[indexPath.row][@"cat_name"];
    
    self.selectCat(ids,name);
    [self.navigationController popViewControllerAnimated:0];
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
