# FanListView

### 实现列表的滚动缩放，本文介绍两种方式布局，一个UIScrollView，一个UICollectionView.（如图GIF）

![动画](https://github.com/fanxiangyang/FanListView/blob/master/Document/listDemo.gif?raw=true)


### 效果图片（PNG）

<img src="https://github.com/fanxiangyang/FanListView/blob/master/Document/p1.png?raw=true" width="1024">   
  
<img src="https://github.com/fanxiangyang/FanListView/blob/master/Document/p2.png?raw=true" width="1024">


###  功能介绍

##### 1.UIScrollView实现滚动缩放 
```
#import "FanScrollView.h"

@implementation FanScrollView
{
    CGFloat listWidth,listHeight,cellWidth;
    CGFloat allScal,scalWidth;
    NSInteger scalCount;//中间点的左右可见个数，比如一个显示5个，可见个数是3，越大越好，不能太大
}
-(instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray{
    self=[super initWithFrame:frame];
    if (self) {
        self.imageArray=[imageArray mutableCopy];
        listWidth=frame.size.width;
        listHeight=frame.size.height;
        cellWidth=(listHeight*165.0f)/220.0f;
        allScal=0.8f;
        scalWidth=cellWidth*1.0f;
        scalCount=3;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    _currentPage=0;
    
    _backgroundScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, listWidth, listHeight)];
//    _backgroundScrollView.bounces = NO;
    //    _backgroundScrollView.pagingEnabled = YES;//因为分页是半页或者自定义宽度，故不启用
    _backgroundScrollView.delegate = self;
    _backgroundScrollView.userInteractionEnabled = YES;
    _backgroundScrollView.showsHorizontalScrollIndicator = NO;
    _backgroundScrollView.showsVerticalScrollIndicator = NO;
    [_backgroundScrollView setContentSize:CGSizeMake(scalWidth*self.imageArray.count+listWidth-scalWidth, _backgroundScrollView.frame.size.height)];
    [_backgroundScrollView setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.000]];//加上颜色，让你们看的更清楚
    [self addSubview:_backgroundScrollView];
    
    for (int i=0; i<self.imageArray.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((listWidth-cellWidth)/2+i*scalWidth, 0, cellWidth, listHeight)];
        imageView.backgroundColor=[UIColor whiteColor];
        imageView.image=[UIImage imageNamed:self.imageArray[i]];
        imageView.layer.borderWidth=2;
        imageView.layer.borderColor=[UIColor purpleColor].CGColor;
        imageView.layer.cornerRadius=10;
        imageView.clipsToBounds=YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self.backgroundScrollView addSubview:imageView];
        [self.imageViewArray addObject:imageView];
        if (i<=scalCount) {
            imageView.transform= CGAffineTransformScale(CGAffineTransformIdentity, powf(allScal, i) ,powf(allScal, i));
        }else{
            imageView.transform= CGAffineTransformScale(CGAffineTransformIdentity, powf(allScal, scalCount) ,powf(allScal, scalCount));
        }
    }
    
}
#pragma mark - 时时滚动缩放
-(void)scaleImageArrayIndex:(NSInteger)index scale:(CGFloat)scale leftScrool:(BOOL)leftScrool{
    
    if (leftScrool) {
        //往左滑动时
        if (index>=self.imageViewArray.count||index<0) {
            return;
        }
        UIImageView *imageView=(UIImageView *)self.imageViewArray[index];
        CGFloat scalXY=1-(scale*(1-allScal));
        imageView.transform =CGAffineTransformScale(CGAffineTransformIdentity, scalXY, scalXY);
        for (int i=0; i<scalCount; i++) {
            //放大的右边2个可见个数（scalCount）
            NSInteger currentIndex=index+i+1;
            if (currentIndex>=self.imageViewArray.count||currentIndex<0) {
                //                return;
            }else{
                UIImageView *imageView1=(UIImageView *)self.imageViewArray[currentIndex];
                CGFloat scalXY=(allScal+(scale*0.2))*powf(allScal, i);
                imageView1.transform= CGAffineTransformScale(CGAffineTransformIdentity,scalXY ,scalXY);
            }
            //缩小的左边两个
            NSInteger currentIndex2=index-i-1;
            if (currentIndex2>=self.imageViewArray.count||currentIndex2<0) {
                //                return;
            }else{
                UIImageView *imageView2=(UIImageView *)self.imageViewArray[currentIndex2];
                CGFloat scalXY2=allScal*((1-scale*(1-allScal)))*powf(allScal, i);
                imageView2.transform= CGAffineTransformScale(CGAffineTransformIdentity,scalXY2 ,scalXY2);
                
            }
            
            
        }
        
    }else{
        if (scale<0) {
            //处理最左边时，滑动缩放异常
            return;
        }
        if (index+1>=self.imageViewArray.count||index+1<0) {
            return;
        }
        UIImageView *imageView=(UIImageView *)self.imageViewArray[index+1];
        CGFloat scalXY=allScal+scale*(1-allScal);
        imageView.transform =CGAffineTransformScale(CGAffineTransformIdentity, scalXY, scalXY);
        
        for (int i=0; i<scalCount; i++) {
            //放大的左边2个
            NSInteger currentIndex=index-i;
            if (currentIndex>=self.imageViewArray.count||currentIndex<0) {
                //                return;
            }else{
                UIImageView *imageView1=(UIImageView *)self.imageViewArray[currentIndex];
                CGFloat scalXY=(1-scale*(1-allScal))*powf(allScal, i);
                imageView1.transform= CGAffineTransformScale(CGAffineTransformIdentity,scalXY ,scalXY);
             
            }
            //缩小的右边两个
            NSInteger currentIndex2=index+i+2;
            if (currentIndex2>=self.imageViewArray.count||currentIndex2<0) {
                //                return;
            }else{
                UIImageView *imageView2=(UIImageView *)self.imageViewArray[currentIndex2];
                CGFloat scalXY2=allScal*((allScal+scale*(1-allScal)))*powf(allScal, i);
              
                imageView2.transform= CGAffineTransformScale(CGAffineTransformIdentity,scalXY2 ,scalXY2);
            }
        }
    }
    
}
//滚动接收后刷新Frame
-(void)refreshScaleImageViewWithNOScaleIndex:(NSInteger)noScaleIndex{
    UIImageView *imageView=(UIImageView *)self.imageViewArray[noScaleIndex];
    imageView.transform= CGAffineTransformScale(CGAffineTransformIdentity, 1.0,1.0);
    for (int i=0; i<scalCount; i++) {
        NSInteger currentIndex=noScaleIndex+i+1;
        if (currentIndex>=self.imageViewArray.count||currentIndex<0) {
            //return;
        }else{
            //右边+的View
            UIImageView *imageView1=(UIImageView *)self.imageViewArray[currentIndex];
       
            imageView1.transform= CGAffineTransformScale(CGAffineTransformIdentity, powf(allScal, i+1) ,powf(allScal, i+1));
            
        }
        NSInteger currentIndex2=noScaleIndex-i-1;
        if (currentIndex2>=self.imageViewArray.count||currentIndex2<0) {
            //return;
        }else{
            //左边的
            UIImageView *imageView2=(UIImageView *)self.imageViewArray[currentIndex2];
       
            imageView2.transform= CGAffineTransformScale(CGAffineTransformIdentity, powf(allScal, i+1) ,powf(allScal, i+1));
        }
    }
    
}

static BOOL onlyOnePage=NO;//是否允许每次只翻一页
#pragma mark - UIScrollViewDelegate
//该方法是拖拽将要停止时，不能放在已经停止里面（控制自定义翻页宽度和页面）
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    //MARK: 允许一下翻多页
    //targetContentOffset 滚动偏移量，左右回弹时是0
    CGFloat x = targetContentOffset->x;
    CGFloat pageWidth = scalWidth;//定义每页宽度，翻页时按照此规则来执行
    CGFloat movedX = x - pageWidth * _currentPage;
    //计算偏移量是否在-0.5<x<0.5之间，超过了才翻页,超过0.5-1.5 1.5-2.5
    if (movedX < -pageWidth * 0.5) {
        // Move left
        if (onlyOnePage) {
            _currentPage--;
        }else{
            _currentPage-=(int)ABS((movedX+pageWidth*0.5)/pageWidth)+1;//绝对值取整
        }
    } else if (movedX > pageWidth * 0.5) {
        // Move right
        if (onlyOnePage) {
            _currentPage++;
        }else{
            _currentPage+=(int)ABS((movedX-pageWidth*0.5)/pageWidth)+1;
        }
        
    }
    //滑动的加速度 ABS取绝对值，不取整
    if (ABS(velocity.x) >= 2.0f){
        targetContentOffset->x = pageWidth * _currentPage;
    } else {
        targetContentOffset->x = scrollView.contentOffset.x;
        [scrollView setContentOffset:CGPointMake(pageWidth * _currentPage, scrollView.contentOffset.y) animated:YES];
    }
//    NSLog(@"将要停止页面：%ld   页面宽度：%f",_currentPage,pageWidth);
}
#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint scOffset=scrollView.contentOffset;
    NSInteger page=scOffset.x/(scalWidth);
//    NSLog(@"时时滑动:%f   当前页:%ld",scOffset.x ,page);

    CGFloat scale=((scOffset.x-page*scalWidth)/(scalWidth));
    if (scOffset.x>_currentPage*scalWidth) {//必须用_currentPage
        //往左滚动 缩放从0-1
        [self scaleImageArrayIndex:page scale:scale leftScrool:YES];
    }else{
        //往右滚动 缩放从1-0
        [self scaleImageArrayIndex:page scale:scale leftScrool:NO];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //停止滑动时，刷新控件位置
    [self refreshScaleImageViewWithNOScaleIndex:_currentPage];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //停止滚动时，刷新控件位置
    [self refreshScaleImageViewWithNOScaleIndex:_currentPage];
}
#pragma mark - get set
-(void)setImageArray:(NSArray *)imageArray{
    if (self.imageArray!=imageArray) {
        _imageArray=nil;
    }
    _imageArray=[imageArray mutableCopy];
}
-(NSMutableArray *)imageViewArray{
    if (_imageViewArray==nil) {
        _imageViewArray=[[NSMutableArray alloc]init];
    }
    return _imageViewArray;
}
@end
```
##### 2.UICollectionView实现重叠缩放滚动翻页
```
/*
    用来布局缩放重叠的库（参考：https://github.com/Tuberose621/-CollectionViewLayout-CollectionViewFlowLayout-）
 *  在这个库的基础上修改部分的
 *
 *
 *
 */


#import <UIKit/UIKit.h>

@interface FanScalCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger page;//当前居中的页码
//@property (nonatomic, assign) BOOL isScal;//是否缩放，默认yes
@property (nonatomic, assign) BOOL isOverlap;//是否重叠，默认YES

@end


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
            //必须四舍五入，处理有不到1个像素的误差
            attrs.zIndex=(NSInteger)roundf(-ABS(centerX-attrs.center.x)/self.itemSize.width);
            //这里一个重点就是距离远近是一个曲线函数，我用平方，刚好差不多，实际项目如果展示更多个的话们可以修改这个函数
            attrs.center=CGPointMake(attrs.center.x-zf*(1-scale)*self.itemSize.width*powf(1+(1-scale), 2), attrs.center.y);
          
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



``` 
#### 3.scrollView滚动就是一个缩放的计算，不过有个方法，可以自定义翻页宽度,感觉很不错
```
static BOOL onlyOnePage=NO;//是否允许每次只翻一页
#pragma mark - UIScrollViewDelegate
//该方法是拖拽将要停止时，不能放在已经停止里面（控制自定义翻页宽度和页面）
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    //MARK: 允许一下翻多页
    //targetContentOffset 滚动偏移量，左右回弹时是0
    CGFloat x = targetContentOffset->x;
    CGFloat pageWidth = scalWidth;//定义每页宽度，翻页时按照此规则来执行
    CGFloat movedX = x - pageWidth * _currentPage;
    //计算偏移量是否在-0.5<x<0.5之间，超过了才翻页,超过0.5-1.5 1.5-2.5
    if (movedX < -pageWidth * 0.5) {
        // Move left
        if (onlyOnePage) {
            _currentPage--;
        }else{
            _currentPage-=(int)ABS((movedX+pageWidth*0.5)/pageWidth)+1;//绝对值取整
        }
    } else if (movedX > pageWidth * 0.5) {
        // Move right
        if (onlyOnePage) {
            _currentPage++;
        }else{
            _currentPage+=(int)ABS((movedX-pageWidth*0.5)/pageWidth)+1;
        }
        
    }
    //滑动的加速度 ABS取绝对值，不取整
    if (ABS(velocity.x) >= 2.0f){
        targetContentOffset->x = pageWidth * _currentPage;
    } else {
        targetContentOffset->x = scrollView.contentOffset.x;
        [scrollView setContentOffset:CGPointMake(pageWidth * _currentPage, scrollView.contentOffset.y) animated:YES];
    }
//    NSLog(@"将要停止页面：%ld   页面宽度：%f",_currentPage,pageWidth);
}

```

Like(喜欢)
==============
#### 有问题请直接在文章下面留言,喜欢就给个Star(小星星)吧！ 
#### Email:<fqsyfan@gmail.com>
#### Email:fanxiangyang_heda@163.com<fanxiangyang_heda@163.com>

