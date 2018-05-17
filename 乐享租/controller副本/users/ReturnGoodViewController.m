//
//  CommetGoodViewController.m
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//  退货

#import "ReturnGoodViewController.h"
#import "CommentGoodModel.h"
#import "CommentCell.h"
#import "SJPhotoPicker.h"
#import "SJPhotoPickerNavController.h"
#import "WriteShipViewController.h"
#import "RetCell.h"

@interface ReturnGoodViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIImagePickerController *imagePicke;
@property(nonatomic,strong)NSMutableArray *imageDataSource;
@property(nonatomic,strong)NSMutableArray *image_Array;
@property(assign)NSInteger addPhotoIndex;
@property(nonatomic,strong)UIView *imagePopview;
@property(nonatomic,strong)UIImageView *checkImage;
@property(assign)NSInteger deleIndex;
@property(nonatomic,strong)NSDictionary *shipDic;
@property(nonatomic,strong)NSDictionary *orderDic;

@end

@implementation ReturnGoodViewController
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:1];
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.place_Lab.hidden = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSouce = [NSMutableArray array];
    self.image_Array = [NSMutableArray array];
    self.reason_Tv.delegate = self;
    self.botom_ScroView.contentSize = CGSizeMake(screen_width, screen_height*1.5);
    self.botom_ScroView.delegate = self;
    NSString *titles = @"";
    NSLog(@"....订单编号%@",self.order_Sn);
    if([self.type isEqualToString:@"0"])
    {
        titles = @"归还申请";
    }else titles = @"评价";
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:titles titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.view.backgroundColor = viewcontrollerColor;
    
    self.imagePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.imagePopview.backgroundColor = RGBA(0, 0, 0, .9);
    self.imagePopview.hidden = 1;
    
    [self.addImg_Btn ButtonWithIconStr:@"\U0000e60a" inIcon:iconfont andSize:CGSizeMake(60, 60) andColor:BASE_GRAY_COLOR andiconSize:50];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(screen_width-60, 15, 40, 30);
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(deleImage:) forControlEvents:UIControlEventTouchUpInside];
    
   // [btn setImage:[UIImage imageNamed:@"icon-5"] forState:UIControlStateNormal];
    self.checkImage = [[UIImageView alloc]init];
    
    self.checkImage.frame = CGRectMake(0, 20, screen_width, screen_height-40);
    
    self.checkImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.imagePopview addSubview:self.checkImage];
    
    [self.imagePopview addSubview:btn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missPop)];
    [self.imagePopview addGestureRecognizer:tap];
    [self.view addSubview:self.imagePopview];
    
    self.note_Tv.userInteractionEnabled = 0;
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.showsVerticalScrollIndicator = 0;
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":self.order_id};
    [self postWithURLString:@"/user/return_remark" parameters:param success:^(id response) {
        SLog(@"订单详情数据------%@",response);
        if(response)
        {
            
           self.orderDic = response[@"result"];
            NSDictionary *goodDic = response[@"result"];
           [self.good_Img sd_setImageWithURL:[NSURL URLWithString:goodDic[@"original_img"]] placeholderImage:nil];
           self.good_Name.text = goodDic[@"goods_name"];
            self.good_Date.text = [NSString stringWithFormat:@"租期：%@月 已租：%@月",goodDic[@"month_num"],goodDic[@"month_num_buy"]];
            self.good_Price.text = [NSString stringWithFormat:@"已付租金：%@/月",goodDic[@"total_pay_amount"]];
            self.good_Price.textColor = PRICECOLOR;
            self.note_Tv.text = goodDic[@"explain"];
//            for(int i=0;i<[response[@"result"][@"goods_list"]count];i++)
//            {
//                        NSDictionary *goodDic = response[@"result"][@"goods_list"][i];
////                for(int j =0;j<[goodDic[@"list"]count];j++)
////                {
//                
//                    NSDictionary *goods = goodDic;
//                    if([self.type isEqualToString:@"1"])
//                    {
//                    if([goods[@"is_comment"]boolValue]==0)
//                    {
//                        CommentGoodModel *model = [[CommentGoodModel alloc]init];
//                        model.image = goods[@"original_img"];
//                        model.name = goods[@"goods_name"];
//                        model.spec = goods[@"spec_key_name"];
//                        model.spec_key = goods[@"spec_key"];
//                        model.comment = @"";
//                        model.goodId = [NSString stringWithFormat:@"%@",goods[@"goods_id"]];
//                        [self.dataSouce addObject:model];
//                    }
//                    }else
//                    {
//                        if([goods[@"retr"]boolValue]==0)
//                        {
//                            CommentGoodModel *model = [[CommentGoodModel alloc]init];
//                            model.image = goods[@"original_img"];
//                            model.name = goods[@"goods_name"];
//                            model.spec = goods[@"spec_key_name"];
//                            model.spec_key = goods[@"spec_key"];
//                            model.comment = @"";
//                            model.goodId = [NSString stringWithFormat:@"%@",goods[@"goods_id"]];
//                            [self.dataSouce addObject:model];
//                        }
//
//                    }
//                }
//
//            //}
//            [self.tableView reloadData];
        }
       
    } failure:^(NSError *error) {
        
    }];

    // Do any additional setup after loading the view from its nib.
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.dataSouce.count;
//}
//
//// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
//// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   static NSString *cellId = @"cell";
//     RetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if(!cell)
//    {
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"RetCell" owner:self options:nil]lastObject];
//    }
//    if([self.type isEqualToString:@"1"]){
//        cell.ship_Btn.hidden = 1;
//    }
//    
//    
//    [cell bindModel:self.dataSouce[indexPath.row]];
//    if([self.type isEqualToString:@"0"])
//    {
//        cell.placeLb.text = @"备注";
//        [cell.commentBtn setTitle:@"提交申请" forState:UIControlStateNormal];
//    }
//    __weak ReturnGoodViewController *weakSelf = self;
//    cell.addphoto=^(){
//        weakSelf.addPhotoIndex = indexPath.row;
//        [weakSelf addPhoto];
//        
//    };
//    cell.checkImage = ^(NSInteger index){
//        weakSelf.imagePopview.hidden = 0;
//        CommentGoodModel *model = self.dataSouce[indexPath.row];
//        weakSelf.checkImage.image = model.imageArr[index];
//        weakSelf.deleIndex = index;
//    };
//    cell.writeships=^(){
//        WriteShipViewController *vc = [[WriteShipViewController alloc]init];
//        vc.shipDic = ^(NSDictionary *dic){
//            weakSelf.shipDic = dic;
//        };
//        vc.needBack = 1;
//        [weakSelf pushView:vc];
//    };
//    cell.commit =^(CommentGoodModel *model){
//        
//      //  CommentGoodModel *model = weakSelf.dataSouce[indexPath.row];
//        [weakSelf submit:model];
//      //  model.comment = cell.commentTv.text;
//        
//    };
//    return cell;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 440;
//}
//-(void)missPop
//{
//    self.imagePopview.hidden = 1;
//
//}
//-(void)deleImage:(UIButton *)sender
//{
//    self.imagePopview.hidden =1;
//    CommentGoodModel *model = self.dataSouce[self.addPhotoIndex];
//    [model.imageArr removeObjectAtIndex:self.deleIndex];
//    [self.tableView  reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.addPhotoIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//}
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

