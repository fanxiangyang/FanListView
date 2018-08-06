//
//  CRRobotFlowLayout.m
//  Brain
//
//  Created by 向阳凡 on 2018/8/1.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

#import "FanScalCollectionViewFlowLayout.h"

@implementation FanScalCollectionViewFlowLayout
- (instancetype)init
{
    if (self = [super init]) {
//        _isScal=YES;
        _isOverlap=YES;
    }
    return self;
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 */
- (void)prepareLayout
{
    [super prepareLayout];
    //    self.visibleCount = 7;
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

/**
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 */
/**
 * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //增加可见区域，处理移动位置，造成循环创建时闪现
    rect.size.width+=self.collectionView.frame.size.width;
    rect.origin.x-=self.collectionView.frame.size.width * 0.5;
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect] ;
    // 计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //获取当前页码
    //    NSInteger currentPage=self.collectionView.contentOffset.x/self.itemSize.width;
    //    NSLog(@"page:%ld   ===   %f",currentPage, centerX);
    
    // 在原有布局属性的基础上，进行微调
    for (int i=0; i<array.count; i++) {
        UICollectionViewLayoutAttributes *attrs=array[i];
        // cell的中心点x 和 collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attrs.center.x - centerX);
        CGFloat zf=1.0f;
        if (attrs.center.x - centerX<0) {
            zf*=-1.0f;
        }
        // 根据间距值 计算 cell的缩放比例(这个是根据cell离中心点距离多少然后处理缩放倍数)
        CGFloat scale = 1 - (delta/self.collectionView.frame.size.width)/2.0;
//        NSLog(@"%f",scale);
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        if (_isOverlap) {
            //这里一个重点就是距离远近是一个曲线函数，我用平方，刚好差不多，实际项目如果展示更多个的话们可以修改这个函数
            attrs.center=CGPointMake(attrs.center.x-zf*(1-scale)*self.itemSize.width*powf(1+(1-scale), 2), attrs.center.y);
            //必须四舍五入，处理有不到1个像素的误差
            attrs.zIndex=(NSInteger)roundf(-ABS(centerX-attrs.center.x)/self.itemSize.width);
        }
        
    }
    return array;
}

/**
 * 这个方法需要返回indexPath位置对应cell的布局属性,(好像添加cell时会调用这个方法,不过加入zIndex后，影响动画效果)
 */
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
////    attrs.zIndex=-1;
//    return attrs;
//}


/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    //proposedContentOffset滑动偏移量
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    //    UICollectionViewLayoutAttributes *attrs=array[0];
    //    NSLog(@"%f=======%f======%f",proposedContentOffset.x,attrs.center.x,self.collectionView.frame.size.width * 0.5);
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        //        NSLog(@"1111111：%f",attrs.center.x);
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            //            NSLog(@"=%f========：%f",attrs.center.x,ABS(attrs.center.x - centerX));
            //如果宽度150，大于75时，会恢复到第二个cell
            minDelta = attrs.center.x - centerX;
            //            NSLog(@"--------：%f",minDelta);
        }
    }
    // 修改原有的偏移量 停止滚动时，滚动的偏移量再减回去，恢复到一个居中的状态
    proposedContentOffset.x += minDelta;
    //四舍五入解决小数点误差问题
    _page=(NSInteger)roundf(proposedContentOffset.x/self.itemSize.width);
//    NSLog(@"结束滑动时：%ld   ==   %f",_page, proposedContentOffset.x);
    return proposedContentOffset;
}

@end
