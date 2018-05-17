//
//  SecTimeViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/9.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SecTimeViewController.h"
#import "SecTimeListCell.h"
#import "GoodDetailViewController.h"
@interface SecTimeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(assign)NSInteger pageIndex;
@property (weak, nonatomic) IBOutlet UICollectionView *CollectView;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@end

@implementation SecTimeViewController
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"stoptimes" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    self.pageIndex = 1;
    self.dataSouce  =[NSMutableArray array];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"限时抢租" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    self.pageIndex = 1;
    self.dataSouce = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(self.CollectView.frame.size.width/2-3, 255)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout.headerReferenceSize = CGSizeMake(self.CollectView.frame.size.width, 40);
    [self.CollectView setCollectionViewLayout:flowLayout];
    self.CollectView.delegate = self;
    self.CollectView.dataSource = self;
    
    UINib *cellNib = [UINib nibWithNibName:@"SecTimeListCell" bundle:nil];
    [self.CollectView registerNib:cellNib forCellWithReuseIdentifier:@"simpleCell"];
    
    self.CollectView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
  //
    //[self loadData];

    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    NSDictionary *param = @{@"p":[NSString stringWithFormat:@"%ld",self.pageIndex]};
    [self postWithURLString:@"/changce/flashgoods" parameters:param success:^(id response) {
        [self.CollectView.mj_footer endRefreshing];
        if(response){
            [self.dataSouce addObjectsFromArray:response[@"result"]];
            [self.CollectView reloadData];
            self.pageIndex++;
        }
    } failure:^(NSError *error) {
        [self.CollectView.mj_footer endRefreshing];
    }];
}
//#pragma mark collectView delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simpleCell";
    SecTimeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.dataSouce.count>0) {
        [cell bindData:self.dataSouce[indexPath.row]];
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.CollectView.frame.size.width/2-5, 255);
}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    CollectHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
//    if(self.catogryData.count>0){
//        //   [header bindData:[self.catogryData objectAtIndex:self.selectIdnex]];
//        
//        if(indexPath.section!=0)
//        {
//            //   [header.flashImage sd_setImageWithURL:[NSURL URLWithString:self.catogryData[self.selectIdnex][@"bigimage"]]];
//            header.flashImage.frame = CGRectMake(0, 0, self.CollectView.frame.size.width/3-10, 0);
//            header.titleLb.frame = CGRectMake(0, 0, header.titleLb.frame.size.width, 35);
//        }
//        else
//        {
//            [header.flashImage sd_setImageWithURL:[NSURL URLWithString:self.catogryData[self.selectIdnex][@"bigimage"]]];
//            NSLog(@".....分类图片地址====%@",self.catogryData[self.selectIdnex][@"bigimage"]);
//            header.flashImage.frame = CGRectMake(0, 0, self.CollectView.frame.size.width, 120);
//            //  header.titleLb.frame = CGRectMake(0, 147, header.titleLb.frame.size.width, 41);
//        }
//    }
//    return header;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    if(section==0)
//    {
//        return CGSizeMake(self.CollectView.frame.size.width/3-10, 140);
//    }
//    else
//        return CGSizeMake(self.CollectView.frame.size.width/3-10, 34);
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"selectIndex:row:%ld--section:%ld",(long)indexPath.row,(long)indexPath.section);
   NSDictionary *diction = self.dataSouce[indexPath.row];
    GoodDetailViewController *vc = [[GoodDetailViewController alloc]init];
    vc.goodsID = [NSString stringWithFormat:@"%@",diction[@"goods_id"]];
    [self pushView:vc];
//    GoodListViewController *vc = [[GoodListViewController alloc]init];
//    vc.catogryId = [NSString stringWithFormat:@"%@", diction[@"id"]];
//    [self pushSecondVC:vc];
    
    
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
