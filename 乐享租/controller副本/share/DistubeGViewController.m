//
//  DistubeViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//  发布(编辑)出租

#import "DistubeGViewController.h"
#import "SJPhotoPicker.h"
#import "SJPhotoPickerNavController.h"
#import "SelectCatViewController.h"
@interface DistubeGViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePicke;
@property(nonatomic,strong)NSMutableArray *image_Array;
@property(nonatomic,strong)NSMutableArray *imageDataSource;
@property(assign)BOOL is_New;//是否全新
@property(nonatomic,strong)NSString *cat_Id;
@property(nonatomic,strong)NSString *rent_Date;//租期参数
@property(nonatomic,strong)NSMutableArray *date_Arr;//租期数组
@property(nonatomic,strong)NSMutableArray *date_biaoji;
@property(nonatomic,strong)NSMutableArray *date_LabArr;//标签数组
@property(assign)BOOL ischeck;//需要检测
@end

@implementation DistubeGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"产品信息填写" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    self.submit_Btn.layer.cornerRadius  = 25;
    self.submit_Btn.layer.masksToBounds = 1;
    self.bottom_ScroView.backgroundColor = [UIColor whiteColor];
    self.bottom_ScroView.contentSize = CGSizeMake(0, screen_height*1.2);
    self.bottom_ScroView.showsVerticalScrollIndicator = 0;
    self.bottom_ScroView.delegate = self;
    self.content_Tv.delegate = self;
    
    [self.addImg_Btn ButtonWithIconStr:@"\U0000e60a" inIcon:iconfont andSize:CGSizeMake(60, 60) andColor:BASE_GRAY_COLOR andiconSize:50];
    [self.right_Lab LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    [self.cheek_Lab LabelWithIconStr:@"\U0000e78f" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor redColor] andiconSize:20];
    [self.check_Btn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_GRAY_COLOR andiconSize:20];

    

    self.image_Array = [NSMutableArray array];
    self.imageDataSource = [NSMutableArray array];
    self.date_Arr = [NSMutableArray array];
    self.date_biaoji = [NSMutableArray array];
    self.date_LabArr = [NSMutableArray array];
    if(self.goodId){
        NSDictionary *param = @{@"id":self.goodId,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
        [self postWithURLString:@"/goods/goodsInfo_edit" parameters:param success:^(id response) {
            if(response){
                self.goodDic = response[@"result"];
                [self initsubviews];
                [self initRentView];
            }
        } failure:^(NSError *error) {
            
        }];
      
    
    }
    [self loadRentDate];
    // Do any additional setup after loading the view from its nib.
}
-(void)initsubviews{
    self.title_Tf.text = self.goodDic[@"goods"][@"goods_name"];
    self.content_Tv.text = self.goodDic[@"goods"][@"goods_remark"];
    self.cat_Id = [NSString stringWithFormat:@"%@",self.goodDic[@"goods"][@"cat_id"]];
    self.ischeck = 1;
     [self.check_Btn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:self.ischeck?BUTTON_COLOR:BASE_GRAY_COLOR andiconSize:20];
    for(int i=0;i<[self.goodDic[@"gallery"]count];i++){
        //异步下载图片
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        NSString *urls =self.goodDic[@"gallery"][i][@"image_url"];
        
        [downloader downloadImageWithURL:[NSURL URLWithString:urls]
                                 options:0
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    // progression tracking code
                                }
                               completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                   if (image && finished) {
                                       [self.image_Array addObject:image];
                                       [self performSelectorOnMainThread:@selector(initImageScroView) withObject:nil waitUntilDone:YES];
                                       //    [self initImageScroView];
                                       // do something with image
                                   }
                               }];
        
    }

};
-(void)loadRentDate{
    [self postWithURLString:@"/index/monlist" parameters:nil success:^(id response) {
        if(response){
            [self.date_Arr addObjectsFromArray:response[@"result"]];
            [self initRentView];
//            if(self.goodId){}
//            else
//            [self initRentView];
        }
    } failure:^(NSError *error) {
        
    }];
 //   NSDictionary *param = @{@""};
}
-(void)initRentView{
    for(UIView *ve in self.date_View.subviews ){
        [ve removeFromSuperview];
    }
    CGFloat widthss = self.date_View.frame.size.width/2;
    CGFloat spacewid = 10;
    for(int i =0;i<self.date_Arr.count;i++){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(widthss*(i/2), 27*(i%2), widthss, 27)];
        UILabel *icon_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 21, 21)];
        [icon_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:i==0?BUTTON_COLOR: BASE_GRAY_COLOR andiconSize:20];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, widthss-30, 27)];
        name.text = self.date_Arr[i][@"name"];
        name.font = [UIFont systemFontOfSize:14];
        name.textColor = RGB(100, 100, 100);
        [view addSubview:icon_Lab];
        [view addSubview:name];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, widthss, 27);
        btn.tag = i;
        [btn addTarget:self action:@selector(selctDate:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
               if(i==0){
         [self.date_biaoji addObject:[NSString stringWithFormat:@"%@",self.date_Arr[i][@"id"]]];
        }else{
        [self.date_biaoji addObject:@"0"];
        }
        if(self.goodDic){
            NSString *str =self.goodDic[@"goods"][@"month"];
            NSArray *temp_Arr = [str componentsSeparatedByString:@","];
            NSString *ids = [NSString stringWithFormat:@"%@", self.date_Arr[i][@"id"]];
            for(int k =0;k<temp_Arr.count;k++){
                if([ids isEqualToString:temp_Arr[k]]){
                    [self.date_biaoji replaceObjectAtIndex:i withObject:ids];
                    [icon_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
                }
            }
        }

        
        [self.date_LabArr addObject:icon_Lab];
        [self.date_View addSubview:view];
        
        
    }
    
}
-(void)selctDate:(UIButton *)sender{
    NSInteger index = sender.tag;
    NSString *strings = self.date_biaoji[index];
    UILabel *icon_Lab  = self.date_LabArr[index];
    NSDictionary *dic = self.date_Arr[index];
    if([strings isEqualToString:@"0"]){
        [self.date_biaoji replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%@",dic[@"id"]]];
         [icon_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
    }else{
        [self.date_biaoji replaceObjectAtIndex:index withObject:@"0"];
        [icon_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];

    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:1];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if(textView.text.length>50){
        [textView endEditing:1];
        [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:@""]];
        //   return NO;
    }else{
        self.num_Lab.text = [NSString stringWithFormat:@"%lu/50",(unsigned long)textView.text.length];
    }
    
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        [self comentAction];
//        [self.view endEditing:1];
//        self.corver_View.hidden = 1;
//        self.coment_Tf.text = @"";
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
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
//提交
- (IBAction)submitAction:(UIButton *)sender {
    if(self.goodDic){
        NSString *month =[  self.date_biaoji componentsJoinedByString:@","];
        NSString *urlStr = [NSString stringWithFormat:@"%@/goods/uploadimage",BASE_URL];
        //        self postWithURLString:<#(NSString *)#> parameters:<#(id)#> success:<#^(id response)success#> failure:<#^(NSError *error)failure#>
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
        //         NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"goods_name":self.title_Tf.text,@"content":self.content_Tv.text,@"shop_price":self.price_Tf.text,@"newold":[NSString stringWithFormat:@"%d",self.is_New],@"cityname":@"昆明",@"goods_id":self.goodDic[@"goods_id"]};
        NSDictionary *paramss = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
      
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
//        NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"goods_name":self.title_Tf.text,@"check":@"1",@"goods_id":[NSString stringWithFormat:@"%@",self.goodDic[@"goods_id"]],@"month":month};
        [manager POST:urlStr parameters:paramss constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for(NSInteger i = 0; i <self.image_Array.count; i++) {
                NSData * imageData = UIImageJPEGRepresentation([self.image_Array objectAtIndex: i], 0.5);
                // 上传的参数名
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                [formData appendPartWithFileData:imageData name:@"imgs[]" fileName:fileName mimeType:@"image/jpeg"];
            }
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSLog(@"上传回调===%@",responseObject);
            
            if([[responseObject objectForKey:@"status"]integerValue]==1)
            {
                
                NSArray *imagesArr = responseObject[@"result"];
                NSMutableString *images_Str = [NSMutableString string];
                for(int i =0;i<imagesArr.count;i++){
                    [images_Str appendString:imagesArr[i][@"urlpath"]];
                    if(i==imagesArr.count-1){}
                    else
                        [images_Str appendString:@","];
                }
              NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"goods_name":self.title_Tf.text,@"check":@"1",@"goods_id":[NSString stringWithFormat:@"%@",self.goodDic[@"goods_id"]],@"month":month,@"imgs":images_Str};
                [self postWithURLString:@"/goods/edit_publishlease" parameters:paramter success:^(id response) {
                    if(response){
                        [WToast showWithText:@"编辑成功"];
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                } failure:^(NSError *error) {
                    
                }];

              //  [self.navigationController popViewControllerAnimated:0];
                
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [WToast showWithText:@"上传失败请重试"];
            NSLog(@"上传失败原因===%@",error);
        }];
    
    
    }
    else{
    if([self.title_Tf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写商品名称"];
        return;
    }
    if(!self.cat_Id){
        [WToast showWithText:@"请选择商品分类"];
        return;
    }
    if(self.image_Array.count==0){
        [WToast showWithText:@"请选择至少一张照片上传"];
        return;
    }

    for(int i =0;i<self.date_biaoji.count;i++){
        if([self.date_biaoji[i] isEqualToString:@"0"]){
            [self.date_biaoji removeObjectAtIndex:i];
        }
    }
    
    if(self.date_biaoji.count==0){
        [WToast showWithText:@"请选择租期"];
        return;
    }
    if(self.ischeck==0){
        [WToast showWithText:@"请勾选官方检测"];
        return;
    }
       NSString *month =[  self.date_biaoji componentsJoinedByString:@","];
    NSString *urlStr = [NSString stringWithFormat:@"%@/goods/publishlease",BASE_URL];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"goods_name":self.title_Tf.text,@"check":@"1",@"month":month};
    [manager POST:urlStr parameters:paramter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(NSInteger i = 0; i <self.image_Array.count; i++) {
            NSData * imageData = UIImageJPEGRepresentation([self.image_Array objectAtIndex: i], 0.5);
            // 上传的参数名
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData name:@"img_file[]" fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"上传回调===%@",responseObject);
        
        if([[responseObject objectForKey:@"status"]integerValue]==1)
        {
            
            [WToast showWithText:@"发布成功"];
            [self.navigationController popViewControllerAnimated:0];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [WToast showWithText:@"上传失败请重试"];
        NSLog(@"上传失败原因===%@",error);
    }];
    }
    
    
    
}
//添加图片
- (IBAction)addImgAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [WToast showWithText:@"相机功能受限，请检查"];
        }
        else
        {
            NSString * mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
            {
                [WToast showWithText:@"相机没权限，请在设置里面打开"];
                //没权限
                return ;
            }
            else if(!self.imagePicke)
            {
                self.imagePicke = [[UIImagePickerController alloc]init];
                self.imagePicke.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicke.delegate = self;
                [self presentViewController:self.imagePicke animated:YES completion:nil];
            }
            else
            {
                self.imagePicke.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:self.imagePicke animated:YES completion:nil];
            }
        }
        
        
    }];
    UIAlertAction *libra = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
        {
            [WToast showWithText:@"相机没权限，请在设置里面打开"];
            return ;
        }
        [[SJPhotoPicker shareSJPhotoPicker] showPhotoPickerToController:self pickedAssets:^(NSArray<PHAsset *> *assets) {
            //            [self.image_Array removeAllObjects];
            //            [self.image_Array addObjectsFromArray:assets];
            [self.imageDataSource removeAllObjects];
            self.imageDataSource = [NSMutableArray arrayWithArray:assets];
            [self sendMoreImage];
        }];
        
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:camera];
    [alert addAction:libra];
    [alert addAction:cancel];

}
-(void)sendMoreImage{
    for (int i = 0; i < self.imageDataSource.count; i ++) {
        [[SJPhotoPickerManager shareSJPhotoPickerManager] requestImageForPHAsset:self.imageDataSource[i] targetSize:PHImageManagerMaximumSize imageResult:^(UIImage *image) {
            if(image)
            {
                [self.image_Array addObject:image];
                [self initImageScroView];
            }else
            {
                [WToast showWithText:@"请在系统相册下载icloud图片后重试。"];
            }
        }];
    }
    
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.image_Array addObject:image];
    [self initImageScroView];
    [self.imagePicke dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)initImageScroView{
    for(UIView *view in self.image_ScroView.subviews)
    {
        if(![view isEqual:self.addImg_Btn])
        {
            [view removeFromSuperview];
        }
    }
    
    self.image_ScroView.contentSize = CGSizeMake(150*self.image_Array.count, 0);
    for(int i =0;i<self.image_Array.count;i++){
        UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(90*i, 10, 70, 70)];
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        images.image = self.image_Array[i];
        [itemView addSubview:images];
        // [self.img_ScroView addSubview:images];
        UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleBtn.frame = CGRectMake(55, -10, 25, 25);
        [deleBtn setImage:[UIImage imageNamed:@"dele_img"] forState:UIControlStateNormal];
        //  [deleBtn ButtonWithIconStr:@"\U0000e6bf" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor redColor] andiconSize:PAPULARFONTSIZE];
        [itemView addSubview:deleBtn];
        
        [deleBtn addTarget:self action:@selector(deleImage:) forControlEvents:UIControlEventTouchUpInside];
        
        deleBtn.tag = i;
        
        [self.image_ScroView addSubview:itemView];
        
    }
}
//删除图片
-(void)deleImage:(UIButton *)sender{
    [self.image_Array removeObjectAtIndex:sender.tag];
    [self initImageScroView];
}
- (IBAction)selectCheck:(UIButton *)sender {
    self.ischeck = !self.ischeck;
    [self.check_Btn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:self.ischeck?BUTTON_COLOR:BASE_GRAY_COLOR andiconSize:20];
}

- (IBAction)select_Cat:(UIButton *)sender {
    SelectCatViewController *vc = [[SelectCatViewController alloc]init];
    vc.selectCat=^(NSDictionary *dic){
        self.cat_Id = [NSString stringWithFormat:@"%@",dic[@"id"]];
        self.cat_Name.text = dic[@"name"];
    };
    [self pushView:vc];
}
//选择是否全新
- (IBAction)selectYes_Action:(UIButton *)sender {
    if(sender.tag==0){
    [self.yes_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BUTTON_COLOR andiconSize:15];
        [self.no_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
        self.is_New = 1;
    }else{
        [self.no_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BUTTON_COLOR andiconSize:15];
        [self.yes_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
        self.is_New = 0;

    }

}
@end
