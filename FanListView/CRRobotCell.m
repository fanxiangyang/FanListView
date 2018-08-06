//
//  CRRobotCell.m
//  Brain
//
//  Created by 向阳凡 on 2018/7/30.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

#import "CRRobotCell.h"
#import "FanDrawLayer.h"
#import "FanUIKit.h"

@interface CRRobotCell ()

@property(nonatomic,strong)UIView *editeView;

@end

@implementation CRRobotCell{
    CGFloat crWidth,crHeight;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        crWidth=self.frame.size.width;
        crHeight=self.frame.size.height;
        [self configUI];
    }
    return self;
}

-(void)configUI{
//    self.backgroundColor=[UIColor clearColor];
//    self.contentView.backgroundColor=[UIColor clearColor];
    
//    _bgAlphaView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, crWidth, crHeight)];
//    //    _bgAlphaView.backgroundColor=[UIColor redColor];
//    [self.contentView addSubview:_bgAlphaView];
//    _bgAlphaView.layer.shadowColor =CRTextColor.CGColor;// FanColor(120, 124, 176, 1).CGColor;//阴影颜色
//    _bgAlphaView.layer.shadowOpacity = 0.5;//阴影透明度，默认为0，如果不设置的话看不到阴影，切记，这是个大坑
//    _bgAlphaView.layer.shadowRadius=5;
//    //参数依次为大小，设置四个角圆角状态，圆角曲度
//    _bgAlphaView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_bgAlphaView.bounds byRoundingCorners:5 cornerRadii:CGSizeMake(0, 0)].CGPath;
    
    
    _bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, crWidth, crHeight)];
    //    [_bgImageView.layer addSublayer:[FanDrawLayer fan_gradientLayerFrame:CGRectMake(0, 0, crWidth, crHeight) startColor:CRTextColor endColor:FanColor(200, 215, 255, 1) isVertical:YES locations:@[@(0.1),@(1.0)]]];
    
    
    //    [_bgImageView.layer addSublayer:[FanDrawLayer fan_gradientLayerFrame:CGRectMake(0, 0, crWidth, crHeight) startColor:FanColor(191, 191, 198, 1) endColor:FanColor(73, 93, 120, 1) isVertical:YES locations:@[@(0.1),@(1.0)]]];
    
    [_bgImageView.layer addSublayer:[FanDrawLayer fan_gradientLayerFrame:CGRectMake(0, 0, crWidth, crHeight) startColor:FanColor(255, 255, 255, 0.6) endColor:FanColor(255, 255, 255, 0) isVertical:YES locations:@[@(0.1),@(1.0)]]];
    
    _bgImageView.clipsToBounds=YES;
    _bgImageView.layer.cornerRadius=10;
    [self.contentView addSubview:_bgImageView];
    //添加毛玻璃效果
    [FanUIKit fan_addBlurEffectToView:_bgImageView];
    
    
    
    
    
    
    _robotImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, crWidth-20, crWidth-20)];
//    _robotImageView.backgroundColor=[UIColor darkGrayColor];
    _robotImageView.clipsToBounds=YES;
    _robotImageView.contentMode=UIViewContentModeScaleAspectFill;
