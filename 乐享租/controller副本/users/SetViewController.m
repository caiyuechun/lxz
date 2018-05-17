//
//  SetViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/22.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SetViewController.h"
#import "UserInfoViewController.h"
#import "ChangeNewPhoneViewController.h"
#import "ChangePwdViewController.h"
@interface SetViewController (){
BOOL clear;
}

@end

@implementation SetViewController
-(void)viewWillAppear:(BOOL)animated{
 //   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}
-(void)viewDidDisappear:(BOOL)animated{
   // [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
   // [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"设置" titleColor:nil right:@"" rightColor:nil rightAction:nil];
  //  self.navigationController.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    // Do any additional setup after loading the view from its nib.
}
-(void)createView{
    [self.icon1 LabelWithIconStr:@"\U0000e607" inIcon:iconfont andSize:CGSizeMake(25, 25) andColor:RGB(246, 15, 150) andiconSize:25];
     [self.icon2 LabelWithIconStr:@"\U0000e692" inIcon:iconfont andSize:CGSizeMake(25, 25) andColor:RGB(84, 179, 253) andiconSize:25];
    [self.icon3 LabelWithIconStr:@"\U0000e62f" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:RGB(104, 255, 215) andiconSize:25];
    [self.icon4 LabelWithIconStr:@"\U0000e605" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:RGB(246, 123, 27) andiconSize:25];
     [self.icon5 LabelWithIconStr:@"\U0000e7c0" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:RGB(246, 78, 94) andiconSize:25];
        [self.icon6 LabelWithIconStr:@"\U0000e647" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:RGB(222, 230, 125) andiconSize:25];
    
    [self.right1 LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
        [self.right2 LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
        [self.right3 LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
        [self.right4 LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
        [self.right5 LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
        [self.right6 LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    
    self.memeroLb.text = [NSString stringWithFormat:@"%.1f M", [self getCacheSizeandclear:0]];
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

- (IBAction)func:(UIButton *)sender {
    BaseViewController *vc = nil;
    NSInteger idx = sender.tag;
    switch (idx) {
        case 0:
        {
            vc = [[UserInfoViewController alloc]init];
        }
            break;
        case 1:{
            vc = [[ChangeNewPhoneViewController alloc]init];
        }
            break;
        case 2:{
            vc = [[ChangePwdViewController alloc]init];
        }
            break;
        case 3:{
            vc = [[ChangePwdViewController alloc]init];
        }
            break;
        case 4:{
            [self clearMerory];
        }
            break;
        case 5:{
            [XTool SaveDefaultInfo:nil Key:USER_INFO];
            [self.navigationController popViewControllerAnimated:0];
            [WToast showWithText:@"退出成功"];
        }
            break;
            
        default:
            break;
    }
    [self pushView:vc];
}
-(void)clearMerory
{
    if(!clear)
        self.memeroLb.text = [NSString stringWithFormat:@"%.1f M", [self getCacheSizeandclear:1]];
}
-(float)getCacheSizeandclear:(BOOL)clears
{
    float sizen = 0;
    //图片缓存路径路径
  //  NSFileManager* manager = [NSFileManager defaultManager];
    // [manager removeItemAtPath:fullpath error:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *cachesDir = [paths objectAtIndex:0];
    
    NSString *fullpath = [cachesDir stringByAppendingString:@"/com.hackemist.SDWebImageCache.default"];
    NSLog(@"全路径:%@",fullpath);
    //  NSArray *arr1 = [manager subpathsAtPath:fullpath];
    
    
    if(clears)
    {
        
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        //    NSLog(@"文件数 ：%d",[files count]);
        for (NSString *p in files)
        {
            NSError *error;
            NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
            if([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        clear = 1;
        return 0;
    }
    else
    {
        CGFloat  size = [SDImageCache sharedImageCache].getSize;
        sizen = ( size)/(1024*1024);
        return sizen;
    }
}
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
@end
