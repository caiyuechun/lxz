//
//  RandomCell.m
//  SHOP
//
//  Created by caiyc on 16/12/9.
//  Copyright © 2016年 changce. All rights reserved.
//   首页随便看看

#import "RandomCell.h"

@implementation RandomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
 //   self.backgroundColor = viewcontrollerColor;
   //  self.price1.font = [UIFont fontWithName:ICONNAME size:18];
    self.price1.textColor = PRICECOLOR;
    self.price2.textColor = PRICECOLOR;
   // self.botomView1.backgroundColor = [UIColor redColor];
    self.botomView1.layer.shadowColor=[UIColor grayColor].CGColor;
   self.botomView1.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.botomView1.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    self.botomView1.layer.shadowRadius = 2;//阴影半径，默认3 .layer.shadowOpacity = 0.8;//阴影透明度，默认0
    
    self.botomView2.layer.shadowColor=[UIColor grayColor].CGColor;
    self.botomView2.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.botomView2.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    self.botomView2.layer.shadowRadius = 2;//阴影半径，默认3 .layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.botomView2.hidden = 1;
    
    [self.img1 setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.img1.contentMode =  UIViewContentModeScaleAspectFill;
    self.img1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.img1.clipsToBounds  = YES;
    
    [self.img2 setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.img2.contentMode =  UIViewContentModeScaleAspectFill;
    self.img2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.img2.clipsToBounds  = YES;

    
//    [self.collectBtn1 ButtonWithIconStr:@"\U0000e62f" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE-5];
//    [self.collectBtn2 ButtonWithIconStr:@"\U0000e62f" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE-5];
  //  self.botomView2.hidden = 1;
//    self.hotLb1.textColor = PRICE_COLOR;
//    self.hotLb1.layer.borderColor = PRICE_COLOR.CGColor;
//    self.hotLb1.layer.borderWidth = 0.8;
//    self.hotLb1.layer.cornerRadius = 2;
    self.hotLb1.hidden = 1;
    
//    self.hotLb2.textColor = PRICE_COLOR;
//    self.hotLb2.layer.borderColor = PRICE_COLOR.CGColor;
//    self.hotLb2.layer.borderWidth = 0.8;
//    self.hotLb2.layer.cornerRadius = 2;
     self.hotLb1.hidden = 1;

//    self.botomView1.layer.cornerRadius = 5;
//    self.botomView1.layer.masksToBounds = 1;
//    self.botomView2.layer.cornerRadius = 5;
//    self.botomView2.layer.masksToBounds = 1;
    // Initialization code
}
-(void)bindData:(NSArray *)arr andIndex:(NSInteger)index
{
    NSDictionary *dic = arr[0];
    NSString *imageUrl1 = dic[@"original_img"];

    [self.img1 sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@"1122加载中"] ];

    self.img1.contentMode = UIViewContentModeScaleAspectFit;
    self.percent1.text = dic[@"newold"];
    self.name1.text = dic[@"goods_name"];
    self.descLb1.text = [dic[@"goods_remark"]isEqualToString:@""]?@"暂无简介":dic[@"goods_remark"];
    //self.describe.text = diction[@"goods_remark"];
    NSString*price = [NSString stringWithFormat:@"¥ %@/月",dic[@"shop_price"]];
//    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 //  [UIFont fontWithName:ICONNAME size:16],NSFontAttributeName];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-3)];
    self.price1.attributedText = AttributedStr;
    
    self.collectBtn1.tag = index*2;
    self.tapBtn.tag = index*2;
   // NSMutableArray *arrs = [NSMutableArray array];
//    if([dic[@"is_hot"]boolValue]==1)
//    {
//        //self.hotLb2.hidden = 0;
//        NSDictionary *objDic = @{@"color":RGB(248, 215, 139),@"biaoqian":@"热卖"};
//        [arrs addObject:objDic];
//    }
//    if([dic[@"is_recommend"]boolValue]==1)
//    {
//        //self.hotLb2.hidden = 0;
//        NSDictionary *objDic = @{@"color":RGB(247, 168, 139),@"biaoqian":@"推荐"};
//        [arrs addObject:objDic];
//    }
//    if([dic[@"is_new"]boolValue]==1)
//    {
//        //self.hotLb2.hidden = 0;
//        NSDictionary *objDic = @{@"color":RGB(246, 146, 16),@"biaoqian":@"新品"};
//        [arrs addObject:objDic];
//    }
//    for(int i =0;i<arrs.count;i++)
//    {
//        UILabel *biaoqian = [[UILabel alloc]initWithFrame:CGRectMake(i*29+(i+1)*8, 6, 29, 21)];
//        biaoqian.text = arrs[i][@"biaoqian"];
//        biaoqian.textColor = [UIColor whiteColor];
//        biaoqian.backgroundColor = arrs[i][@"color"];
//        biaoqian.font = [UIFont systemFontOfSize:12];
//        biaoqian.textAlignment = 1;
//        [self.botomView1 addSubview:biaoqian];
//    }
//    if([dic[@"is_hot"]boolValue]==1)
//    {
//        self.hotLb1.hidden = 0;
//    }
    if(arr.count==2)
    {
        self.botomView2.hidden = 0;
        NSDictionary *dic = arr[1];
        
        NSString *imageUrl2 = dic[@"original_img"];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@"11221加载中"] ];
        self.img2.contentMode = UIViewContentModeScaleAspectFit;
        self.percent2 = dic[@"newold"];
        self.name2.text = dic[@"goods_name"];
         self.descLb2.text = [dic[@"goods_remark"]isEqualToString:@""]?@"暂无简介":dic[@"goods_remark"];
        NSMutableArray *arr = [NSMutableArray array];
//        if([dic[@"is_hot"]boolValue]==1)
//        {
//            //self.hotLb2.hidden = 0;
//            NSDictionary *objDic = @{@"color":RGB(248, 215, 139),@"biaoqian":@"热卖"};
//            [arr addObject:objDic];
//        }
//        if([dic[@"is_recommend"]boolValue]==1)
//        {
//            //self.hotLb2.hidden = 0;
//            NSDictionary *objDic = @{@"color":RGB(247, 168, 139),@"biaoqian":@"推荐"};
//            [arr addObject:objDic];
//        }
//        if([dic[@"is_new"]boolValue]==1)
//        {
//            //self.hotLb2.hidden = 0;
//            NSDictionary *objDic = @{@"color":RGB(246, 146, 16),@"biaoqian":@"新品"};
//            [arr addObject:objDic];
//        }
//        for(int i =0;i<arr.count;i++)
//        {
//            UILabel *biaoqian = [[UILabel alloc]initWithFrame:CGRectMake(i*29+(i+1)*8, 6, 29, 21)];
//            biaoqian.text = arr[i][@"biaoqian"];
//            biaoqian.textColor = [UIColor whiteColor];
//            biaoqian.backgroundColor = arr[i][@"color"];
//            biaoqian.font = [UIFont systemFontOfSize:12];
//            biaoqian.textAlignment = 1;
//            [self.botomView2 addSubview:biaoqian];
//        }
               NSString*price = [NSString stringWithFormat:@"¥ %@/月",dic[@"shop_price"]];
       
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-3)];
        self.price2.attributedText = AttributedStr;
        self.tapBtn1.tag = index*2+1;
        self.collectBtn2.tag = index*2+1;
    }
    
    
}
-(void)bindData:(NSDictionary *)dic
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickItem:(UIButton *)sender {
    self.clickItemBlock(sender);
}
- (IBAction)collect:(UIButton *)sender {
    self.collectBlock(sender);
}
@end
