//
//  AddAdressViewController.m
//  SHOP
//
//  Created by caiyc on 16/11/30.
//  Copyright © 2016年 changce. All rights reserved.
//   添加收货地址

#import "AddAdressViewController.h"

@interface AddAdressViewController ()<UITextViewDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
   // NSString *str;
    NSString *provice;
    NSString *state;
    NSString *area;
}
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *cities;
@property(nonatomic,strong)NSMutableArray *areas;
@property(nonatomic,strong)NSMutableArray *streets;
@property(assign)NSInteger selectIdnex;
@property(assign)NSInteger selectAreaIndex;
@property(assign)NSInteger firstIndex;
@property(assign)NSInteger secondIndex;
@property(assign)NSInteger thirdIndex;
@property(assign)NSInteger fourthIndex;
@property(assign)BOOL selelct;

@end

@implementation AddAdressViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.firstIndex = -1;
    self.secondIndex = -1;
    self.thirdIndex = -1;
    self.dataSource = [NSMutableArray array];
    self.cities = [NSMutableArray array];
    self.areas = [NSMutableArray array];
    self.streets = [NSMutableArray array];
    self.view.backgroundColor = viewcontrollerColor;
    self.scroView.backgroundColor = viewcontrollerColor;
    [self.rightBtn ButtonWithIconStr:@"\U0000e6d3" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE];
    self.ConfirmBtn.layer.masksToBounds = 1;
    self.ConfirmBtn.layer.cornerRadius = 25;
     [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:[UIColor blackColor] title:@"添加收货地址" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.scroView.contentSize = CGSizeMake(screen_width, screen_height+30);
    self.scroView.showsVerticalScrollIndicator = 0;
    self.scroView.delegate = self;
    self.DetailText.delegate = self;
    self.nameTf.delegate = self;
    self.numTf.delegate = self;
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, screen_height-216, screen_width, 216)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    self.pickerView.hidden = 1;
    
    self.selectIdnex = 0;
    self.selectAreaIndex = 0;

//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
//    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"areas.plist"];
//     NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL Exists = [fileManager fileExistsAtPath:filePatch];
//    if(!Exists){
//        
//                 NSError *error;
//                BOOL success = [fileManager copyItemAtPath:plistPath toPath:filePatch error:&error];
//                 if(!success){
//                       NSAssert1(0, @"错误写入文件:'%@'.", [error localizedDescription]);
//                     }
//          }
//    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:filePatch];
//    self.dataSource= [NSArray arrayWithContentsOfFile:filePatch];
//    self.cities = [self.dataSource[0]objectForKey:@"cities"];
//    self.areas = [[self.cities objectAtIndex:0]objectForKey:@"areas"];
//    NSLog(@"dataSource:%@---%@---%@",self.dataSource,dataDic,filePatch);
    
