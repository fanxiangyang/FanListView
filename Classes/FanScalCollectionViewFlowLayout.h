//
//  CRRobotFlowLayout.h
//  Brain
//
//  Created by 向阳凡 on 2018/8/1.
//  Copyright © 2018年 向阳凡. All rights reserved.
//



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
