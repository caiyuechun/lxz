//
//  AddressCell.m
//  SHOP
//
//  Created by caiyc on 16/12/6.
//  Copyright © 2016年 changce. All rights reserved.
//   地址

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.sepaLable.backgroundColor = viewcontrollerColor;
    self.rowLineLable.backgroundColor = viewcontrollerColor;
    [self.defaultImageLb LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE-5];
    [self.editImageLb LabelWithIconStr:@"\U0000e63b" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE-5];
    [self.deleteImageLb LabelWithIconStr:@"\U0000e7bc" inIcon:iconfont andSize:CGSizeZero andColor:[UIColor grayColor] andiconSize:PAPULARFONTSIZE-5];
    
    //self.backgroundColor = viewcontrollerColor;
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic andIndex:(NSInteger)index
{
 //   NSLog(@"传递数据%@",dic);
//    @{@"name":self.nameTf.text,
//      @"num":self.numTf.text,
//      @"address":self.addressLb.text,
//      @"detail":self.DetailText.text};
    self.defalutBtn.tag = (index+1)*100+1;
    self.editBtn.tag = (index+1)*100+1;
    self.deleteBtn.tag = (index+1)*10000+1;
    self.nameLb.text = [dic objectForKey:@"consignee"];
   // self.addressLb.text = dic[@"address"];
    self.addressLb.text = [NSString stringWithFormat:@"%@%@%@%@",dic[@"provincename"],dic[@"cityname"],dic[@"districtname"],dic[@"address"]];
    self.telephoneLable.text = dic[@"mobile"];
    BOOL isdefault = [dic[@"is_default"]boolValue];
    self.defaultImageLb.textColor = isdefault? [UIColor redColor]:[UIColor grayColor];
  //  [self.editBtns setTitle:@"kdksahf" forState:UIControlStateNormal];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)defaultBtn:(UIButton *)sender
{
    self.defaultAction(sender);
}

- (IBAction)editBtn:(UIButton *)sender {
    self.editAction(sender);
}

- (IBAction)deleteBtn:(UIButton *)sender {
    self.deleteAction(sender);
}
@end
