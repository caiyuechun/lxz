//
//  GroupViewController.m
//  SHOP
//
//  Created by caiyc on 16/11/29.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupCell.h"
#import "CollectHeaderView.h"
#import "GroupListCell.h"

#import "LoginViewController.h"


#import "SearchViewController.h"
#import "GoodListViewController.h"
#import "MessageViewController.h"
//#import "GroupGoodsViewController.h"



@interface GroupViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *catogryData;
@property(nonatomic,strong)NSMutableArray *contetnData;
@property(assign)NSInteger selectIdnex;
@property(assign)BOOL isfirstShow;
@end

@implementation GroupViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.isfirstShow = 0;
     self.notifacationNum.hidden = 1;
    [self loadData];
//    NSDictionary *param = @{};
//  
//    if([XTool GetDefaultInfo:USER_INFO]){
//        param = @{@"user_id":[NSString stringWithFormat:@"%@",[XTool GetDefaultInfo:USER_INFO][USER_ID]]};
//
//    
//    [self postWithURLString:@"/index/home" parameters:param success:^(id response) {
//     
//        
//        if(response)
//        {
////            self.dataSource = [NSMutableDictionary dictionary];
////            NSDictionary *dic = response[@"result"];
////            dic = [NSDictionary changeType:dic];
////            self.dataSource =  [[NSMutableDictionary alloc]initWithDictionary:dic]
////            ;
//       //     SLog(@"返回数据：%@",self.dataSource);
//            //   return ;
//            NSString *nums = [NSString stringWithFormat:@"%@", [response objectForKey:@"result"][@"count"]];
//            NSDictionary *numDic = @{@"messNum":nums};
//            [[NSNotificationCenter defaultCenter ]postNotificationName:@"messNumAdd" object:nil userInfo:numDic];
//            if([nums isEqualToString:@"0"])
//            {
//                self.notifacationNum.backgroundColor = [UIColor clearColor];
//                self.notifacationNum.textColor = [UIColor clearColor];
//            }else
//            {
//                self.notifacationNum.backgroundColor = [UIColor orangeColor];
//                self.notifacationNum.text = nums;
//                self.notifacationNum.textColor = [UIColor whiteColor];
//                
//                
//            }
//          //  [self.tableView reloadData];
//            
//            
//            
//        }
//        
//    } failure:^(NSError *error) {
//        NSLog(@"请求出错==%@",error);
//        //    [self.tableView.mj_header endRefreshing];
//    }];
//    }


}
////扫码
//- (IBAction)DoScan:(UIButton *)sender {
//    
//    
//    SJViewController *viewController = [[SJViewController alloc] init];
//    /** successString 扫描成功返回来的数据 */
//    viewController.successBlock = ^(NSString *successString) {
//        NSLog(@"%@",successString);
//        [self dismissViewControllerAnimated:YES completion:nil];
//        if([self isNumText:successString])
//        {
//            if([XTool GetDefaultInfo:USER_INFO])
//            {
//                [WToast showWithText:@"您已经是注册用户"];
//            }else{
//                NSDictionary *userInfo = @{@"code":successString};
//                
//                LoginViewController *vc = [[LoginViewController alloc]init];
//                [self pushSecondVC:vc];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"SCANCODE" object:nil userInfo:userInfo];
//            }
//        }
//        if([self isUrl:successString])
//        {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:successString]];
//        }
//        
//    };
//    [self presentViewController:viewController animated:YES completion:nil];
//    
//    
//    
//    
//}
- (IBAction)CheckMessage:(UIButton *)sender {
    if(![XTool GetDefaultInfo:USER_INFO])
    {
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
        [WToast showWithText:@"请登录"];
        return;
    }
    self.hidesBottomBarWhenPushed = 1;
    
   MessageViewController *vc = [[MessageViewController alloc]init];
    [self pushSecondVC:vc];
//    [self.navigationController pushViewController:vc animated:NO];
//    self.hidesBottomBarWhenPushed = 0;
}
- (BOOL)isNumText:(NSString *)str{
    NSString * regex        = @"[0-9]*";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isUrl:(NSString *)url
{
    NSString *      regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:url];
}
-(void)reloadNoti:(NSNotification *)user{
    NSLog(@"...接到的通知详细==%@",user);
    NSDictionary *dic = user.object;
    if([dic[@"count"]integerValue]>0){
        self.notifacationNum.hidden = 0;
        self.notifacationNum.text = [NSString stringWithFormat:@"%@",dic[@"count"]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadNoti:) name:@"reloadNum" object:nil];;
//      [self initNaviView:nil hasLeft:NO leftColor:nil title:@"分类" titleColor:nil right:@"" rightColor:nil rightAction:nil];
     [self.search_Lab LabelWithIconStr:@"\U0000e634" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor grayColor] andiconSize:20];
    [self.scanBtn ButtonWithIconStr:@"\U0000e798" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor whiteColor] andiconSize:PAPULARFONTSIZE+5];
    [self.view bringSubviewToFront:self.scanBtn];
    [self.self.messageBtn ButtonWithIconStr:@"\U0000e609" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    [self.view bringSubviewToFront:self.messageBtn];
    self.notifacationNum.layer.cornerRadius = 6;
    self.notifacationNum.layer.masksToBounds = 1;
    [self.view bringSubviewToFront:self.notifacationNum];

    
    self.selectIdnex = 0;
    self.view.backgroundColor = viewcontrollerColor;
    self.catogryData = [NSMutableArray array];
    self.contetnData = [NSMutableArray array];
    
    self.seachView.backgroundColor = [UIColor whiteColor];
    self.search_Tf.delegate = self;

    
    
    self.search_View.layer.cornerRadius = 20;
    self.search_View.layer.masksToBounds = YES;
    
    
    
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(self.CollectView.frame.size.width/3-10, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(self.CollectView.frame.size.width, 40);
    [self.CollectView setCollectionViewLayout:flowLayout];
    self.CollectView.delegate = self;
    self.CollectView.dataSource = self;
    
    UINib *cellNib = [UINib nibWithNibName:@"GroupCell" bundle:nil];
    UINib *headNib = [UINib nibWithNibName:@"CollectHeaderView" bundle:nil];
    
    [self.CollectView registerNib:cellNib forCellWithReuseIdentifier:@"simpleCell"];
    [self.CollectView registerNib:headNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.CollectView.showsVerticalScrollIndicator = 0;
    
    self.GroupList.delegate = self;
    self.GroupList.dataSource = self;
    self.GroupList.showsVerticalScrollIndicator = 0;
    self.GroupList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  //  [self loadData];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField endEditing:1];
   
    self.hidesBottomBarWhenPushed = 1;
    SearchViewController *vc = [[SearchViewController alloc]init];

    [self pushSecondVC:vc];

  //  self.hidesBottomBarWhenPushed = 0;
    
}


-(void)loadData
{
    NSDictionary *parameter = @{@"parent_id":@"0"};

    [self postWithURLString:@"/Goods/goodsCategoryList" parameters:parameter success:^(id response) {
        if(response)
        {
 
                    //                    分类列表
                    [self.catogryData removeAllObjects];
                    [self.catogryData addObjectsFromArray:response[@"result"]];
                    [self oncerequest];
                    [self.GroupList reloadData];

            
            SLog(@"分类信息：%@",response);
        }
    } failure:^(NSError *error) {
        SLog(@"错误：%@",error);
        
        
    }];
}
-(void)oncerequest{
    NSString *data = [self.catogryData objectAtIndex:self.selectIdnex][@"id"];
    NSDictionary *parameter = @{@"parent_id":data};

    [self postWithURLString:@"/Goods/goodsCategoryList" parameters:parameter success:^(id response) {
        if(response)
        {
            if ([[response objectForKey:@"status"]intValue]==1) {
                    [self.contetnData removeAllObjects];
            
                    [self.contetnData addObjectsFromArray:response[@"result"]];
                    NSLog(@"------------断点------------%@",self.contetnData);
                    [self.CollectView reloadData];
                
            }
            
            SLog(@"分类信息：%@",response);
        }
    } failure:^(NSError *error) {
        SLog(@"错误：%@",error);
        
        
    }];
}


#pragma mark tableView delelgate
//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    if(self.isfirstShow==0){
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
        
//        CATransform3D transform = CATransform3DIdentity;
//        transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
//        transform = CATransform3DTranslate(transform, -200, 0, 0);//左边水平移动
//        transform = CATransform3DScale(transform, 0, 0, 0);//由小变大
//        
//        cell.layer.transform = transform;
//        cell.layer.opacity = 0.0;
//        
//        [UIView animateWithDuration:0.6 animations:^{
//            cell.layer.transform = CATransform3DIdentity;
//            cell.layer.opacity = 1;
//        }];
        
//        CATransform3D  transform;
//        transform.m34 = 1.0/-800;
//        //定义 Cell的初始化状态
//        cell.layer.transform = transform;
//        //定义Cell 最终状态 并且提交动画
//        [UIView beginAnimations:@"transform" context:NULL];
//        [UIView setAnimationDuration:1];
//        cell.layer.transform = CATransform3DIdentity;
//        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//        [UIView commitAnimations];
        
        
        CATransform3D  transform;
        transform = CATransform3DMakeRotation((CGFloat)((90.0 * M_PI) / 180.0), 0.0, 0.7, 0.4);
        transform.m34 = 1.0/-600;
        cell.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = transform;
        cell.layer.anchorPoint = CGPointMake(0, 0.5);//锚点
        if(cell.layer.position.x != 0){
            cell.layer.position = CGPointMake(0, cell.layer.position.y);
        }
        [UIView beginAnimations:@"transform" context:NULL];
        [UIView setAnimationDuration:0.8];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
        

        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.catogryData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    GroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GroupListCell" owner:self options:nil]lastObject];
    }
    if(self.catogryData.count>0){
    NSDictionary *diction = self.catogryData[indexPath.row];
    cell.titleLb.text = diction[@"name"];
    if(self.selectIdnex==indexPath.row)
    {
        cell.selectview.hidden = 0;
        cell.titleLb.textColor = BASE_COLOR;
    }else
    {
        cell.selectview.hidden = 1;
        cell.titleLb.textColor = [UIColor blackColor];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.isfirstShow = 1;
    if(self.selectIdnex==indexPath.row)return;
    self.selectIdnex = indexPath.row;
    [self oncerequest];
    [self.GroupList reloadData];
    
    
}
//#pragma mark collectView delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contetnData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simpleCell";
    GroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.contetnData.count>0) {
        [cell bindData:self.contetnData[indexPath.row]];
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.CollectView.frame.size.width/3-10, 100);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    if(self.catogryData.count>0){
     //   [header bindData:[self.catogryData objectAtIndex:self.selectIdnex]];
        
    if(indexPath.section!=0)
    {
   //   [header.flashImage sd_setImageWithURL:[NSURL URLWithString:self.catogryData[self.selectIdnex][@"bigimage"]]];
        header.flashImage.frame = CGRectMake(0, 0, self.CollectView.frame.size.width/3-10, 0);
        header.titleLb.frame = CGRectMake(0, 0, header.titleLb.frame.size.width, 35);
    }
    else
    {
        [header.flashImage sd_setImageWithURL:[NSURL URLWithString:self.catogryData[self.selectIdnex][@"bigimage"]]];
        NSLog(@".....分类图片地址====%@",self.catogryData[self.selectIdnex][@"bigimage"]);
        header.flashImage.frame = CGRectMake(0, 0, self.CollectView.frame.size.width, 120);
      //  header.titleLb.frame = CGRectMake(0, 147, header.titleLb.frame.size.width, 41);
    }
    }
    return header;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if(section==0)
    {
        return CGSizeMake(self.CollectView.frame.size.width/3-10, 140);
    }
    else
        return CGSizeMake(self.CollectView.frame.size.width/3-10, 34);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"selectIndex:row:%ld--section:%ld",(long)indexPath.row,(long)indexPath.section);
    NSDictionary *diction = self.contetnData[indexPath.row];
    GoodListViewController *vc = [[GoodListViewController alloc]init];
    vc.catogryId = [NSString stringWithFormat:@"%@", diction[@"id"]];
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

@end
