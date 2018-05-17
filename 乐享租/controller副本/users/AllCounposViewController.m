//
//  AllCounposViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "AllCounposViewController.h"
#import "ConpoussCell.h"
@interface AllCounposViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation AllCounposViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"优惠券" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.dataSouce = [NSMutableArray array];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadConpous];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadConpous{
    [self postWithURLString:@"/index/getcouplisst" parameters:nil success:^(id response) {
        //NSLog(@"优惠券数据=%@",response);
        if([response[@"status"]integerValue]==1){
            self.dataSouce = response[@"result"];
           // [self coupons];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellId = @"cells";
    ConpoussCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"ConpoussCell" owner:self options:nil]lastObject];
    }
    [cell bindData:nil];
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
