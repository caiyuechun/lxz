//
//  specView.m
//  testAutoLabel
//
//  Created by caiyc on 17/6/6.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "specViews.h"
#import "AutoButton.h"
#import "BuyCountView.h"
@implementation specViews 
{
    UIScrollView *scro;
    AutoButton *selectBtn;
    NSMutableArray *buttonArr;
    NSDictionary *goods;
    BuyCountView *countView;
    UILabel *priceLb;
    UILabel *store;
    NSMutableDictionary *specDic;
    NSString *specStr;
    NSMutableDictionary *specIDs;
    UIImageView *images;
    NSMutableArray *date_btnArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithDataSource:(NSDictionary *)gooddetail
{
    self = [super init];
    if(self)
    {
        specDic = [NSMutableDictionary dictionary];
        specIDs = [NSMutableDictionary dictionary];
        buttonArr = [NSMutableArray array];
        date_btnArr = [NSMutableArray array];
        goods = gooddetail;
        [self layoutViews];
    }
    return self;
}
-(void)layoutViews
{
   // self.backgroundColor = [UIColor redColor];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 100)];
   // topView.backgroundColor = [UIColor redColor];
    [self addSubview:topView];
    
   images = [[UIImageView alloc]initWithFrame:CGRectMake(10, -10, 100, 100)];
    [images sd_setImageWithURL:[NSURL URLWithString:goods[@"goods"][@"original_img"]]];
    images.contentMode = UIViewContentModeScaleAspectFit;
    [topView addSubview:images];
    
    UILabel*priceLbs = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 40, 20)];
    priceLbs.text = @"价格:";
    priceLbs.textColor = RGB(100, 100, 100);
    priceLbs.font = [UIFont systemFontOfSize:13];
    [topView addSubview:priceLbs];
    
    priceLb = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 100, 20)];
   // priceLb.text =[NSString stringWithFormat:@"¥%@",goods[@"goods"][@"shop_price"]];
    NSString *price = [NSString stringWithFormat:@"¥%@",goods[@"goods"][@"shop_price"]];
    // priceLb.text = [NSString stringWithFormat:@"¥%@",price];
    //    NSString*price = [NSString stringWithFormat:@"¥ %@",price];
    //    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
    //  [UIFont fontWithName:ICONNAME size:16],NSFontAttributeName];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
    priceLb.attributedText = AttributedStr;

    
    priceLb.tag = 103;
    priceLb.textColor = PRICECOLOR;
   // priceLb.font = [UIFont systemFontOfSize:15];
    [topView addSubview:priceLb];
    
    UILabel *stores = [[UILabel alloc]initWithFrame:CGRectMake(120, 40, 40, 20)];
    stores.text = @"库存:";
    stores.textColor = RGB(100, 100, 100);
    stores.font = [UIFont systemFontOfSize:13];
    [topView addSubview:stores];
    
    store = [[UILabel alloc]initWithFrame:CGRectMake(160, 40, 100, 20)];
    store.text = [NSString stringWithFormat: @"%@",goods[@"goods"][@"store_count"]];
    store.textColor = PRICECOLOR;
  //  price.tag = 104;
    store.font = [UIFont systemFontOfSize:15];
    [topView addSubview:store];
    
    UILabel *detaiLb = [[UILabel alloc]initWithFrame:CGRectMake(120, 70, 100, 20)];
    detaiLb.text = @"请选择规格";
    detaiLb.textColor = RGB(130, 130, 130);
    detaiLb.font = [UIFont systemFontOfSize:13];
    [topView addSubview:detaiLb];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(screen_width-50, -10, 50, 50);
    [btn ButtonWithIconStr:@"\U0000e603" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor blackColor] andiconSize:20];
    [btn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];
    
    
    //加减操作
    countView = [[BuyCountView alloc]initWithFrame:CGRectMake(0, screen_height/2, screen_width, 40)];
    [countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
   // countView.tf_count.delegate = self;
    [countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:countView];
    
    //租期选择
    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0,screen_height/2-50, screen_width, 50)];
    UILabel *labens = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 50)];
    labens.textColor = RGB(80, 80, 80);
    labens.font = [UIFont systemFontOfSize:14];
    labens.text = @"租期";
    for(int i =0;i<[goods[@"monthlist"]count];i++)
    {
        UIButton *date_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        date_Btn.frame = CGRectMake(60+60*i, 10, 50, 30);
        [date_Btn setTitle:goods[@"monthlist"][i][@"name"] forState:UIControlStateNormal];
        date_Btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [date_Btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        [dateView addSubview:date_Btn];
        date_Btn.layer.borderColor = viewcontrollerColor.CGColor;
        date_Btn.layer.borderWidth = 1;
        date_Btn.tag = i;
        [date_Btn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        [date_btnArr addObject:date_Btn];

    }

    [dateView addSubview:labens];
   // dateView.backgroundColor = [UIColor redColor];
    
    [self addSubview:dateView];

    
    //加入购物车
    UIButton *btn_sure = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_sure.frame = CGRectMake(screen_width/2, screen_height/2+50, screen_width/2, 50);
//    btn_sure.backgroundColor = [UIColor redColor];
     btn_sure.backgroundColor = BASE_COLOR;
    btn_sure.tag = 11100;
    [btn_sure setTitle:@"加入购物车" forState:UIControlStateNormal];
    [btn_sure addTarget:self action:@selector(sures:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_sure];
    
    //立即购买
    UIButton *btn_sure1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_sure1.frame = CGRectMake(0, screen_height/2+50, screen_width/2, 50);
    btn_sure1.tag = 11101;
    //    btn_sure.backgroundColor = [UIColor redColor];
    btn_sure1.backgroundColor =PRICECOLOR;
    [btn_sure1 setTitle:@"立即租用" forState:UIControlStateNormal];
    [btn_sure1 addTarget:self action:@selector(sures:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn_sure1];

    
    
    buttonArr = [NSMutableArray array];
    scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0,100, screen_width ,screen_height/2-150)];
    //scro.backgroundColor = [UIColor redColor];
    scro.contentSize = CGSizeMake(screen_width, screen_height/2-100);
    [self addSubview:scro];
    CGFloat labelHei = 0;
    CGFloat view_Height = 0.0;
    for(int i =0;i<[goods[@"goods"][@"goods_spec_list"]count];i++)
    {
        
        CGFloat startX = 10;
        CGFloat startY = 10;
        
        UIView *view = [[UIView alloc]init];
        
       
        //view.backgroundColor = [UIColor orangeColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 30)];
        titleLabel.text = goods[@"goods"][@"goods_spec_list"][i][@"name"] ;
        titleLabel.textColor = RGB(80, 80, 80);
        titleLabel.font = [UIFont systemFontOfSize:14];
        [view addSubview:titleLabel];
        startY = 40;
        labelHei+=40;
        NSMutableArray *btns = [NSMutableArray array];
        
        for(int j =0;j<[goods[@"goods"][@"goods_spec_list"][i][@"list"]count];j++)
        {
            NSDictionary *item = goods[@"goods"][@"goods_spec_list"][i][@"list"][j];
            AutoButton *button = [AutoButton buttonWithType:UIButtonTypeCustom];
            button.pIndex = i;
            button.tag = j;
            
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            NSString *str = [item objectForKey:@"item"] ;
            
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
            CGSize size = [str sizeWithAttributes:dic];
            
          //  NSLog(@"X坐标%f,Y坐标%f",startX,startY);
            if(startX+size.width+20+20>screen_width)//每个按钮之间间隙10
            {
                startX = 10;
                startY +=40;
                labelHei+=40;
            }
            
            button.frame = CGRectMake(startX, startY, size.width+15, 30);
            [button setTitle:str forState:UIControlStateNormal];
            [button setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
            button.layer.borderColor = viewcontrollerColor.CGColor;
            button.layer.borderWidth = 1;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [view addSubview:button];
            [btns addObject:button];//按钮加入数组
            startX+=size.width+20+20;
            
            
            if(j==0)
            {
                button.selected = 1;
                button.layer.borderColor = [UIColor redColor].CGColor;
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                NSString *keys = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"name"];
                NSString *vclue = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"item_id"];
                //NSString *vclue = button.titleLabel.text;
                NSString *item_id = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"item_id"];
                NSString *imageUrl = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"src"];
                if(![imageUrl isEqualToString:@""])
                {
                     [images sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
                }
//                images = [[UIImageView alloc]initWithFrame:CGRectMake(10, -10, 100, 100)];
//                [images sd_setImageWithURL:[NSURL URLWithString:goods[@"goods"][@"original_img"]]];
//                [topView addSubview:images];
                //  NSString *keys = button.titleLabel.text;
//                NSString *vclue =  self.goodDic[@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"item_id"];
//                NSString *keys = self.goodDic[@"goods_spec_list"][button.pIndex][@"name"];
//                //    NSString *vclue = button.titleLabel.text;
//                NSString *item_id = self.goodDic[@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"item_id"];
//                [self.specDic setObject:vclue forKey:keys];
//                [self.specIDs setObject:item_id forKey:keys];
//                self. specStr = [self objcectToJson:self.specDic isEnd:1];
                [specDic setObject:vclue forKey:keys];
                [specIDs setObject:item_id forKey:keys];
                specStr = [self objcectToJson:specDic isEnd:1];
                
                //变化价格
                if(specDic.count==[goods[@"goods"][@"goods_spec_list"]count])
                {
                    NSMutableArray *array = [NSMutableArray arrayWithArray: specIDs.allValues];
                    NSMutableArray *mutiArr = [NSMutableArray array];
                    for(int j =0;j<[goods[@"goods"][@"goods_spec_list"]count];j++)
                    {
                        NSString *keys = goods[@"goods"][@"goods_spec_list"][j][@"name"];
                        for(int i=0;i<array.count;i++)
                        {
                            
                            NSString *key =[specIDs allKeys][i];
                            if([keys isEqualToString:key])
                            {
                                [mutiArr addObject:specIDs[key]];
//                                if(i<theData.count-1){
//                                    //     [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,theData[key]]];
//                                    [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
//                                }else
//                                {
//                                    //  [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
//                                    [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,theData[key]]];
//                                }
                            }
                        }
                        
                        
                    }


                    NSString *itemkey = [mutiArr componentsJoinedByString:@"_"];
                 
                    NSDictionary *dic = [goods[@"spec_goods_price"] objectForKey:itemkey];
                    NSString *price = [NSString stringWithFormat:@"¥%@",dic[@"price"]];
                  
                    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
                    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
                    priceLb.attributedText = AttributedStr;
                    
                    store.text = [NSString stringWithFormat:@"%@",dic[@"store_count"]];
                    
                }


            }
            

        }
        [buttonArr addObject:btns];
        if(i==0)
        {
            view.frame = CGRectMake(0, labelHei-40, screen_width, startY+40);
            
        }else{
            view.frame = CGRectMake(0, labelHei-40, screen_width, startY+40);
        }
        UILabel *specLb = [[UILabel alloc]initWithFrame:CGRectMake(10, view.frame.size.height-1, screen_width-20, 1)];
        specLb.backgroundColor = viewcontrollerColor;
        [view addSubview:specLb];
        labelHei = view.frame.origin.y+view.frame.size.height;
        [scro addSubview:view];
        view.tag = i;
        scro.contentSize = CGSizeMake(screen_width, labelHei+view.frame.size.height);
        scro.showsVerticalScrollIndicator = 0;
       // scro.backgroundColor = [UIColor yellowColor];
        view_Height = labelHei+view.frame.size.height;
    
            //  view.backgroundColor = [UIColor orangeColor];
    }
    
    

}
-(void)selectDate:(UIButton *)sender{
   //   NSArray *arrs = date_btnArr[sender.tag];
    for(UIButton *btn in date_btnArr){
        if(btn==sender){
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor redColor].CGColor;
        }else{
            [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
            btn.layer.borderColor = viewcontrollerColor.CGColor;

        }
    
    }
    NSString *date_id = [NSString stringWithFormat:@"%@", goods[@"monthlist"][sender.tag][@"id"]];
    self.selectDate(date_id);
}
-(void)closeView
{
    self.closeViews();
}
-(NSString *)objcectToJson:(NSDictionary*)theData isEnd:(BOOL)isend
{
    NSMutableString *jsonStrs=[NSMutableString string];
    [jsonStrs appendString:@"{"];
    for(int j =0;j<[goods[@"goods"][@"goods_spec_list"]count];j++)
    {
        NSString *keys = goods[@"goods"][@"goods_spec_list"][j][@"name"];
        for(int i=0;i<[theData allKeys].count;i++)
        {
            
            NSString *key = [theData allKeys][i];
            if([keys isEqualToString:key])
            {
                if([goods[@"goods"][@"goods_spec_list"]count]==1)
                {
                     [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
                }else{
            if(j<[goods[@"goods"][@"goods_spec_list"]count]-1){
           //     [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,theData[key]]];
                  [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,theData[key]]];
            }else
            {
              //  [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
                 [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
            }
                }
            }
        }

        
    }
       if(isend){
        [jsonStrs appendString:@"}"];
    }else
        [jsonStrs appendString:@"},"];
    return jsonStrs;
    
}
-(void)sures:(UIButton *)btn
{
    BOOL buynow = 0;
    if(btn.tag== 11101)
    {
        buynow = 1;
    }
    self.sure(countView.tf_count.text,specStr,buynow);
}
#pragma mark-数量加减
-(void)add
{
    int count =[countView.tf_count.text intValue];
    countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
//    if (count < self.stock) {
//        countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
//    }else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
}
-(void)reduce
{
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
    }else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        alert.tag = 100;
        //        [alert show];
    }
}

