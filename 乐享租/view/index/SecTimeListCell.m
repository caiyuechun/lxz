//
//  SecTimeListCell.m
//  乐享租
//
//  Created by caiyc on 18/5/9.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SecTimeListCell.h"

@implementation SecTimeListCell
{
    __weak IBOutlet UILabel *secPrice;
    __weak IBOutlet UILabel *oldPrice;
    dispatch_source_t _timer;
    NSString *time1;
    NSString *start1;
}

- (void)awakeFromNib {
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopttime) name:@"stoptimes" object:nil];
    self.layer.cornerRadius = 3;
    self.layer.borderColor = viewcontrollerColor.CGColor;
    self.layer.borderWidth = .8;
    secPrice.textColor = PRICECOLOR;
//    self.layer.shadowColor=[UIColor grayColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.layer.shadowOpacity = 0.1;//阴影透明度，默认0
//    self.layer.shadowRadius = 2;//阴影半径，默认
//    // Initialization code
}
-(void)stopttime{
    dispatch_source_cancel(_timer);
}
-(void)bindData:(NSDictionary *)dic{
    [self.image sd_setImageWithURL:[NSURL URLWithString:dic[@"original_img"]] placeholderImage:nil];
    self.name.text = dic[@"title"];
    time1 = dic[@"end_time"];
    start1 = dic[@"now_time"];
    secPrice.text = [NSString stringWithFormat:@"抢租价：%@/月",dic[@"price"]];
    oldPrice.text = [NSString stringWithFormat:@"原价：%@/月",dic[@"shop_price"]];
    [self sss];
}
-(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
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
    NSString *startss = [self getNowTimeTimestamp];
    NSDate *startDate = [self getyyyymmdd:startss];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    // if (_timer==nil) {
    __block int timeout = timeInterval; //倒计时时间
    
    if (timeout!=0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                if(start1)
                {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"timeoutss" object:nil userInfo:nil];
                }
                dispatch_source_cancel(_timer);
                _timer = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.dayLabel.text = @"";
                    self.hourLabel1.text = @"00";
                    self.minuteLabel.text = @"00";
                    self.secondLabel.text = @"00";
                });
            }else{
                int days = (int)(timeout/(3600*24));
                NSLog(@"天数计算===%d",days);
                if (days==0) {
                    self.dayLabel.text = @"0天";
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
                        self.hourLabel1.text = [NSString stringWithFormat:@"0%d",hours];
                    }else{
                        self.hourLabel1.text = [NSString stringWithFormat:@"%d",hours];
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

@end
