//
//  MyDistubeViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/22.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MyDistubeViewController.h"
#import "MyPublishOldViewController.h"
#import "DistubeDViewController.h"
#import "MySocailDisViewController.h"
@interface MyDistubeViewController ()

@end

@implementation MyDistubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"发布中心" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    [self createView];
    // Do any additional setup after loading the view from its nib.
}
-(void)createView{
    [self.down_Lab LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    [self.right_Lab LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    NSArray *img_Array = @[@"\U0000e623",@"\U0000e696",@"\U0000e694",@"\U0000e693"];
    NSArray *color_Array = @[RGB(243, 35, 255),RGB(95, 222, 254),RGB(72, 237, 140),RGB(72, 237, 140)];
    NSArray *title_Array = @[@"出租",@"二手",@"退货",@"待出租"];
    CGFloat widths = screen_width/4;
    for(int i =0;i<2;i++){
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(widths*i, 0, widths, 80)];
        
        UILabel *img_Lab = [[UILabel alloc]initWithFrame:CGRectMake((widths-50)/2, 0, 50, 50)];
        
        [img_Lab LabelWithIconStr:img_Array[i] inIcon:iconfont andSize:CGSizeMake(50, 50) andColor:color_Array[i] andiconSize:30];
        img_Lab.textAlignment = NSTextAlignmentCenter;
        UILabel *title_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, widths, 30)];
        title_Lab.font = [UIFont systemFontOfSize:15];
        title_Lab.textAlignment = NSTextAlignmentCenter;
        title_Lab.text = title_Array[i];
        [item addSubview:img_Lab];
        [item addSubview:title_Lab];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, widths, 100);
        button.tag = i;
        [button addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:button];
        
        [self.order_View addSubview:item];
    }

}
-(void)orderAction:(UIButton *)sender{
    if(sender.tag==1){
        MyPublishOldViewController *vc = [[MyPublishOldViewController alloc]init];
        [self pushView:vc];
    }else if (sender.tag==0){
        DistubeDViewController *vc = [[DistubeDViewController alloc]init];
        vc.sattus = @"";
        [self pushView:vc];
    }
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

- (IBAction)checkMyScoail:(UIButton *)sender {
    MySocailDisViewController *vc = [[MySocailDisViewController alloc]init];
    [self pushView:vc];
}
@end
