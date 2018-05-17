//
//  RefundViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "RefundViewController.h"
#import "OrderCell.h"
@interface RefundViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self initNaviView:nil hasLeft:1 leftColor:nil title:@"退货审核" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *CellId = @"cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil]lastObject];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
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