//    NSDictionary *dic = @{@"name":self.nameTf.text,
//                          @"num":self.numTf.text,
//                          @"address":self.addressLb.text,
//                          @"detail":self.DetailText.text};
    if(self.addressDic)
    {
//        self.nameLb.text = [dic objectForKey:@"consignee"];
//        // self.addressLb.text = dic[@"address"];
//        self.address.text = [NSString stringWithFormat:@"%@%@%@%@",dic[@"province"],dic[@"city"],dic[@"district"],dic[@"address"]];
        //  self.telephoneLable.text = dic[@"mobile"];
        self.nameTf.text = self.addressDic[@"consignee"];
        self.numTf.text = self.addressDic[@"mobile"];
        self.addressLb.text =  [NSString stringWithFormat:@"%@%@%@",self.addressDic[@"provincename"],self.addressDic[@"cityname"],self.addressDic[@"districtname"]];
        self.DetailText.text = self.addressDic[@"address"];
         self.placeLb.hidden = 1;
        [self.nameTf becomeFirstResponder];
    }else
    {
         self.addressLb.text = @"北京市市辖区东城区";
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicker:)];
    [self.addressLb addGestureRecognizer:tap];
    self.addressLb.userInteractionEnabled = 1;
    [self getRegion:@"1" andpid:@"0"];
   
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.pickerView.hidden = 1;
}
-(void)getRegion:(NSString *)level andpid:(NSString *)pid
{
    
   
    //self.selelct = 1;
    NSDictionary *paramter = @{@"level":level,@"pid":pid};
    [self getWithURLString:@"/User/region" parameters:paramter success:^(id response) {
        SLog(@"获取地区信息%@",response);
        if([level isEqualToString:@"2"])[self.cities removeAllObjects];
        if([level isEqualToString:@"3"])[self.areas removeAllObjects];
        for(NSDictionary *dic in [response objectForKey:@"result"])
        {
            if([level isEqualToString:@"1"]){
              //  [self.dataSource removeAllObjects];
            [self.dataSource addObject:dic];
                
            }
            else if ([level isEqualToString:@"2"])
            {
                
              //  [self.cities removeAllObjects];
                [self.cities addObject:dic];
                //[self.pickerView reloadComponent:1];
            }
            else
            {
                //[self.areas removeAllObjects];
                [self.areas addObject:dic];
               // [self.pickerView reloadComponent:2];
            }
            
//            else
//            {
//                [self.streets addObject:dic];
//                [self.pickerView reloadComponent:3];
//            }
        }
        if([level isEqualToString:@"1"])
        {[self.pickerView reloadComponent:0];
            [self reloadfirstCommpents];
            self.firstIndex = 0;
           [self.pickerView selectRow:0 inComponent:0 animated:YES];
        }
        else if ( [level isEqualToString:@"2"])
        {
            [self.pickerView reloadComponent:1];
            self.secondIndex = 0;
            [self reloadsecodCommpents];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
        }
        else
        {
            self.thirdIndex = 0;
            [self.pickerView reloadComponent:2];
        }
//        proId = [self.dataSource objectAtIndex:self.firstIndex][@"id"];
//        cityId = [self.cities objectAtIndex:self.secondIndex][@"id"];
//        districtId = [self.areas objectAtIndex:self.thirdIndex][@"id"];
//        if(self.firstIndex==0&&self.secondIndex==0&&self.thirdIndex==0)
//        {
//        self.addressLb.text = [NSString stringWithFormat:@"%@%@%@",[self.dataSource objectAtIndex:self.firstIndex][@"name"],[self.cities objectAtIndex:self.secondIndex][@"name"],[self.areas objectAtIndex:self.thirdIndex][@"name"]];
//        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息%@",error);
    }];
}
-(void)reloadfirstCommpents
{
    NSString *pid = [NSString stringWithFormat:@"%@",self.dataSource[0][@"id"]];
    [self getRegion:@"2" andpid:pid];
    self.secondIndex = 0;
    
}
-(void)reloadsecodCommpents
{
    NSString *pid = [NSString stringWithFormat:@"%@",self.cities[0][@"id"]];
    [self getRegion:@"3" andpid:pid];
    self.thirdIndex = 0;

}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if(component==0)
    {
        return self.dataSource.count;
    }
    else if (component==1)
    {
        return self.cities.count;
    }
    else
    {
        return self.areas.count;
    }
   // else return self.streets.count;
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    if(component==0)
    {
        title = [self.dataSource[row]objectForKey:@"name"];
        provice = title;
    }else if (component==1)
    {
        title = [[self.cities objectAtIndex:row]objectForKey:@"name"];
        state = title;
    }
    else if(component==2)
    {
        title = [[self.areas objectAtIndex:row]objectForKey:@"name"];
        if(self.areas.count>0)
        {
          area = title;
        }
      
    }else
    {
       // title = [[self.streets objectAtIndex:row]objectForKey:@"name"];
    }
    NSString *address;
    if(self.areas.count>0)
    {
        address= [NSString stringWithFormat:@"%@%@%@",provice,state,area];
       // self.selelct = 1;
    }
    else
    {
        address = [NSString stringWithFormat:@"%@%@",provice,state];
      //  self.selelct
    }
    if(self.selelct)
    {
    self.addressLb.text = address;
    }
   // NSLog(@"%@%@%@",provice,state,area);
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"进入方法");
    self.selelct = 1;
    if(component==0)
    {
        self.firstIndex = row;
      //  [self.cities removeAllObjects];
         [pickerView selectRow:0 inComponent:1 animated:YES];//更新到第一行
        NSString *pid = [self.dataSource objectAtIndex:row][@"id"];
        [self getRegion:@"2" andpid:pid];
//        self.cities = [self.dataSource[row]objectForKey:@"cities"];
       
//        self.areas = [[self.cities objectAtIndex:0]objectForKey:@"areas"];
//      [self.pickerView reloadComponent:1];
//        [self.pickerView reloadComponent:2];
    }
    else if(component==1)
    {
        self.secondIndex = row;
      //  [self.areas removeAllObjects];
        [pickerView selectRow:0 inComponent:2 animated:YES];//更新到第一行
        NSString *pid = [self.cities objectAtIndex:row][@"id"];
        [self getRegion:@"3" andpid:pid];

//        self.areas = [[self.cities objectAtIndex:row]objectForKey:@"areas"];
        
//        [self.pickerView reloadComponent:2];
    }
    else     {
        self.thirdIndex = row;
        [self.streets removeAllObjects];
        NSString *pid = [self.areas objectAtIndex:row][@"id"];
        [self getRegion:@"4" andpid:pid];
    }
    
        //self.selectAreaIndex = row;
