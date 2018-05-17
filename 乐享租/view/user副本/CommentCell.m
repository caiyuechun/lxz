//
//  CommentCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "CommentCell.h"
#import "CommentGoodModel.h"
#import "SJPhotoPicker.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageScro.showsHorizontalScrollIndicator = 0;
    self.commentTv.delegate = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    
    self.ship_Btn.layer.cornerRadius = 15;
    self.ship_Btn.layer.masksToBounds = 1;
    
    self.commentBtn.layer.cornerRadius = 15;
    self.commentBtn.layer.masksToBounds = 1;
}
-(void)bindModel:(CommentGoodModel *)model
{
    self.model = model;
    NSString *url_str = model.image;
    //NSString *url_str = [NSString stringWithFormat:@"%@%@",BASE_SERVICE,model.image];
    [self.image sd_setImageWithURL:[NSURL URLWithString:url_str]];
    
    self.name.text = model.name;
    self.spec.text = model.spec;
    self.commentTv.text = model.comment;
    if(![self.commentTv.text isEqualToString:@""])
    {
         [self.placeLb removeFromSuperview];
    }
    //model.comment = self.commentTv.text;
    if(model.imageArr.count>0)
    {
        self.imageScro.contentSize = CGSizeMake(90*(model.imageArr.count+1), 103);
        for(int i =0;i<model.imageArr.count;i++)
        {
            UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(90*i+10*(i+1), 6, 90, 90)];
            images.image = model.imageArr[i];
            [self.imageScro addSubview:images];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(90*i+10*(i+1), 6, 90, 90);
            [self.imageScro addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(checkImage:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.placeLb removeFromSuperview];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.model.comment = textView.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)checkImage:(UIButton *)btn
{
    self.checkImage(btn.tag);
}
//添加图片
- (IBAction)addPhotos:(UIButton *)sender {
    self.addphoto();
}
- (IBAction)commit:(UIButton *)sender {
    self.model.comment = self.commentTv.text;
    self.commit(self.model);
}
//填写快递单号
- (IBAction)writeShip:(UIButton *)sender {
    self.writeships();
}
@end
