//
//  DistubeViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//  发布文章

#import "PublishController.h"
#import "SJPhotoPicker.h"
#import "SJPhotoPickerNavController.h"
#import "SocailCatogyViewController.h"
@interface PublishController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePicke;
@property(nonatomic,strong)NSMutableArray *image_Array;
@property(nonatomic,strong)NSMutableArray *imageDataSource;
@property(nonatomic,strong)NSString *cat_Id;
@end

@implementation PublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"发布" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    
    self.submit_Btn.layer.cornerRadius  = 25;
    self.submit_Btn.layer.masksToBounds = 1;
    self.bottom_ScroView.backgroundColor = [UIColor whiteColor];
    self.bottom_ScroView.contentSize = CGSizeMake(0, screen_height*1.2);
    self.bottom_ScroView.showsVerticalScrollIndicator = 0;
    self.bottom_ScroView.delegate = self;
    
    [self.addImg_Btn ButtonWithIconStr:@"\U0000e60a" inIcon:iconfont andSize:CGSizeMake(60, 60) andColor:BASE_GRAY_COLOR andiconSize:50];
    [self.right_Lab LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    self.image_Array = [NSMutableArray array];
    self.imageDataSource = [NSMutableArray array];
    
   // self.title_Tf.delegate = self;
    [self.title_Tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.title_Tf) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:1];
    
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
    [self.view endEditing:1];
    NSString *titles = self.title_Tf.text;
    if(titles.length<5){
        [WToast showWithText:@"请填写至少5个字的标题"];
        return;
    }
    self.submit_Btn.userInteractionEnabled = 0;
    self.submit_Btn.backgroundColor = BASE_GRAY_COLOR;
    NSString *urlStr = [NSString stringWithFormat:@"%@/Article/publish",BASE_URL];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"cat_id":self.cat_Id,@"title":self.title_Tf.text,@"content":self.content_Tv.text};
    if(self.image_Array.count==0){
        [self postWithURLString:@"/Article/publish" parameters:paramter success:^(id response) {
            self.submit_Btn.userInteractionEnabled = 1;
            self.submit_Btn.backgroundColor = BUTTON_COLOR;
            if(response){
            [WToast showWithText:response[@"msg"]];
                [self.navigationController popViewControllerAnimated:0];
            }
//            else
//            [WToast showWithText:response[@"msg"]];
        } failure:^(NSError *error) {
             [WToast showWithText:@"发布失败，请重试"];
            self.submit_Btn.userInteractionEnabled = 1;
            self.submit_Btn.backgroundColor = BUTTON_COLOR;
        }];
    }
    else{
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

        }else{
        [WToast showWithText:responseObject[@"msg"]];
            self.submit_Btn.userInteractionEnabled = 1;
            self.submit_Btn.backgroundColor = BUTTON_COLOR;

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
- (IBAction)select_Cat:(id)sender {
    SocailCatogyViewController *vc = [[SocailCatogyViewController alloc]init];
    vc.selectCat = ^(NSString *ids,NSString *name){
        self.cat_Id = ids;
        self.cat_name.text = name;
        
    };
    [self pushView:vc];
}
@end
