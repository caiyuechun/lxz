//
//  ShipTrackViewController.m
//  SHOP
//
//  Created by caiyc on 17/3/28.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "ShipTrackViewController.h"
#import "ShipTrakCell.h"
@interface ShipTrackViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *datasouce;
@end

@implementation ShipTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasouce = [NSMutableArray array];
    self.view.backgroundColor = viewcontrollerColor;
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:[UIColor blackColor] title:@"物流跟踪" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    
//    UIWebView *webView = [[UIWebView alloc]init];
//    webView.frame = CGRectMake(0, naviHei, screen_width, screen_height-naviHei);
//    [self.view addSubview:webView];
    self.address.text = self.addressStr;
    self.orderNum.text = self.orderNums;
    
    self.ShipList.delegate = self;
    self.ShipList.dataSource = self;
    self.ShipList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.ShipList.showsVerticalScrollIndicator = 0;
    NSDictionary *paramter = @{@"type":self.shipCode,@"postid":self.invoice_no};
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSString *urlString =@"http://www.kuaidi100.com/query";
    NSLog(@"urlstr ===%@",urlString);
    [manager GET:urlString parameters:paramter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"请求返回%@",responseObject);
        if([responseObject[@"data"]count]>0)
        {
            for(NSDictionary *dic in responseObject[@"data"])
            {
                [self.datasouce addObject:dic];
            }
            [self.ShipList reloadData];
        }else
        {
            [WToast showWithText:@"暂无物流信息"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

//    NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
//    NSDictionary *paramter = @{@"user_id":userDic[USER_ID],@"order_id":self.order_id};
//    [self getWithURLString:@"/user/express" parameters:paramter success:^(id response) {
//        NSLog(@"物流信息%@",response);
//        if(response)
//        {
//            for(NSDictionary *dic in response[@"result"][@"express"][@"data"])
//            {
//                [self.datasouce addObject:dic];
//            }
//            [self.ShipList reloadData];
////            NSURL *url = [NSURL URLWithString:response[@"result"][@"express"]];
////            [webView loadRequest:[NSURLRequest requestWithURL:url]];
//        }
//        if([response[@"result"][@"express"][@"data"]count]==0)
//        {
//            [WToast showWithText:@"您的订单已导入，商家正通知快递公司取件"];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasouce.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cells";
    ShipTrakCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShipTrakCell" owner:self options:nil]lastObject];
    }
    NSDictionary *dic  = self.datasouce[indexPath.row];
    cell.addressLable.text = dic[@"context"];
    cell.timeLb.text = dic[@"ftime"];
    if(indexPath.row==0)
    {
        cell.cicleLb.backgroundColor = BASE_COLOR;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
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
