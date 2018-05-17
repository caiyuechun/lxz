//
//  DistubeViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//  发布二手

#import "DistubeViewController.h"
#import "SJPhotoPicker.h"
#import "SJPhotoPickerNavController.h"
#import "SelectCatViewController.h"
@interface DistubeViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePicke;
@property(nonatomic,strong)NSMutableArray *image_Array;
@property(nonatomic,strong)NSMutableArray *imageDataSource;
@property(assign)BOOL is_New;//是否全新
@property(nonatomic,strong)NSString *cat_Id;
@end

@implementation DistubeViewController

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
     [self.yes_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    [self.no_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];

    

    self.image_Array = [NSMutableArray array];
    self.imageDataSource = [NSMutableArray array];
    
    
    if(self.goodDic){
        self.title_Tf.text = self.goodDic[@"goods_name"];
        self.content_Tv.text = self.goodDic[@"goods_remark"];
        self.address_Tf.text = self.goodDic[@"cityname"];
        for(int i=0;i<[self.goodDic[@"imgs"]count];i++){
            //异步下载图片
            SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
            NSString *urls =self.goodDic[@"imgs"][i];
            
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
        
        
    }

    // Do any additional setup after loading the view from its nib.
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
       // NSString *month =[  self.date_biaoji componentsJoinedByString:@","];
        NSString *urlStr = [NSString stringWithFormat:@"%@/goods/uploadimage",BASE_URL];
//        self postWithURLString:<#(NSString *)#> parameters:<#(id)#> success:<#^(id response)success#> failure:<#^(NSError *error)failure#>
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
//         NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"goods_name":self.title_Tf.text,@"content":self.content_Tv.text,@"shop_price":self.price_Tf.text,@"newold":[NSString stringWithFormat:@"%d",self.is_New],@"cityname":@"昆明",@"goods_id":self.goodDic[@"goods_id"]};
        NSDictionary *paramss = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
        [manager POST:urlStr parameters:paramss constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for(NSInteger i = 0; i <self.image_Array.count; i++) {
                NSData * imageData = UIImageJPEGRepresentation([self.image_Array objectAtIndex: i], 0.5);
                // 上传的参数名
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                [formData appendPartWithFileData:imageData name:@"file[]" fileName:fileName mimeType:@"image/jpeg"];
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
                NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"goods_name":self.title_Tf.text,@"content":self.content_Tv.text,@"shop_price":self.price_Tf.text,@"newold":[NSString stringWithFormat:@"%d",self.is_New],@"cityname":self.address_Tf.text,@"goods_id":self.goodDic[@"goods_id"],@"imgs":images_Str};
                [self postWithURLString:@"/goods/edit_publishgoods" parameters:paramter success:^(id response) {
                    if(response){
                        [WToast showWithText:@"编辑成功"];
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                } failure:^(NSError *error) {
                    
                }];


                
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

    NSString *urlStr = [NSString stringWithFormat:@"%@/goods/publishgoods",BASE_URL];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"goods_name":self.title_Tf.text,@"content":self.content_Tv.text,@"shop_price":self.price_Tf.text,@"newold":[NSString stringWithFormat:@"%d",self.is_New],@"cityname":@"昆明"};
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
