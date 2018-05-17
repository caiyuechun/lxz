//
//  SearchViewController.m
//  乐享租
//
//  Created by caiyc on 18/4/18.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SearchViewController.h"
#import "TagView.h"
#import "GoodListViewController.h"
@interface SearchViewController ()<TagViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)TagView *HistagView;
@property(nonatomic,strong)TagView *RecmodtagView;
@end

@implementation SearchViewController
-(TagView*)HistagView{
    if (!_HistagView) {
        _HistagView = [[TagView alloc]initWithFrame:CGRectMake(0, 30, screen_width, 0)];
        _HistagView.delegate = self;
        
    }
    return _HistagView;
}
-(TagView*)RecmodtagView{
    if (!_RecmodtagView) {
        _RecmodtagView = [[TagView alloc]initWithFrame:CGRectMake(0, 30, screen_width, 0)];
        _RecmodtagView.delegate = self;
    }
    return _RecmodtagView;
}
-(void)handleSelectTag:(NSString *)keyWord{
    self.search_Tf.text = keyWord;
//    NSMutableArray *arr = [NSMutableArray array];
//    if(![XTool GetDefaultInfo:@"searchKey"])
//    {
//      [arr addObject:keyWord];
//    }else{
//        arr = [XTool GetDefaultInfo:@"searchKey"];
//        for(NSString *str in arr){
//            if(![str isEqualToString:keyWord]){
//                [arr addObject:keyWord];
//            }
//        }
//   
//    }
//    [XTool SaveDefaultInfo:arr Key:@"searchKey"];
    GoodListViewController *vc = [[GoodListViewController alloc]init];
    vc.keyWords = keyWord;
    [self pushView:vc];
    //[self pushSecondVC:vc];
    NSLog(@"%@",keyWord);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    [self.search_Lab LabelWithIconStr:@"\U0000e634" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    
    [self.view bringSubviewToFront:self.search_View];
    
    [self.view bringSubviewToFront:self.cancel_Btn];
    
    self.corver_View.backgroundColor = viewcontrollerColor;
    
    [self.histiory_View addSubview:self.HistagView];
    
    [self reloadViews];
    
    [self loadData];
    self.search_Tf.delegate = self;
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    [self postWithURLString:@"/index/recomend_keyword" parameters:nil success:^(id response) {
        if(response){
            NSArray *arr1 =response[@"result"];
            
            [self.recomend_View addSubview:self.RecmodtagView];
            
            self.RecmodtagView.arr = arr1;
            
            self.recomend_View.frame = CGRectMake(0, self.HistagView.frame.size.height+30+10, screen_width, self.RecmodtagView.frame.size.height+30);

        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)reloadViews{
    for(UIView *vi in [self.HistagView subviews]){
        [vi removeFromSuperview];
    }
    
    NSMutableArray *arr = [XTool GetDefaultInfo:@"searchKey"];
    self.HistagView.arr = arr;
    self.histiory_View.frame = CGRectMake(0, self.histiory_View.frame.origin.y, screen_width, self.HistagView.frame.size.height+30);
  
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    self.corver_View.hidden = 1;
    return 1;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSMutableArray *key =[NSMutableArray array];
    if(![XTool GetDefaultInfo:@"searchKey"]){}
    else key = [XTool GetDefaultInfo:@"searchKey"];
    
    [key addObject:textField.text];
    [XTool SaveDefaultInfo:key Key:@"searchKey"];
    
    GoodListViewController *vc = [[GoodListViewController alloc]init];
    vc.keyWords = textField.text;
    [self pushSecondVC:vc];

    return 1;
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

- (IBAction)cancelAction:(id)sender {
    self.corver_View.hidden = 0;
}
- (IBAction)delete:(UIButton *)sender {
    [XTool SaveDefaultInfo:nil Key:@"searchKey"];
    [self reloadViews];
}
@end
