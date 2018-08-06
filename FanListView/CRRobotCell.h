//
//  CRRobotCell.h
//  Brain
//
//  Created by 向阳凡 on 2018/7/30.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

#import <UIKit/UIKit.h>

//颜色
#define FanColor(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//本地化
#define FanLocalizedString(key) NSLocalizedString(key, @"")
#define FanLocalizedStringFromTable(key,tbl) NSLocalizedStringFromTable(key, tbl, @"")

//自定义字体
#define FanSystemFontOfSize(fontSize) [UIFont systemFontOfSize:fontSize]
#define FanBoldSystemFontOfSize(fontSize) [UIFont boldSystemFontOfSize:fontSize]

#define FanCustomFontOfSize(fontName,fontSize) [UIFont fontWithName:fontName size:fontSize]


#define ThemeColor        [UIColor colorWithRed:0/255.0 green:160/255.0 blue:232/255.0 alpha:1]  //主题色
#define ThemeBackColor    [UIColor colorWithRed:191/255.0f green:202/255.0f blue:239/255.0f alpha:1]  //有色背景色
#define ThemeTextColor    [UIColor colorWithRed:120/255.0 green:124/255.0 blue:176/255.0 alpha:1] //主题有色文字
#define CRTextColor       [UIColor whiteColor] //白色
#define ThemeContentColor    [UIColor colorWithRed:109/255.0f green:113/255.0f blue:167/255.0f alpha:1]  //内容框主题背景色
#define ThemeGradientStartColor    [UIColor colorWithRed:125.0/255.0f green:160.0/255.0f blue:205.0/255.0f alpha:1]  //主题渐变开始背景色
#define ThemeGradientEndColor    [UIColor colorWithRed:102.0/255.0f green:111.0/255.0f blue:183.0/255.0f alpha:1]  //主题渐变结束背景色


@class CRRobotCell;

@protocol CRRobotCellDelegate<NSObject>

@optional
//0-编辑  1-复制 2-重命名 3-删除 4- 完成
-(void)robotCell:(CRRobotCell *)cell buttonIndex:(NSInteger)buttonIndex indexPath:(NSIndexPath *)indexPath;

@end


@interface CRRobotCell : UICollectionViewCell<UIGestureRecognizerDelegate>
//@property(nonatomic,copy)void(^block)(void);

@property(nonatomic,strong)UIView *bgAlphaView;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIImageView *robotImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *editeButton;

@property(nonatomic,weak)id<CRRobotCellDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;


-(void)newCreateCellUI;

-(void)cancleEditeView;

-(void)showEditeView;


@end