//    _robotImageView.layer.cornerRadius=10;
    [self.contentView addSubview:_robotImageView];
    
    CGFloat h=crHeight-crWidth;
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, crWidth-5, crWidth-20, h/2.0f)];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.adjustsFontSizeToFitWidth=YES;
    _nameLabel.font=FanSystemFontOfSize(15);
    _nameLabel.textColor=CRTextColor;
    _nameLabel.text=@"NO.1 风景";
    [self.contentView addSubview:_nameLabel];
    
    _editeButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_editeButton setFrame:CGRectMake(crWidth*0.3, crWidth+h/2.0f, crWidth*0.4, 16)];
    _editeButton.backgroundColor=CRTextColor;
    _editeButton.titleLabel.font=FanSystemFontOfSize(12);
    [_editeButton setTitleColor:ThemeTextColor forState:UIControlStateNormal];
    [_editeButton setTitle:@"编辑" forState:UIControlStateNormal];
    _editeButton.layer.cornerRadius=8;
    [_editeButton addTarget:self action:@selector(editeCard) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_editeButton];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(crWidth*0.3, crWidth+h/2.0f-20, crWidth*0.4, 16+20)];
    control.backgroundColor=[UIColor clearColor];
    [control addTarget:self action:@selector(editeCard) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:control];
    
    
    
}
-(void)newCreateCellUI{
    _nameLabel.text=@"新建风景";
    _editeButton.hidden=YES;
    CGFloat h=crHeight-crWidth;
    UILabel *tipLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, crWidth+h/2.0f, crWidth-10, 17)];
    tipLabel.textAlignment=NSTextAlignmentCenter;
    tipLabel.font=FanSystemFontOfSize(12);
    tipLabel.textColor=FanColor(255, 255, 255, 0.5);
    tipLabel.text=@"创建自己的新风景";
    [self.contentView addSubview:tipLabel];
}
-(UIView*)editeView{
    if (_editeView==nil) {
        _editeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, crWidth, crHeight)];
        //        [_editeView.layer addSublayer:[FanDrawLayer fan_gradientLayerFrame:CGRectMake(0, 0, crWidth, crHeight) startColor:FanColor(255, 255, 255, 1) endColor:FanColor(255, 255, 255, 0) isVertical:YES locations:@[@(0.1),@(1.0)]]];
        //        _editeView.alpha=0.8;
        //        _editeView.clipsToBounds=YES;
        //        _editeView.layer.cornerRadius=10;
        [self.contentView addSubview:_editeView];
        
        UIView *_editeView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, crWidth, crHeight)];
        [_editeView1.layer addSublayer:[FanDrawLayer fan_gradientLayerFrame:CGRectMake(0, 0, crWidth, crHeight) startColor:FanColor(255, 255, 255, 0.9) endColor:FanColor(255, 255, 255, 0) isVertical:YES locations:@[@(0.6),@(0.8)]]];
        _editeView1.alpha=1;
        _editeView1.clipsToBounds=YES;
        _editeView1.layer.cornerRadius=10;
        [_editeView addSubview:_editeView1];
        
        
        UIButton *cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [cancleBtn setFrame:CGRectMake(crWidth-13-17, 13-13, 17+13, 17+13)];
        [cancleBtn setImage:[UIImage imageNamed:@"cr_py_cancle"] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        cancleBtn.imageEdgeInsets=UIEdgeInsetsMake(13, 0, 0, 13);
        [_editeView addSubview:cancleBtn];
        
        UIButton *copyBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [copyBtn setFrame:CGRectMake(24, crWidth*0.3, 60, 20)];
        [copyBtn setBackgroundImage:[UIImage imageNamed:@"cr_py_right_pop"] forState:UIControlStateNormal];
//        copyBtn.backgroundColor=ThemeTextColor;
        copyBtn.titleLabel.font=FanSystemFontOfSize(12);
        [copyBtn setTitleColor:CRTextColor forState:UIControlStateNormal];
        [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
        copyBtn.layer.cornerRadius=5;
        [copyBtn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
        [_editeView addSubview:copyBtn];
        
        UIButton *copyBtn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [copyBtn1 setFrame:CGRectMake(crWidth-24-56, crWidth*0.6, 60, 20)];
//        copyBtn1.backgroundColor=ThemeTextColor;
        [copyBtn1 setBackgroundImage:[UIImage imageNamed:@"cr_py_left_pop"] forState:UIControlStateNormal];
        copyBtn1.titleLabel.font=FanSystemFontOfSize(12);
        [copyBtn1 setTitleColor:CRTextColor forState:UIControlStateNormal];
        [copyBtn1 setTitle:@"重命名" forState:UIControlStateNormal];
        copyBtn1.layer.cornerRadius=5;
        [copyBtn1 addTarget:self action:@selector(copyClick1) forControlEvents:UIControlEventTouchUpInside];
        [_editeView addSubview:copyBtn1];
        
        CGFloat h=crHeight-crWidth;
        UIButton *eBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [eBtn setFrame:CGRectMake(crWidth*0.3, crWidth+h/2.0f, crWidth*0.4, 16)];
        eBtn.backgroundColor=CRTextColor;
        eBtn.titleLabel.font=FanSystemFontOfSize(12);
        [eBtn setTitleColor:FanColor(255, 139, 139, 1) forState:UIControlStateNormal];
        [eBtn setTitle:@"完成" forState:UIControlStateNormal];
        eBtn.layer.cornerRadius=8;
        [eBtn addTarget:self action:@selector(eClick) forControlEvents:UIControlEventTouchUpInside];
        [_editeView addSubview:eBtn];
        
        UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(crWidth*0.3, crWidth+h/2.0f-20, crWidth*0.4, 16+20)];
        control.backgroundColor=[UIColor clearColor];
        [control addTarget:self action:@selector(eClick) forControlEvents:UIControlEventTouchUpInside];
        [_editeView addSubview:control];
    }
    return _editeView;
}
-(void)cancleEditeView{
    if (_editeView) {
        [_editeView removeFromSuperview];
        _editeView=nil;
    }
}
-(void)editeCard{
    //编辑状态
    //    self.editeView.hidden=NO;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(robotCell:buttonIndex:indexPath:)]) {
        [self.delegate robotCell:self buttonIndex:0 indexPath:self.indexPath];
    }
}
-(void)showEditeView{
    self.editeView.hidden=NO;
}
-(void)cancleClick{
    //删除构型
    if (self.delegate&&[self.delegate respondsToSelector:@selector(robotCell:buttonIndex:indexPath:)]) {
        [self.delegate robotCell:self buttonIndex:3 indexPath:self.indexPath];
    }
}
-(void)copyClick{
    //复制构型
    if (self.delegate&&[self.delegate respondsToSelector:@selector(robotCell:buttonIndex:indexPath:)]) {
        [self.delegate robotCell:self buttonIndex:1 indexPath:self.indexPath];
    }
}
-(void)copyClick1{
    //重命名
    if (self.delegate&&[self.delegate respondsToSelector:@selector(robotCell:buttonIndex:indexPath:)]) {
        [self.delegate robotCell:self buttonIndex:2 indexPath:self.indexPath];
    }
}
-(void)eClick{
    //完成
    [_editeView removeFromSuperview];
    _editeView=nil;
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(robotCell:buttonIndex:indexPath:)]) {
        [self.delegate robotCell:self buttonIndex:4 indexPath:self.indexPath];
    }
}
@end
