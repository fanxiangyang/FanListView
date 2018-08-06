//
//  FanScrollView.h
//  FanListView
//
//  Created by 向阳凡 on 2018/8/3.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

/*
    scrollView滚动列表缩放，每个控件间距固定，只是缩放大小。
 *
 *  1.如果想实现缩放重叠，只有3个图片的情况下，是可以做到的，固定好宽度，改缩放就OK了，如果多了就要改一个曲线（可能x的平方），目前没有改好，换用UICollectionView实现。
 *  2.有个好的小功能就是可以自定义翻页宽度，我感觉很👍
 *  3.本类只是一个大概，核心是布局和缩放，你们可以在这个基础上实现项目中需要的功能
 *
 */

#import <UIKit/UIKit.h>

@interface FanScrollView : UIView<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *backgroundScrollView;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSMutableArray *imageViewArray;
@property(nonatomic,assign)NSInteger currentPage;

-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@end