-(void)click:(AutoButton *)button
{
    
    
    
    NSLog(@"选中状态%d",button.selected);
    NSArray *arrs = buttonArr[button.pIndex];
    NSString *ids=[NSString stringWithFormat:@"%@",goods[@"goods"][@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"item_id"]];
    NSString *price = [goods[@"spec_goods_price"]objectForKey:ids][@"price"];
    NSString *stores =[ goods[@"spec_goods_price"]objectForKey:ids][@"store_count"];
    NSLog(@"价格%@", price);
   
//    priceLb.text = [NSString stringWithFormat:@"价格：%@",price];
//    store.text = [NSString stringWithFormat:@"库存：%@",stores];
    
    for(AutoButton *btn in arrs)
    {
        if(btn!=button){
            
            btn.selected = 0;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.layer.borderColor = viewcontrollerColor.CGColor;
        //    btn.backgroundColor = RGB(255, 255, 255);
        }
    }
    
    if(button.selected==NO)
    {
        //如果未选中
       // button.backgroundColor = [UIColor redColor];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor redColor].CGColor;
        button.selected = YES;
        NSString *keys = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"name"];
        NSString *vclue = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"item_id"];
        //NSString *vclue = button.titleLabel.text;
        NSString *item_id = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"item_id"];
        [specDic setObject:vclue forKey:keys];
        [specIDs setObject:item_id forKey:keys];
        specStr = [self objcectToJson:specDic isEnd:1];
        //变化价格
        if(specDic.count==[goods[@"goods"][@"goods_spec_list"]count])
        {
            NSMutableArray *array = [NSMutableArray arrayWithArray: specIDs.allValues];
            NSMutableArray *mutiArr = [NSMutableArray array];
            for(int j =0;j<[goods[@"goods"][@"goods_spec_list"]count];j++)
            {
                NSString *keys = goods[@"goods"][@"goods_spec_list"][j][@"name"];
                for(int i=0;i<array.count;i++)
                {
                    
                    NSString *key =[specIDs allKeys][i];
                    if([keys isEqualToString:key])
                    {
                        [mutiArr addObject:specIDs[key]];
                        //                                if(i<theData.count-1){
                        //                                    //     [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,theData[key]]];
                        //                                    [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
                        //                                }else
                        //                                {
                        //                                    //  [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",key,theData[key]]];
                        //                                    [jsonStrs appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",key,theData[key]]];
                        //                                }
                    }
                }
                
                
            }
            
            //                    for (int  i =0; i<[array count]-1; i++) {
            //
            //                        for (int j = i+1; j<[array count]; j++) {
            //
            //                            if ([array[i] intValue]>[array[j] intValue]) {
            //
            //                                //交换
            //
            //                                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            //
            //                            }
            //
            //                        }
            //                        
            //                    }
            NSString *itemkey = [mutiArr componentsJoinedByString:@"_"];
            NSLog(@".........价格库存字段===%@",itemkey);
            NSDictionary *priceDic = goods[@"spec_goods_price"];
            NSDictionary *dic = [priceDic objectForKey:itemkey];
            NSString *price = [NSString stringWithFormat:@"¥%@",dic[@"price"]];
           // priceLb.text = [NSString stringWithFormat:@"¥%@",price];
        //    NSString*price = [NSString stringWithFormat:@"¥ %@",price];
            //    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
            //  [UIFont fontWithName:ICONNAME size:16],NSFontAttributeName];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
            priceLb.attributedText = AttributedStr;

            store.text = [NSString stringWithFormat:@"%@",dic[@"store_count"]];
            NSString *imageUrl = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"list"][button.tag][@"src"];
            if(![imageUrl isEqualToString:@""])
            {
                [images sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            }


        }
        
        
    }else
    {
//        //如果选中
//        button.selected = NO;
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        button.layer.borderColor = viewcontrollerColor.CGColor;
//       // button.backgroundColor = RGB(255, 255, 255);
//        
//        NSString *keys = goods[@"goods"][@"goods_spec_list"][button.pIndex][@"name"];
//       // NSString *vclue = button.titleLabel.text;
//        [specDic removeObjectForKey:keys];
//         [specIDs removeObjectForKey:keys];
//        if(specDic.count==0)
//        {
//            specStr = @"";
//        }
//        else
//        {
//        specStr = [self objcectToJson:specDic isEnd:1];
//        }

    }
    
    NSLog(@"json=%@",specStr);
   // self.selctSpec(specStr);
}
-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
@end
