//
//  GoodListViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "GoodListViewController.h"
#import "Index_RecomdCell.h"
#import "RandomCell.h"
#import "GoodDetailViewController.h"
@interface GoodListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(assign)BOOL blockstyle;//方块样式
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(assign)NSInteger pageIndex;
@property(nonatomic,strong)NSString *sort;//筛选条件
@property(nonatomic,strong)NSString *orderdesc;//排序
@property(assign)BOOL Saleasc;
@property(assign)BOOL priceasc;
@property(assign)BOOL zongheasc;
@property(nonatomic,strong)NSMutableArray *filterArr;
@property(nonatomic,strong)NSString *fifterString;
@property(nonatomic,strong)NSMutableArray *filrTitleArr;
@property(nonatomic,strong)NSMutableArray *specArr;
@property(nonatomic,strong)NSString *specId;
@property(nonatomic,strong)NSMutableDictionary *specDic;
@property(nonatomic,strong)UISearchBar *searchBar;
//@property(nonatomic,strong)NSString *keyWords;
@end

@implementation GoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"产品列表" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(screen_width-leftSpece-btnSize,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
    [rightBtn ButtonWithIconStr:@"\U0000e631" inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor blackColor] andiconSize:PAPULARFONTSIZE];
    
    [rightBtn addTarget:self action:@selector(changeStyle) forControlEvents:UIControlEventTouchUpInside];
    
 //   [self.naviView addSubview:rightBtn];

    self.view.backgroundColor = viewcontrollerColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.recomend_Lab LabelWithIconStr:@"\U0000e6b5" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
     [self.sales_Lab LabelWithIconStr:@"\U0000e6b5" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    self.blockstyle = 1;
    
    
    self.pageIndex = 1;
    self.dataSource = [NSMutableArray array];
    self.filterArr = [NSMutableArray array];
    self.filrTitleArr = [NSMutableArray array];
    self.specArr = [NSMutableArray array];
    self.specDic =[NSMutableDictionary dictionary];
     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fiflterData)];
    
    self.sort = @"";
    self.orderdesc = @"";
    if(self.keyWords){}
    else
   self.keyWords = @"";
    
    self.fifterString =@"/Goods/goodsList";

    
    [self fiflterData];
    // Do any additional setup after loading the view from its nib.
}
//获取筛选数据
-(void)fiflterData
{
    
    NSDictionary *dic;
    NSLog(@"筛选的id:%@",self.specId);
    NSLog(@"筛选的id字典%@",self.specId);
    NSLog(@"专题id======%@",self.projectId);
    if([self.sort isEqualToString:@""])
    {
        if(self.catogryId){
            dic = @{@"p":[NSString stringWithFormat:@"%ld",(long)self.pageIndex],@"pagesize":@"10",@"id":self.catogryId,@"keyword":self.keyWords,@"user_id":[XTool GetDefaultInfo:USER_INFO]?[XTool GetDefaultInfo:USER_INFO][USER_ID]:@"",@"brand_id":self.brand_id?self.brand_id:@""};
        }else
        {
            dic = @{@"p":[NSString stringWithFormat:@"%ld",(long)self.pageIndex],@"pagesize":@"10",@"keyword":self.keyWords,@"specid":self.projectId,@"user_id":[XTool GetDefaultInfo:USER_INFO]?[XTool GetDefaultInfo:USER_INFO][USER_ID]:@"",@"brand_id":self.brand_id?self.brand_id:@""};
            
        }
        
        
        
    }else
    {
        if(self.catogryId){
            dic = @{@"p":[NSString stringWithFormat:@"%ld",(long)self.pageIndex],@"pagesize":@"10",@"id":self.catogryId,
                    @"sort_asc":self.orderdesc,@"sort":self.sort,@"keyword":self.keyWords,@"user_id":[XTool GetDefaultInfo:USER_INFO]?[XTool GetDefaultInfo:USER_INFO][USER_ID]:@"",@"brand_id":self.brand_id?self.brand_id:@""};
        }else
        {
            dic = @{@"p":[NSString stringWithFormat:@"%ld",(long)self.pageIndex],@"pagesize":@"10",
                    @"sort_asc":self.orderdesc,@"sort":self.sort,@"keyword":self.keyWords,@"specid":self.projectId,@"user_id":[XTool GetDefaultInfo:USER_INFO]?[XTool GetDefaultInfo:USER_INFO][USER_ID]:@"",@"brand_id":self.brand_id?self.brand_id:@""};
            
        }
    }
    
    NSLog(@"参数：%@",dic);
    [self getWithURLString:self.fifterString parameters:dic success:^(id response) {
        SLog(@"数据;%@",response);
        [self.tableView.mj_footer endRefreshing];
        if(response)
        {
            if( ! [[[response objectForKey:@"result"]objectForKey:@"goods_list"]isEqual:[NSNull null]])
            {
                if([[[response objectForKey:@"result"]objectForKey:@"goods_list"]count]==0)[WToast showWithText:@"暂无数据"];
                if(self.pageIndex ==1)[self.dataSource removeAllObjects];
                for(NSDictionary *dic in [[response objectForKey:@"result"]objectForKey:@"goods_list"])
                {
                    [self.dataSource addObject:dic];
                }
                
                NSLog(@"筛选数组长度:%lu",(unsigned long)[self.filterArr count]);
                [self.tableView reloadData];
                //  [self.ProductList reloadData];
                
                //    [self.selectList reloadData];
                self.pageIndex++;
            }else
            {
                [WToast showWithText:@"无相关数据"];
            }
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"请求出错的信息%@",error);
    }];
}
-(void)changeStyle{
//    self.blockstyle = !self.blockstyle;
//    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.blockstyle){
        NSArray *data =self.dataSource;
        NSInteger RowNum = data.count%2==0?data.count/2:data.count/2+1;
        return RowNum;

    }else
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.blockstyle){
        static NSString *cellID = @"random";
        RandomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RandomCell" owner:self options:nil]lastObject];
            // return cell;
        }
        __weak GoodListViewController *weakSelf = self;
        NSMutableArray *arr =[NSMutableArray array];
        NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row*2];
        [arr addObject:dic];
        if([self.dataSource count]>indexPath.row*2+1)
        {
            NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row*2+1];
            [arr addObject:dic];
        }
        [cell bindData:arr andIndex:indexPath.row];

        cell.clickItemBlock=^(UIButton *sender){
            GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
            [weakSelf pushSecondVC:vc];
            
        };
        return cell;

    }else{
 static NSString *CellId = @"Cell";
    Index_RecomdCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Index_RecomdCell" owner:self options:nil]lastObject];
    }
        [ cell bindData:self.dataSource[indexPath.row]];
    return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.blockstyle){
        return 275;
    }
    else
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
    vc.goodsID = self.dataSource[indexPath.row][@"goods_id"];
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
