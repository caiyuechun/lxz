//
//  Index_TimesCell.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//   首页抢购板块

#import "Index_TimesCell.h"

@implementation Index_TimesCell{
    dispatch_source_t _timer;
    dispatch_source_t _timer1;
    NSString *time1;
    NSString *start1;
}
- (IBAction)moreAction:(UIButton *)sender {
    self.more();
}
-(void)bindData:(NSArray *)data{
    self.showLab1.text = @"限时抢租";
    [self.time_Lab LabelWithIconStr:@"\U0000e8a9" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:PRICECOLOR andiconSize:15];
    [self.more_Lab LabelWithIconStr:@"\U0000e63c" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    [self.more_Btn setTitle:@"更多" forState:UIControlStateNormal];
//    time1 = data[i][@"end_time"];
//    start1 = data[i][@"now_time"];
    CGFloat widths = screen_width/2;
    CGFloat item_Height = 255+30;
    for(int i =0;i<data.count;i++){
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(i%2*widths+i*5, 100*(i/2)+30, widths-5, item_Height)];
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widths, 128)];
        NSString *url = data[i][@"original_img"];
        images.contentMode = UIViewContentModeScaleAspectFit;
//        [images setContentScaleFactor:[[UIScreen mainScreen] scale]];
//        images.contentMode =  UIViewContentModeScaleAspectFill;
//        images.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        images.clipsToBounds  = YES;
        [ images sd_setImageWithURL:[NSURL URLWithString:url]];
      //  images.image = [UIImage imageNamed:@"112.jpg"];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(8, 134, widths-16, 40)];
        name.text = data[i][@"title"];
        name.numberOfLines = 2;
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = RGB(100, 100, 100);
        name.font = [UIFont systemFontOfSize:14];
        
        UILabel *chart = [[UILabel alloc]initWithFrame:CGRectMake(8, 174,widths-16 , 18)];
        chart.text = [NSString stringWithFormat:@"原价：%@/月",data[i][@"shop_price"]] ;
        chart.textAlignment = NSTextAlignmentCenter;
       // chart.backgroundColor = RGB(94, 125, 250);
        chart.font = [UIFont systemFontOfSize:12];
        chart.textColor =RGB(150, 150, 150);
        
        
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(8, 195, widths-16, 30)];
        price.textColor = PRICECOLOR;
        price.font = [UIFont systemFontOfSize:14];
        price.text = [NSString stringWithFormat:@"抢租价：%@/月",data[i][@"price"]];
        price.textAlignment = NSTextAlignmentCenter;
        
        [item addSubview:images];
        [item addSubview:name];
        [item addSubview:chart];
        [item addSubview:price];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, widths, item_Height);
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [item addSubview:btn];
        
        UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 235, widths, 40)];
        timeView.backgroundColor = RGB(89, 121, 208);
        [item addSubview:timeView];
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 50, 40)];
        lab1.textAlignment = NSTextAlignmentLeft;
        lab1.textColor = [UIColor whiteColor];
        lab1.text = @"倒计时：";
        lab1.font = [UIFont systemFontOfSize:12];
        [timeView addSubview:lab1];
        
        UILabel*day = [[UILabel alloc]initWithFrame:CGRectMake(58, 15, 24, 21)];
        day.font = [UIFont systemFontOfSize:12];
        
        UILabel *hour = [[UILabel alloc]initWithFrame:CGRectMake(83, 15, 24, 21)];
        hour.font = [UIFont systemFontOfSize:12];
        
        UILabel *minuteLab= [[UILabel alloc]initWithFrame:CGRectMake(108, 15, 24, 21)];
        minuteLab.font = [UIFont systemFontOfSize:12];
        
        UILabel *secondLab = [[UILabel alloc]initWithFrame:CGRectMake(133, 15, 24, 21)];
        secondLab.font = [UIFont systemFontOfSize:12];

        
        [timeView addSubview:hour];
         [timeView addSubview:day];
         [timeView addSubview:minuteLab];
         [timeView addSubview:secondLab];

        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        //    NSDate *endDate = [dateFormatter dateFromString:[self getyyyymmdd]];
        //    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate] + 24*3600)];
        NSString *endtime = data[i][@"end_time"];
        NSDate *endDate_tomorrow =[self getyyyymmdd:endtime];
        NSString *startss = [self getNowTimeTimestamp];
        NSDate *startDate = [self getyyyymmdd:startss];
        NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
        
        // if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        if(i==0){
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
                        day.text = @"";
                        hour.text = @"00";
                        minuteLab.text = @"00";
                        secondLab.text = @"00";
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    NSLog(@"天数计算===%d",days);
                    if (days==0) {
                        day.text = @"0天";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayLabel.text = @"0天";
                        }else{
                            day.text = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            hour.text = [NSString stringWithFormat:@"0%d",hours];
                        }else{
                           hour.text = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            minuteLab.text = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            minuteLab.text = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            secondLab.text = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            secondLab.text = [NSString stringWithFormat:@"%d",second];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
        }else{
        
            if (timeout!=0) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                
                _timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                
                dispatch_source_set_timer(_timer1,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout<=0){ //倒计时结束，关闭
                        if(start1)
                        {
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"timeoutss" object:nil userInfo:nil];
                        }
                        dispatch_source_cancel(_timer1);
                        _timer1 = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            day.text = @"";
                            hour.text = @"00";
                            minuteLab.text = @"00";
                            secondLab.text = @"00";
                        });
                    }else{
                        int days = (int)(timeout/(3600*24));
                        NSLog(@"天数计算===%d",days);
                        if (days==0) {
                            day.text = @"0天";
                        }
                        int hours = (int)((timeout-days*24*3600)/3600);
                        int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                        int second = timeout-days*24*3600-hours*3600-minute*60;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (days==0) {
                                self.dayLabel.text = @"0天";
                            }else{
                                day.text = [NSString stringWithFormat:@"%d天",days];
                            }
                            if (hours<10) {
                                hour.text = [NSString stringWithFormat:@"0%d",hours];
                            }else{
                                hour.text = [NSString stringWithFormat:@"%d",hours];
                            }
                            if (minute<10) {
                                minuteLab.text = [NSString stringWithFormat:@"0%d",minute];
                            }else{
                                minuteLab.text = [NSString stringWithFormat:@"%d",minute];
                            }
                            if (second<10) {
                                secondLab.text = [NSString stringWithFormat:@"0%d",second];
                            }else{
                                secondLab.text = [NSString stringWithFormat:@"%d",second];
                            }
                            
                        });
                        timeout--;
                    }
                });
                dispatch_resume(_timer1);
            }
            
            
        }

        
        
        [self addSubview:item];
        
    }

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

