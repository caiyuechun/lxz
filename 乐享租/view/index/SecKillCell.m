//
//  RandomCell.m
//  SHOP
//
//  Created by caiyc on 16/12/9.
//  Copyright © 2016年 changce. All rights reserved.
//   首页随便看看

#import "SecKillCell.h"

@implementation SecKillCell
{
    dispatch_source_t _timer;
    dispatch_source_t _timer1;
    NSString *time1;
    NSString *time2;
    NSString *start1;
    NSString *stare2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = viewcontrollerColor;
    [self.collectBtn1 ButtonWithIconStr:@"\U0000e62f" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE-5];
    [self.collectBtn2 ButtonWithIconStr:@"\U0000e62f" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE-5];
    self.botomView2.hidden = 1;
    
    self.price2.textColor = PRICECOLOR;
    self.price1.textColor = PRICECOLOR;
//    self.botomView1.layer.cornerRadius = 5;
//    self.botomView1.layer.masksToBounds = 1;
//    self.botomView2.layer.cornerRadius = 5;
//    self.botomView2.layer.masksToBounds = 1;
    // Initialization code
}
-(void)bindData:(NSArray *)arr andIndex:(NSInteger)index
{
    NSDictionary *dic = arr[0];
    NSString *imageUrl1 =dic[ @"original_img"];
//    NSString *imageUrl1 = [NSString stringWithFormat:@"%@%@",BASE_IMG_PATH,dic[@"goods_id"]];
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:nil];
    
   
    self.name1.text = dic[@"title"];
    self.decLb1.text = dic[@"description"];
    time1 = dic[@"end_time"];
    start1 = dic[@"now_time"];
    //self.describe.text = diction[@"goods_remark"];
   // self.price1.text = [NSString stringWithFormat:@"¥ %@",dic[@"price"]];
    NSString*price = [NSString stringWithFormat:@"抢租价：%@/月",dic[@"price"]];
    self.price1.text = price;
    //    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
    //  [UIFont fontWithName:ICONNAME size:16],NSFontAttributeName];
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
//    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
//    self.price1.attributedText = AttributedStr;

    NSString *shopPrice = [NSString stringWithFormat:@"原价：%@/月",dic[@"shop_price"]];
    self.oldPrice1.text = shopPrice;
//    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//   NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:shopPrice attributes:attribtDic];
//    self.oldPrice1.attributedText = attribtStr;

    self.collectBtn1.tag = index*2;
    self.tapBtn.tag = index*2;
    if(arr.count==2)
    {
        
        self.botomView2.hidden = 0;
        NSDictionary *dic = arr[1];
         NSString *imageUrl1 =dic[ @"original_img"];
//        NSString *imageUrl1 = [NSString stringWithFormat:@"%@%@",BASE_IMG_PATH,dic[@"goods_id"]];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imageUrl1] placeholderImage:nil];
        self.name2.text = dic[@"title"];
        self.descLb2.text = dic[@"description"];
        time2 = dic[@"end_time"];
        stare2 = dic[@"now_time"];
        //self.describe.text = diction[@"goods_remark"];
      //  self.price2.text = [NSString stringWithFormat:@"¥ %@",dic[@"price"]];
        NSString*price = [NSString stringWithFormat:@"原价：%@/月",dic[@"shop_price"]];
        self.oldPrice2.text = price;
        //    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
        //  [UIFont fontWithName:ICONNAME size:16],NSFontAttributeName];
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
//        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
//        self.price2.attributedText = AttributedStr;

        self.tapBtn1.tag = index*2+1;
        self.collectBtn2.tag = index*2+1;
        
        NSString *shopPrice = [NSString stringWithFormat:@"抢租价：%@/月",dic[@"price"]];
        self.price2.text = shopPrice;
//        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:shopPrice attributes:attribtDic];
//        self.oldPrice2.attributedText = attribtStr;

    }
    [self sss];
    [self s];
    
}
-(NSDate *)getyyyymmdd:(NSString *)tiem{
    
    NSTimeInterval tm = [tiem doubleValue];
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:tm];
    NSLog(@"时间戳转化时间 >>> %@",[stampFormatter stringFromDate:stampDate2]);
    return stampDate2;
}
-(void)sss{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
//    NSDate *endDate = [dateFormatter dateFromString:[self getyyyymmdd]];
//    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate] + 24*3600)];
    NSDate *endDate_tomorrow =[self getyyyymmdd:time1];
    NSDate *startDate =[self getyyyymmdd:start1];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
   // if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                     [[NSNotificationCenter defaultCenter]postNotificationName:@"timeout" object:nil userInfo:nil];
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.dayLabel.text = @"";
                        self.hourLabel.text = @"00";
                        self.minuteLabel.text = @"00";
                        self.secondLabel.text = @"00";
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                        self.dayLabel.text = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayLabel.text = @"0天";
                        }else{
                            self.dayLabel.text = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            self.hourLabel.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            self.hourLabel.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteLabel.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteLabel.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLabel.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    //}



}
-(void)s{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
//    NSDate *endDate = [dateFormatter dateFromString:[self getyyyymmdd]];
//    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate] + 24*3600)];
    NSDate *endDate_tomorrow = [self getyyyymmdd:time2];
    NSDate *startDate =[self getyyyymmdd:stare2];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
//    if (_timer==nil) {
//        __block int timeout = timeInterval; //倒计时时间
    __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer1,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer1, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"timeout" object:nil userInfo:nil];
                    dispatch_source_cancel(_timer1);
                    _timer1 = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.dayLabel1.text = @"";
                        self.hourLabel1.text = @"00";
                        self.minuteLabel1.text = @"00";
                        self.secondLabel1.text = @"00";
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                        self.dayLabel1.text = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayLabel1.text = @"0天";
                        }else{
                            self.dayLabel1.text = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            self.hourLabel1.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                            self.hourLabel1.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteLabel1.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteLabel1.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondLabel1.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLabel1.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer1);
        }
    //}



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
