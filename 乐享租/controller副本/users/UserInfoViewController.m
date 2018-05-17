//
//  UserInfoViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/19.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "UserInfoViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface UserInfoViewController ()<UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSDictionary *user_Dic;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)UIImagePickerController *imagePicke;
@property(nonatomic,strong)UIImage *icons;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"个人信息" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.botom_ScroView.contentSize = CGSizeMake(0, screen_height*1.2);
    self.date_Pickeer.hidden = 1;
    self.date_Pickeer.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.date_Pickeer.datePickerMode = UIDatePickerModeDate;
    self.date_Pickeer.backgroundColor = viewcontrollerColor;
     [self.date_Pickeer addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    self.icon_Img.userInteractionEnabled = 1;
    UITapGestureRecognizer *icon_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImge)];
    [self.icon_Img addGestureRecognizer:icon_Tap];
    
    UITapGestureRecognizer *view_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.view addGestureRecognizer:view_Tap];
    [self createView];
    [self loadInfo];
    // Do any additional setup after loading the view from its nib.
}
-(void)hideView{
    self.date_Pickeer.hidden = 1;
}
- (void)dateChange:(UIDatePicker *)datePicker
{
    //    NSLog(@"%@",datePicker.date);
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    
    // 给生日文本框赋值
    self.birthday.text = dateStr;
}
//头像选择器
- (IBAction)selectImge {
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
        
        
        if(self.imagePicke)
        {
            self.imagePicke.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else
        {
            self.imagePicke = [[UIImagePickerController alloc]init];
            self.imagePicke.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicke.delegate = self;
        }
        [self presentViewController:self.imagePicke animated:YES completion:nil];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:camera];
    [alert addAction:libra];
    [alert addAction:cancel];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //NSLog(@"选择的图片回调%@",info);
    NSLog(@"相册:%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.icon_Img.image = image;
    self.icons = image;
    [self.imagePicke dismissViewControllerAnimated:YES completion:nil];
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@/User/uploadimage",BASE_URL];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
//    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *data = UIImageJPEGRepresentation(image, 0.00001);
//        
//        [formData appendPartWithFileData:data name:@"image" fileName:@"icon.jpg" mimeType:@"image/jpeg"];
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"上传回调===%@",responseObject);
//        if([[responseObject objectForKey:@"status"]integerValue]!=200)
//        {
//            
//            NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
//            NSDictionary *paramter = @{@"user_id":userDic[USER_ID],@"head_pic":[responseObject objectForKey:@"result"][@"image"][@"urlpath"]};
//            
//            NSLog(@"编辑头像信息%@",paramter);
//            [self postWithURLString:@"/User/updateUserInfo" parameters:paramter success:^(id response) {
//                [WToast showWithText:[response objectForKey:@"msg"]];
//                // [self updataInfo];
//            } failure:^(NSError *error) {
//                //NSLog(@"图片上传失败%@",error);
//            }];
//            return ;
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"图片上传失败%@",error);
//    }];
    
    
}
-(void)loadInfo{
    
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/user/userInfo" parameters:param success:^(id response) {
        if(response){
            self.user_Dic = response[@"result"];
            [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:self.user_Dic[@"head_pic"] ] placeholderImage:nil];
            self.userId_Lab.text = [NSString stringWithFormat:@"%@", self.user_Dic[@"user_id"]];
            self.mobile_Lab.text = [NSString stringWithFormat:@"%@",self.user_Dic[@"mobile"]];
            self.nick_Tf.text = self.user_Dic[@"nickname"];
            self.sex = [NSString stringWithFormat:@"%@",self.user_Dic[@"sex"]];
            self.birthday.text = self.user_Dic[@"birthday"];
            if([self.user_Dic[@"sex"]integerValue]==1){
                [self.manCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];

            }
            if([self.user_Dic[@"sex"]integerValue]==2){
                [self.woCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];
                
            }

            
        }
        NSLog(@"res==%@",response);
    } failure:^(NSError *error) {
        
    }];

}
-(void)save{
    if(!self.icons){
    NSDictionary *param = @{@"nickname":self.nick_Tf.text,@"sex":self.sex,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"birthday":self.birthday.text};
    [self postWithURLString:@"/user/updateUserInfo" parameters:param success:^(id response) {
         [WToast showWithText:response[@"msg"]];
        if(response){
            NSDictionary *user = [NSDictionary changeType: response[@"result"]];
            [XTool SaveDefaultInfo:user Key:USER_INFO];
        }
    } failure:^(NSError *error) {
        
    }];
    }else{
        NSDictionary *paramss = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
         NSString *urlStr = [NSString stringWithFormat:@"%@/User/uploadimage",BASE_URL];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
            [manager POST:urlStr parameters:paramss constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSData *data = UIImageJPEGRepresentation(self.icons, 0.00001);
                NSLog(@"data==%@",data);
                [formData appendPartWithFileData:data name:@"file" fileName:@"icon.jpg" mimeType:@"image/jpeg"];
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                NSLog(@"上传回调===%@",responseObject);
              //   [WToast showWithText:responseObject[@"msg"]];
                if([responseObject[@"status"]integerValue]==1){
                    NSDictionary *param = @{@"nickname":self.nick_Tf.text,@"sex":self.sex,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"head_pic":responseObject[@"result"][@"file"][@"urlpath"],@"birthday":self.birthday.text};
                    [self postWithURLString:@"/user/updateUserInfo" parameters:param success:^(id response) {
                        [WToast showWithText:response[@"msg"]];
                        if(response){
                            NSDictionary *user = [NSDictionary changeType: response[@"result"]];
                            [XTool SaveDefaultInfo:user Key:USER_INFO];
                        }
                    } failure:^(NSError *error) {
                        
                    }];

                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"图片上传失败%@",error);
            }];

    
    
    }
}
-(void)createView{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(screen_width-leftSpece-btnSize,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
    [rightBtn  setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [self.naviView addSubview:rightBtn];
    [self.manCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
     [self.woCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    self.icon_Img.layer.masksToBounds = 1;
    self.icon_Img.layer.cornerRadius = self.icon_Img.frame.size.width/2;
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

- (IBAction)selectSex:(UIButton *)sender {
    if(sender.tag==0){
    self.sex = @"1";
         [self.manCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];
        [self.woCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];

    }else{
    self.sex = @"2";
        [self.woCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];
         [self.manCheck_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];

    }
}
- (IBAction)selectBirth:(UIButton *)sender {
    self.date_Pickeer.hidden = 0;
}
@end