-(void)click:(UIButton * )sender{
    self.clickitem(sender.tag);
}
- (void)awakeFromNib {
    [super awakeFromNib];
  
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//    CGFloat widths = screen_width/2;
//    CGFloat item_Height = 100;
//    for(int i =0;i<4;i++){
//        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(i%2*widths, 100*(i/2)+20, widths, item_Height)];
//        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 60, 60)];
//        images.image = [UIImage imageNamed:@"112.jpg"];
//        
//        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, widths-80, 44)];
//        name.text = @"佳能EOS 8000";
//        name.numberOfLines = 2;
//        name.font = [UIFont systemFontOfSize:14];
//        
//        UILabel *chart = [[UILabel alloc]initWithFrame:CGRectMake(80, 60, 30, 18)];
//        chart.text = @"限时";
//        chart.textAlignment = NSTextAlignmentCenter;
//        chart.backgroundColor = RGB(94, 125, 250);
//        chart.font = [UIFont systemFontOfSize:11];
//        chart.textColor = [UIColor whiteColor];
//        
//        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(80, 80, widths-80, 30)];
//        price.textColor = PRICECOLOR;
//        price.font = [UIFont systemFontOfSize:14];
//        price.text = @"¥15/天";
//        
//        [item addSubview:images];
//        [item addSubview:name];
//        [item addSubview:chart];
//        [item addSubview:price];
//        [self addSubview:item];
//    
//    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
