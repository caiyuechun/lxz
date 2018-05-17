//
//  AddressListViewController.m
//  SHOP
//
//  Created by caiyc on 16/12/6.
//  Copyright © 2016年 changce. All rights reserved.
//   收货地址列表页面

#import "AddressListViewController.h"
#import "AddressCell.h"
#import "AddAdressViewController.h"
@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation AddressListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self getData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = viewcontrollerColor;
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:[UIColor blackColor] title:@"收货地址" titleColor:[UIColor blackColor] right:@"" rightColor:[UIColor blackColor] rightAction:nil];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(screen_width-50, 20, 50, 40);
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:btn];

//    [self  initNaviView:[UIColor whiteColor] title:@"收货地址" haveLeft:1 right:@"\U0000e626" rightAction:@selector(addAddress)];
    self.dataSource = [NSMutableArray array];
    self.addressList.delegate = self;
    self.addressList.dataSource = self;
    self.addressList.backgroundColor = viewcontrollerColor;
    self.addressList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.addressList.showsVerticalScrollIndicator = 0;
//   if([XTool GetDefaultInfo:ADDRESS])
//   {
//       self.dataSource = [[NSMutableArray alloc]initWithArray:[XTool GetDefaultInfo:ADDRESS]];
//       [self.addressList reloadData];
//   }else
    //[self getData];
   
    // Do any additional setup after loading the view from its nib.
}
-(void)getData{
    NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *paramter = @{@"user_id":userDic[USER_ID]};
    [self getWithURLString:@"/User/getAddressList" parameters:paramter success:^(id response) {
        NSLog(@"收货地址%@",response);
        if([[response objectForKey:@"result"]isKindOfClass:[NSString class]])
        {
            [WToast showWithText:@"暂无地址，去添加"];
        }else{
            [XTool SaveDefaultInfo:[response objectForKey:@"result"] Key:ADDRESS];
            [self.dataSource removeAllObjects];
        for(NSDictionary *dics in [response objectForKey:@"result"])
        {
            if([dics[@"is_default"]boolValue])
            {
                [XTool SaveDefaultInfo:dics Key:ADDRESS_DEFULT];
            }
            [self.dataSource addObject:dics];
        }
        [self.addressList reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败：%@",error);
    }];
    
}
-(void)addAddress
{
    AddAdressViewController *vc = [[AddAdressViewController alloc]init];
//    vc.addSucess=^(NSDictionary *diction)
//    {
//        [self getData];
//    };
    [self pushView:vc];
    //[self.navigationController pushViewController:vc animated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bindData:self.dataSource[indexPath.row] andIndex:indexPath.row];//绑定数据
    __weak AddressCell *weakcell = cell;
    __weak AddressListViewController *weakself = self;
    cell.defaultAction=^(UIButton *btn)
    {
        btn.selected = !btn.selected;
        NSLog(@"....tag....%ld",(long)btn.tag);
        weakcell.defaultImageLb.textColor = btn.selected? [UIColor redColor]:[UIColor grayColor];
        if(btn.selected)//设为默认
        {
            NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
            NSDictionary *paramter = @{@"address_id":self.dataSource[indexPath.row][@"address_id"],
                                       @"user_id":userDic[USER_ID]};
            [self getWithURLString:@"/User/setDefaultAddress" parameters:paramter success:^(id response) {
                
                NSLog(@"设置默认地址%@",response);
             //   [WToast showWithText:[response objectForKey:@"msg"]];
               
                NSInteger indexs = (btn.tag-1)/100-1;
                NSDictionary *dic = [weakself.dataSource objectAtIndex:indexs];
                [XTool SaveDefaultInfo:dic Key:ADDRESS_DEFULT];
                for(int i=0;i<self.dataSource.count;i++)
                {
                    NSDictionary *dics  = self.dataSource[i];
                    NSMutableDictionary *muDic = [[NSMutableDictionary alloc]initWithDictionary:dics];
                    if(indexs==i)
                    {
                        [muDic setObject:@"1" forKey:@"is_default"];
                    }else [muDic setObject:@"0" forKey:@"is_default"];
                    [self.dataSource replaceObjectAtIndex:i withObject:muDic];
                }
                [self.addressList reloadData];
              //  NSMutableDictionary *muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
                if(self.needback){
                self.select(dic);
                    [self.navigationController popViewControllerAnimated:0];
                }
                
//                if(self.iselect)
//                {
//                    self.select(dic);
//                    [self.navigationController popViewControllerAnimated:NO];
//                }
            } failure:^(NSError *error) {
                
            }];
           
            
        }
        else
        {
             [XTool SaveDefaultInfo:nil Key:ADDRESS_DEFULT];
        }
    };
    cell.editAction = ^(UIButton *brn)
    {
        //编辑
        AddAdressViewController *vc = [[AddAdressViewController alloc]init];
        vc.addressDic = self.dataSource[indexPath.row];
        vc.editIndex = indexPath.row;
        vc.editSucess=^(NSDictionary *diction)
        {
          //  [weakself.dataSource replaceObjectAtIndex:indexPath.row withObject:diction];
            //[weakself.addressList reloadData];
        };
        [weakself pushView:vc];

    };
    cell.deleteAction=^(UIButton *btn)
    {
        //删除
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该地址?" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
            NSDictionary *paramter = @{@"user_id":userDic[USER_ID],
                                       @"id":self.dataSource[indexPath.row][@"address_id"]};
            [self getWithURLString:@"/User/del_address" parameters:paramter success:^(id response) {
                NSLog(@"删除地址%@",response);
                if(self.dataSource[indexPath.row][@"is_default"])
                {
                    [XTool SaveDefaultInfo:nil Key:ADDRESS_DEFULT];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"DELETADD" object:nil userInfo:nil];
                }
                [weakself.dataSource removeObjectAtIndex:indexPath.row];
                [weakself.addressList reloadData];
//                NSInteger indexs = (btn.tag-1)/10000-1;
//                        [weakself.dataSource removeObjectAtIndex:indexs];
//                        [weakself.addressList reloadData];
                        [XTool SaveDefaultInfo:weakself.dataSource Key:ADDRESS];
            } failure:^(NSError *error) {
                
            }];
//        NSLog(@"delete tag..%ld",(long)btn.tag);
//        NSInteger indexs = (btn.tag-1)/10000-1;
//        [weakself.dataSource removeObjectAtIndex:indexs];
//        [weakself.addressList reloadData];
//        [XTool SaveDefaultInfo:weakself.dataSource Key:ADDRESS];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择对象%ld",indexPath.row);
    if(self.needback){
    self.select(self.dataSource[indexPath.row]);
    [self.navigationController popViewControllerAnimated:NO];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
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