//-(void)addPhoto{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
//    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            [WToast showWithText:@"相机功能受限，请检查"];
//        }
//        else
//        {
//            NSString * mediaType = AVMediaTypeVideo;
//            AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//            if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
//            {
//                [WToast showWithText:@"相机没权限，请在设置里面打开"];
//                //没权限
//                return ;
//            }
//            else if(!self.imagePicke)
//            {
//                self.imagePicke = [[UIImagePickerController alloc]init];
//                self.imagePicke.sourceType = UIImagePickerControllerSourceTypeCamera;
//                self.imagePicke.delegate = self;
//                [self presentViewController:self.imagePicke animated:YES completion:nil];
//            }
//            else
//            {
//                self.imagePicke.sourceType = UIImagePickerControllerSourceTypeCamera;
//                [self presentViewController:self.imagePicke animated:YES completion:nil];
//            }
//        }
//        
//        
//    }];
//    UIAlertAction *libra = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSString * mediaType = AVMediaTypeVideo;
//        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
//        {
//            [WToast showWithText:@"相机没权限，请在设置里面打开"];
//            return ;
//        }
//     //   [self.navigationController setNavigationBarHidden:0 animated:YES];
//        [[SJPhotoPicker shareSJPhotoPicker] showPhotoPickerToController:self pickedAssets:^(NSArray<PHAsset *> *assets) {
//            [self.imageDataSource removeAllObjects];
//            self.imageDataSource = [NSMutableArray arrayWithArray:assets];
//            [self sendMoreImage];
//        }];
//}];
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [self presentViewController:alert animated:YES completion:nil];
//        [alert addAction:camera];
//        [alert addAction:libra];
//        [alert addAction:cancel];
//
//
//
//}
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//{
//   // [self.navigationController setNavigationBarHidden:1 animated:YES];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    CommentGoodModel *model = self.dataSouce[self.addPhotoIndex];
//    
//    [model.imageArr addObject:image];
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.addPhotoIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//    //[self.photoArr addObject:image];
//   // [self initImgeScro];
//    [self.imagePicke dismissViewControllerAnimated:YES completion:nil];
//}
//-(void)sendMoreImage{
//    for (int i = 0; i < self.imageDataSource.count; i ++) {
//        [[SJPhotoPickerManager shareSJPhotoPickerManager] requestImageForPHAsset:self.imageDataSource[i] targetSize:PHImageManagerMaximumSize imageResult:^(UIImage *image) {
//            if(image)
//            {
//                CommentGoodModel *model = self.dataSouce[self.addPhotoIndex];
//                NSLog(@"内容==%@",model.comment);
//                [model.imageArr addObject:image];
//                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.addPhotoIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//            }else
//            {
//                [WToast showWithText:@"请在系统相册下载icloud图片后重试。"];
//            }
//        }];
//    }
//    
//    
//}
- (IBAction)submits:(UIButton *)sender {
    if([self.ship_CodeTf.text isEqualToString:@""]||[self.ship_NameTf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写完整的快递信息"];
        return;
    }
     NSString *urlStr = [NSString stringWithFormat:@"%@/user/return_product",BASE_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    
    NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *paramter = [NSDictionary dictionary];
    paramter = @{@"order_id":self.order_id,@"goods_id":[NSString stringWithFormat:@"%@",self.orderDic[@"goods_id"]],@"reason":self.reason_Tv.text,@"user_id":userDic[USER_ID],@"type":@"0",@"order_sn":self.order_Sn,@"codenum":self.ship_CodeTf.text,@"companys":self.ship_NameTf.text};

//    if([self.type isEqualToString:@"1"])
//    {
//        paramter = @{@"order_id":self.order_id,@"goods_id":model.goodId,@"content":model.comment,@"user_id":userDic[USER_ID]};
//    }else
//    {
//        if([model.spec_key isEqualToString:@""])
//        {
//            //  NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"goods_id":self.goodDic[@"goods_id"],@"shipping_name":self.shipName_Tf.text,@"shipping_code":self.shipcode_Tf.text};
//            paramter = @{@"order_id":self.order_id,@"goods_id":model.goodId,@"reason":model.comment,@"user_id":userDic[USER_ID],@"type":@"0",@"order_sn":self.order_Sn,@"codenum":self.shipDic[@"shipping_code"],@"companys":self.shipDic[@"shipping_name"]};
//            
//        }else
//        {
//            
//            paramter = @{@"order_id":self.order_id,@"goods_id":model.goodId,@"reason":model.comment,@"user_id":userDic[USER_ID],@"type":@"0",@"order_sn":self.order_Sn,@"codenum":self.shipDic[@"shipping_code"],@"companys":self.shipDic[@"shipping_name"]};
//        }
//        
//    }
    NSLog(@"评论参数：%@",paramter);
    if(self.image_Array.count>0){
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
                // [WToast showWithText:responseObject[@"msg"]];
                [WToast showWithText:@"成功"];
               // [self.dataSouce removeObject:model];
                if(self.dataSouce.count==0)
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }else
                {
                    [self.tableView reloadData];
                }
                //[self.navigationController popViewControllerAnimated:NO];
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [WToast showWithText:@"评论失败请重试"];
            NSLog(@"上传失败原因===%@",error);
        }];
    }else
    {
        NSString *url = @"/user/return_product";
//        if([self.type isEqualToString:@"1"])
//        {
//            url = @"/user/add_comment";
//        }else url = @"/user/return_product";
        [self postWithURLString:url parameters:paramter
                        success:^(id response) {
                            NSLog(@"fanhui%@",response);
                            if(response)
                            {
                                if([[response objectForKey:@"status"]integerValue]==1)
                                {
                                    //[WToast showWithText:response[@"msg"]];
                                    [WToast showWithText:@"成功"];
                                    [self.navigationController popViewControllerAnimated:NO];
                                }
                              //  [self.dataSouce removeObject:model];
                                if(self.dataSouce.count==0)
                                {
                                    [self.navigationController popViewControllerAnimated:NO];
                                }else
                                {
//                                    [self.tableView reloadData];
                                }
                                
                            }
                        } failure:^(NSError *error) {
                            
                        }];
    }

}
//提交评论
- (IBAction)submit:(CommentGoodModel *)model {
    if([model.comment isEqualToString:@""])
    {
        [WToast showWithText:@"请填写理由"];
        return;
    }
    if([self.type isEqualToString:@"0"]){
        if(!self.shipDic){
            [WToast showWithText:@"请填写快递信息"];
            return;

        }
    }
    NSLog(@"model image===%@",model.imageArr);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/add_comment",BASE_URL];
    if([self.type isEqualToString:@"0"])
    {
        urlStr =  [NSString stringWithFormat:@"%@/user/return_product",BASE_URL];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    
    NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *paramter = [NSDictionary dictionary];
    if([self.type isEqualToString:@"1"])
    {
    paramter = @{@"order_id":self.order_id,@"goods_id":model.goodId,@"content":model.comment,@"user_id":userDic[USER_ID]};
    }else
    {
        if([model.spec_key isEqualToString:@""])
        {
              //  NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"goods_id":self.goodDic[@"goods_id"],@"shipping_name":self.shipName_Tf.text,@"shipping_code":self.shipcode_Tf.text};
             paramter = @{@"order_id":self.order_id,@"goods_id":model.goodId,@"reason":model.comment,@"user_id":userDic[USER_ID],@"type":@"0",@"order_sn":self.order_Sn,@"codenum":self.shipDic[@"shipping_code"],@"companys":self.shipDic[@"shipping_name"]};
            
        }else
        {
           
        paramter = @{@"order_id":self.order_id,@"goods_id":model.goodId,@"reason":model.comment,@"user_id":userDic[USER_ID],@"type":@"0",@"order_sn":self.order_Sn,@"codenum":self.shipDic[@"shipping_code"],@"companys":self.shipDic[@"shipping_name"]};
        }

    }
    NSLog(@"评论参数：%@",paramter);
    if(model.imageArr.count>0){
        [manager POST:urlStr parameters:paramter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for(NSInteger i = 0; i <model.imageArr.count; i++) {
                NSData * imageData = UIImageJPEGRepresentation([model.imageArr objectAtIndex: i], 0.5);
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
                // [WToast showWithText:responseObject[@"msg"]];
                [WToast showWithText:@"成功"];
                [self.dataSouce removeObject:model];
                if(self.dataSouce.count==0)
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }else
                {
                [self.tableView reloadData];
                }
                //[self.navigationController popViewControllerAnimated:NO];
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [WToast showWithText:@"评论失败请重试"];
            NSLog(@"上传失败原因===%@",error);
        }];
    }else
    {
        NSString *url = @"";
        if([self.type isEqualToString:@"1"])
        {
            url = @"/user/add_comment";
        }else url = @"/user/return_product";
        [self postWithURLString:url parameters:paramter
                        success:^(id response) {
                            NSLog(@"fanhui%@",response);
                            if(response)
                            {
                                if([[response objectForKey:@"status"]integerValue]==1)
                                {
                                    //[WToast showWithText:response[@"msg"]];
                                    [WToast showWithText:@"成功"];
                                    [self.navigationController popViewControllerAnimated:NO];
                                }
                                [self.dataSouce removeObject:model];
                                if(self.dataSouce.count==0)
                                {
                                    [self.navigationController popViewControllerAnimated:NO];
                                }else
                                {
                                    [self.tableView reloadData];
                                }

                            }
                        } failure:^(NSError *error) {
                            
                        }];
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
