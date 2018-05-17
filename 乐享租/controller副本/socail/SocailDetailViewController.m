//
//  SocailDetailViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SocailDetailViewController.h"
#import "Socail_DeHeadCell.h"
#import "Socail_ComentCell.h"
#import "LoginViewController.h"
@interface SocailDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSDictionary *article_Data;
@property(nonatomic,strong)UIWebView *webVIew;
@property (nonatomic,assign) BOOL webIsFinish;
@property (nonatomic,assign) NSInteger webHeight;
@property(nonatomic,strong)NSMutableArray *commentData;//评论数据数组
@end

@implementation SocailDetailViewController
-(void)viewDidDisappear:(BOOL)animated{
    [self.webVIew.scrollView removeObserver:self forKeyPath:@"contentsize"];

}
-(void)dealloc{
    
  //  [self.webVIew.scrollView removeObserver:self forKeyPath:@"contentsize"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"详情" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.webIsFinish = 0;
    self.commentData = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = 0;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.webVIew = [[UIWebView alloc]init];
    self.webVIew.frame = CGRectMake(0, 0, screen_width,10);
    self.webVIew.userInteractionEnabled = 0;
    self.webVIew.delegate = self;
//    [RACObserve(self.contentWebView.scrollView, contentSize) subscribeNext:^(id x) {
//        self.contentWebView.height = self.contentWebView.scrollView.contentSize.height;
//        self.contentScrollView.contentSize = CGSizeMake(screenWidth, self.contentWebView.maxY);
//    }];
//    

    [self.webVIew.scrollView addObserver:self forKeyPath:@"contentsize" options:NSKeyValueObservingOptionNew context:nil];
    
    self.coment_Tf.delegate = self;
    self.coment_Tv.delegate = self;
    self.corver_View.hidden = 1;
    self.coment_View.layer.borderColor = viewcontrollerColor.CGColor;
    self.coment_View.layer.borderWidth = 1;
    self.coment_View.layer.cornerRadius = 5;
    self.corver_View.backgroundColor = RGBA(0, 0, 0, .8);
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCorver)];
    [self.corver_View addGestureRecognizer:taps];

    [self loadData];
    [self loadComment];
    // Do any additional setup after loading the view from its nib.
}
-(void)hideCorver{
    self.corver_View.hidden = 1;
}
-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    if([keyPath isEqualToString:@"contentsize"]){
        CGSize sizes = [self.webVIew sizeThatFits:CGSizeZero];
        NSLog(@"取值网页高度==%f",sizes.width);
        self.webVIew.frame = CGRectMake(0, 0, sizes.width, sizes.height);
        [self.tableView reloadData];
    
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.corver_View.hidden = 0;
    [self.view endEditing:1];
   // [textField resignFirstResponder];
    [self.coment_Tv resignFirstResponder];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"停止编辑");
}
-(void)textViewDidChange:(UITextView *)textView{
//    if(textView.text.length>30){
//        [textView endEditing:1];
////         [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
//        return;
//    }else{
//        self.num_Lab.text = [NSString stringWithFormat:@"%lu/30",(unsigned long)textView.text.length];
//    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(textView.text.length>30){
        [textView endEditing:1];
                [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:@""]];
     //   return NO;
    }else{
        self.num_Lab.text = [NSString stringWithFormat:@"%lu/30",(unsigned long)textView.text.length];
    }

    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self comentAction];
        [self.view endEditing:1];
         self.corver_View.hidden = 1;
        self.coment_Tf.text = @"";
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
-(void)comentAction{
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushView:vc];
    }else{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"content":self.coment_Tv.text,@"article_id":self.article_id};
        [self postWithURLString:@"/Article/article_comment" parameters:param success:^(id response) {
            NSLog(@"评论数据====%@",response);
            [WToast showWithText:response[@"msg"]];
        } failure:^(NSError *error) {
            
        }];
        
        
    }

}
-(void)loadData{
    NSDictionary *param = nil;
    if([XTool GetDefaultInfo:USER_INFO]){
        param = @{@"article_id":self.article_id,@"uid":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    }else{
        param = @{@"article_id":self.article_id};

    }
    [self postWithURLString:@"/Article/articleDetail" parameters:param success:^(id response) {
        if(response){
            self.article_Data = response[@"result"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadComment{

    NSDictionary *param = nil;
    if([XTool GetDefaultInfo:USER_INFO]){
        param = @{@"article_id":self.article_id,@"uid":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    }else{
        param = @{@"article_id":self.article_id};
        
    }
   [self postWithURLString:@"/Article/messagelist" parameters:param success:^(id response) {
       NSLog(@"评论数据==%@",response);
    //   [WToast showWithText:response[@"msg"]];
       if(response){
           [self.commentData  addObjectsFromArray:response[@"result"]];
           [self.tableView reloadData];
       }
   } failure:^(NSError *error) {
       
   }];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    if(self.webVIew.scrollView.contentSize.height==0){
//        self.webVIew.frame = CGRectMake(0, 0, screen_width, self.webVIew.scrollView.contentSize.height);
//[self.tableView reloadData];
//    }
    if(!self.webIsFinish)
    {
        //获取到webview的高度
        CGFloat webViewHeight1 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
        CGFloat webViewHeight2 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        CGFloat webViewHeight3 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
        
        NSLog(@"webViewHeight1 == %f",webViewHeight1);
        NSLog(@"webViewHeight2 == %f",webViewHeight2);
        NSLog(@"webViewHeight3 == %f",webViewHeight3);
        
        if(webViewHeight2!=0)
        {
            self.webIsFinish = 1;
        }
        CGFloat maxheight = MAX(webViewHeight2, webViewHeight1);
        
        self.webVIew.frame = CGRectMake(0, 0, screen_width, maxheight);
        [self.tableView reloadData];
    
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==2){
        return self.commentData.count;
    }else
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        Socail_DeHeadCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"Socail_DeHeadCell" owner:self options:nil]lastObject];
        [cell bindData:self.article_Data];
        return cell;
    }else if (indexPath.section==1){
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"web"];
        [self.webVIew loadHTMLString:self.article_Data[@"content"] baseURL:[NSURL URLWithString:BASE_SERVICE]];
        [cell.contentView addSubview:self.webVIew];

        return cell;
    }
    else{
        Socail_ComentCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"Socail_ComentCell" owner:self options:nil]lastObject];
        [cell bindData:self.commentData[indexPath.row]];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 75;
    }
    else if (indexPath.section==1){
        NSLog(@"网页高度==%f",self.webVIew.frame.size.height);
    return self.webVIew.frame.size.height+10;
    }
    else{
        return 120;
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

@end
