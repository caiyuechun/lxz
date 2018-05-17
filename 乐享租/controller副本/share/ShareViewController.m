//
//  ShareViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareIndexCell.h"
#import "DistubeViewController.h"
#import "DistubeGViewController.h"
#import "RentProcessViewController.h"
#import "ShareDetailViewController.h"
#import "LoginViewController.h"
@interface ShareViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSString *keyword;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
    self.tableVIew.showsVerticalScrollIndicator = 0;
    
     self.pageIndex = 1;
    self.dataSouce = [NSMutableArray array];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCover)];
    self.tableVIew.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableVIew.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableVIew.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableVIew.mj_header beginRefreshing];
   
    self.keyword = @"";
    [self.cover_View addGestureRecognizer:tap];
    self.cover_View.hidden = 1;
    self.cover_View.backgroundColor = RGBA(255, 255, 255, .8);
    [self.search_Lab LabelWithIconStr:@"\U0000e634" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    [self.distube_Lab LabelWithIconStr:@"\U0000e6a4" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
    [self.clise_Lab LabelWithIconStr:@"\U0000e6cd" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_GRAY_COLOR andiconSize:35];
    self.search_Tf.delegate = self;
    [self.search_Tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
  //  [self loadData];
//     UITapGestureRecognizer *tap_ViewGs = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKb)];
//    [self.view addGestureRecognizer:tap_ViewGs];
    // Do any additional setup after loading the view from its nib.
}
-(void)textFieldDidChange:(UITextField *)textField{
   // [self.view endEditing:1];
    if(textField.text.length==0){
        [self.view endEditing:1];
        self.pageIndex = 1;
        self.keyword = @"";
        [self.dataSouce removeAllObjects];
        [self loadData];

    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
   // self .pageIndex = 1;
    [self.view endEditing:1];
    self.pageIndex = 1;
    self.keyword = textField.text;
    [self.dataSouce removeAllObjects];
    [self loadData];

    return 1;
}
-(void)refresh{
    self.pageIndex = 1;
    [self.dataSouce removeAllObjects];
   [self loadData];
}
-(void)loadData{
    NSDictionary *param = @{@"keyword":self.keyword,@"p":[NSString stringWithFormat:@"%ld",(long)self.pageIndex]};
    [self postWithURLString:@"/goods/oldgoodslist" parameters:param success:^(id response) {
        [self.tableVIew.mj_header endRefreshing];
        [self.tableVIew.mj_footer endRefreshing];
        NSLog(@"二手产品数据==%@",response);
        if(response){
            [self.dataSouce addObjectsFromArray:response[@"result"]];
            [self.tableVIew reloadData];
            self.pageIndex++;
        }
    } failure:^(NSError *error) {
        [self.tableVIew.mj_header endRefreshing];
        [self.tableVIew.mj_footer endRefreshing];

    }];
}
-(void)hideKb{
    [self.view endEditing:1];
}
-(void)hideCover{
    self.cover_View.hidden = 1;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:1];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSouce.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *CellId = @"cell";
    ShareIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShareIndexCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.section]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:1];
    ShareDetailViewController *vc = [[ShareDetailViewController alloc]init];
    vc.ids = [NSString stringWithFormat:@"%@",self.dataSouce[indexPath.section][@"goods_id"]];
    [self pushSecondVC:vc];
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

- (IBAction)distubeAction:(id)sender {
    if(![XTool GetDefaultInfo:USER_INFO]){
        [WToast showWithText:@"先登录"];
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
    }else
    self.cover_View.hidden = 0;
}
- (IBAction)rentAction:(UIButton *)sender {
    if(sender.tag==0){
        //出租
        RentProcessViewController *vc = [[RentProcessViewController alloc]init];
        [self pushSecondVC:vc];

//        DistubeGViewController *vc = [[DistubeGViewController alloc]init];
//        [self pushSecondVC:vc];
    }else{
        //出售
            DistubeViewController *vc = [[DistubeViewController alloc]init];
    [self pushSecondVC:vc];
}
}
@end
