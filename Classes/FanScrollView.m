//
//  CRRobotListView.m
//  Brain
//
//  Created by 向阳凡 on 2018/7/28.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

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
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */



#pragma mark - scrollView delegate 生命周期
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"willBeginDragging----1");
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"didScroll-----2");
//}
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSLog(@"willEndDragging----3");
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"didEndDragging----4");
//}
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"willBeginDecelerating----5->2");
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"didEndDecelerating----6");
//}
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSLog(@"didEndSrolling");
//}
//
//-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
//    NSLog(@"didTop");
//}
//-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
//    NSLog(@"willBegigZooming");
//}
//
//-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    NSLog(@"didZoom");
//}
//-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
//    NSLog(@"didEndZooming");
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