//    }else
//    {
//        self.fourthIndex = row;
//    }
   

    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
      //  pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:1];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeLb.hidden = 1;
    self.pickerView.hidden = 1;
}
-(void)textViewDidChange:(UITextView *)textView
{
    //NSLog(@"....%lu",(unsigned long)textView.text.length);
    NSLog(@"......%lu",(unsigned long)textView.text.length);
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

- (IBAction)showPicker:(UIButton *)sender {
    [self.view endEditing:1];
    [self.scroView setContentOffset:CGPointMake(0, 100) animated:YES];
    self.pickerView.hidden = !self.pickerView.hidden;
}
//确认添加
- (IBAction)DoConfirm:(UIButton *)sender {
    [self.view endEditing:1];
    
    self.pickerView.hidden = 1;
//    if(self.addressDic)
//    {
//        
//    }
    if(self.addressDic)
    {
        
        if([self.nameTf.text isEqualToString:self.addressDic[@"consignee"]]&&[self.numTf.text isEqualToString:self.addressDic[@"mobile"]]&&[self.addressLb.text isEqualToString:[NSString stringWithFormat:@"%@%@%@",self.addressDic[@"province"],self.addressDic[@"city"],self.addressDic[@"district"]]]&&[self.DetailText.text isEqualToString:self.addressDic[@"address"]])
        {
            [WToast showWithText:@"至少更改一项信息"];
            return;
        }
    }else
    {
    if([self.nameTf.text isEqualToString:@""]||[self.numTf.text isEqualToString:@""]||[self.addressLb.text isEqualToString:@""]||[self.DetailText.text isEqualToString:@""]||self.firstIndex<0||self.secondIndex<0||self.thirdIndex<0)
    {
        [WToast showWithText:@"请填写完整的收货信息"];
        return;
    }
    }
    NSString *proId;
    NSString *cityId;
    NSString *districtId;
    if(self.addressDic)
    {
//        proId = self.addressDic[@"provinceid"];
//                cityId = self.addressDic[@"cityid"];
//                districtId = self.addressDic[@"districtid"];
//                    proId = [self.dataSource objectAtIndex:self.firstIndex][@"id"];
//                    cityId = [self.cities objectAtIndex:self.secondIndex][@"id"];
//                    districtId = [self.areas objectAtIndex:self.thirdIndex][@"id"];

        if([self.addressLb.text isEqualToString:[NSString stringWithFormat:@"%@%@%@",self.addressDic[@"province"],self.addressDic[@"city"],self.addressDic[@"district"]]])//判断区域是否更改
        {
        proId = self.addressDic[@"provinceid"];
        cityId = self.addressDic[@"cityid"];
        districtId = self.addressDic[@"districtid"];
        }else
        {
            proId = [self.dataSource objectAtIndex:self.firstIndex][@"id"];
            cityId = [self.cities objectAtIndex:self.secondIndex][@"id"];
            districtId = [self.areas objectAtIndex:self.thirdIndex][@"id"];
        }
    }else
    {
        proId = [self.dataSource objectAtIndex:self.firstIndex][@"id"];
        cityId = [self.cities objectAtIndex:self.secondIndex][@"id"];
        districtId = [self.areas objectAtIndex:self.thirdIndex][@"id"];
    }
    NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *dic = @{@"consignee":self.nameTf.text,
                          @"mobile":self.numTf.text,
                          @"district":districtId,
                          @"city":cityId,
                          @"province":proId,
                          @"user_id":userDic[USER_ID],
                          @"address":self.DetailText.text,@"address_id":self.addressDic?self.addressDic[@"address_id"]:@""};
    NSLog(@"...dic...%@",dic);
    [self postWithURLString:@"/User/addAddress" parameters:dic success:^(id response) {
        if(self.addressDic)[WToast showWithText:@"修改成功"];
        else
        [WToast showWithText:@"添加成功"];
        NSLog(@"添加收货地址：%@",response);
        //如果是编辑
        if(self.addressDic)
        {
           // NSLog(@"传递过来的地址数据%@",self.addressDic);
//            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[XTool GetDefaultInfo:ADDRESS]];
//            [arr replaceObjectAtIndex:self.editIndex withObject:dic];
         //   [XTool SaveDefaultInfo:arr Key:ADDRESS];
            self.editSucess(dic);
        }
        else{
            if([XTool GetDefaultInfo:ADDRESS])
            {
                NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:[XTool GetDefaultInfo:ADDRESS]];
                [arr addObject:dic];
             //   [XTool SaveDefaultInfo:arr Key:ADDRESS];
                
            }
            else{
                NSMutableArray *arr = [NSMutableArray array];
                [arr addObject:dic];
            //    [XTool SaveDefaultInfo:arr Key:ADDRESS];
                
            }
           // self.addSucess(dic);
        }
        [self.navigationController popViewControllerAnimated:NO];
    } failure:^(NSError *error) {
        
    }];
//    for(NSString *key in [dic allKeys])
//    {
//        NSLog(@"key....%@",key);
//    }
    
}
@end
