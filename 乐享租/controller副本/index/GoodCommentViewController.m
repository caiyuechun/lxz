//
//  GoodCommentViewController.m
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "GoodCommentViewController.h"
#import "envalteCell.h"
@interface GoodCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(assign)NSInteger pageindex;
@property(nonatomic,strong)NSMutableArray *comentArr;
@property(nonatomic,strong)envalteCell *envateCell;
@property(nonatomic,strong)UIScrollView *imageScro;

@end

@implementation GoodCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageindex= 1;
    self.comentArr = [NSMutableArray array];
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:@"商品评论" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.view.backgroundColor = viewcontrollerColor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadData)];
    //评论图片查看滚动图片视图
    self.imageScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.imageScro.hidden = 1;
    [self.view addSubview:self.imageScro];
    self.imageScro.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missImgScro)];
    [self.imageScro addGestureRecognizer:tap];
    //self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self LoadData];
   // [self setupRefresh];
    // Do any additional setup after loading the view from its nib.
}
-(void)missImgScro
{
    self.imageScro.hidden = 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.comentArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    self.envateCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!self.envateCell)
    {
        self.envateCell = [[[NSBundle mainBundle]loadNibNamed:@"envalteCell" owner:self options:nil]lastObject];
}
    [self.envateCell bindData:self.comentArr[indexPath.row]];
    __weak GoodCommentViewController *weakSelf = self;
    self.envateCell.checkImage=^(UIButton *sender)
    {
        weakSelf.imageScro.hidden = 0;
        for(UIView *view in [weakSelf.imageScro subviews])
        {
            [view removeFromSuperview];
        }
        [weakSelf.imageScro setContentSize:CGSizeMake(screen_width*[weakSelf.comentArr[indexPath.row][@"img"]count], screen_height)];
        for(int i =0;i<[weakSelf.comentArr[indexPath.row][@"img"]count];i++)
        {
            UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width*i, 0, screen_width, screen_height)];
            images.contentMode = UIViewContentModeScaleAspectFit;
            NSString *urlStr = [NSString stringWithFormat:@"%@",weakSelf.comentArr[indexPath.row][@"img"][i]];
            [images sd_setImageWithURL:[NSURL URLWithString:urlStr]];
            [weakSelf.imageScro addSubview:images];
        }
        
        
        //         NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_SERVICE,weakSelf.commentArr[indexPath.row][@"img"][sender.tag]];
        //            [weakSelf.cheImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        //            weakSelf.CheckImgaeView.hidden = 0;
    };

  //  [self.envateCell bindData:self.comentArr[indexPath.row] andIndex:indexPath.row andCount:self.comentArr.count];
    return self.envateCell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.comentArr[indexPath.row][@"cellh"]floatValue];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    return self.envateCell.imgScroView.frame.size.height+self.envateCell.imgScroView.frame.origin.y+10;


}
-(void)setupRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex = 1;
        [self LoadData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self LoadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(CGSize)sizeWithString:(NSString *)string font:(CGFloat)font maxWidth:(CGFloat)maxWidth

{
    
    NSDictionary *attributesDict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    CGRect subviewRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDict context:nil];
    
    return subviewRect.size;
    
}
-(void)LoadData
{
    NSDictionary *param = @{@"goods_id":self.goodId,@"p":[NSString stringWithFormat:@"%ld",(long)self.pageindex]};
    [self postWithURLString:@"/goods/getGoodsComment" parameters:param success:^(id response) {
        if([response[@"status"]integerValue]==1){
            self.pageindex++;
        }
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"商品评论数据%@",response);
        if(self.pageindex==1)
        {
            [self.comentArr removeAllObjects];
        }
        for(int i =0;i<[response[@"result"]count];i++)
        {
            NSMutableDictionary *dic = response[@"result"][i];
//            CGFloat conetHei = 0.0;
//            if([dic[@"img"]count]==0)
//            {
//                conetHei = [self sizeWithString:dic[@"content"] font:15 maxWidth:screen_width-20].height+61;
//            }else
//            {
//                 conetHei = [self sizeWithString:dic[@"content"] font:15 maxWidth:screen_width-20].height+61+125;
//            }
//            [dic setObject:[NSString stringWithFormat:@"%f",conetHei] forKey:@"cellh"];
            [self.comentArr addObject:dic];
        }
        
       
        NSLog(@"数据源%@",self.comentArr);
        [self.tableView reloadData];
        
       //  [self endRefresh];
     //   [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationTop];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];

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
