//
//  FanExapmpleViewController2.m
//  FanListView
//
//  Created by 向阳凡 on 2018/8/6.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

#import "FanExampleViewController2.h"
#import "FanScalCollectionViewFlowLayout.h"
#import "CRRobotCell.h"
#import "FanDrawLayer.h"

#define FanScreenWidth [UIScreen mainScreen].bounds.size.width
#define FanScreenHeight [UIScreen mainScreen].bounds.size.height

@interface FanExampleViewController2 ()<UICollectionViewDelegate,UICollectionViewDataSource,CRRobotCellDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)FanScalCollectionViewFlowLayout *customLayout;
@property(nonatomic,assign)CGFloat collectionHeight;
@property(nonatomic,assign)CGFloat collectionWidth;
@property(nonatomic,assign)BOOL isEdite;//是否处于编辑状态@end

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FanExampleViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.title=@"UICollectionView";

    // Do any additional setup after loading the view.
    self.dataArray = [@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"12.jpg",@"13.jpg",@"14.jpg",@"15.jpg",@"16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg"] mutableCopy];
    _collectionHeight=FanScreenHeight-120-30;
    [self.view.layer addSublayer:[FanDrawLayer fan_gradientLayerFrame:CGRectMake(0, 0, FanScreenWidth, FanScreenHeight) startColor:ThemeGradientStartColor endColor:ThemeGradientEndColor isVertical:YES locations:@[@(0.1),@(1.0)]]];
    [self configUI];

}
-(void)configUI{
    CGFloat top=100;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        top=_collectionHeight*0.25;
        _collectionHeight=_collectionHeight*0.5;
    }
    _collectionWidth=_collectionHeight*165.0f/220.0f;
    _customLayout=[[FanScalCollectionViewFlowLayout alloc]init];
    _customLayout.itemSize = CGSizeMake(_collectionWidth, _collectionHeight);
//    _customLayout.isOverlap=NO;
    
    // 设置滚动方向（默认垂直滚动）
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(30, top-12, FanScreenWidth-60, _collectionHeight+24) collectionViewLayout:_customLayout];
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[CRRobotCell class] forCellWithReuseIdentifier:@"Cell"];
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 0;
//}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataArray.count==0) {
        return 1;
    }else{
        return _dataArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count==0) {
        CRRobotCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        cell.robotImageView.image=[UIImage imageNamed:@"1.jpg"];
        [cell newCreateCellUI];
        return cell;
    }else{
        CRRobotCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        cell.robotImageView.image=[UIImage imageNamed:self.dataArray[indexPath.row]];
        cell.indexPath=indexPath;
        cell.nameLabel.text=[NSString stringWithFormat:@"NO.%ld 风景",indexPath.row+1];
        cell.delegate=self;
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    if (_dataArray.count==0) {
        [self addNewRobot];
    }else{
        //跳转到新构型界面
        if (_customLayout.page==indexPath.row) {
            //跳转下一页
            if (_isEdite) {
                //不能跳转
            }else{
                //    CRMyRobotViewController *rbVC=[[CRMyRobotViewController alloc]init];
                //    [self.navigationController pushViewController:rbVC animated:YES];
            }
        }else{
            CRRobotCell *cell=(CRRobotCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_customLayout.page inSection:0]];
            if (cell) {
                [cell cancleEditeView];
            }
            _isEdite=NO;
            
            
            [collectionView setContentOffset:CGPointMake(_collectionWidth*indexPath.row, 0) animated:YES];
            _customLayout.page=indexPath.row;
        }
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    CRRobotCell *cell=(CRRobotCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_customLayout.page inSection:0]];
    if (cell) {
        [cell cancleEditeView];
    }
    
    _isEdite=NO;
    
}


#pragma mark - CRRobotCellDelegate

-(void)robotCell:(CRRobotCell *)cell buttonIndex:(NSInteger)buttonIndex indexPath:(NSIndexPath *)indexPath{
    //    _selectIndexPath=indexPath;
    switch (buttonIndex) {
        case 0:
        {
            //编辑
            if (_customLayout.page==indexPath.row) {
                //点击中心页面
                [cell showEditeView];
                _isEdite=YES;
            }
            
            
        }
            break;
        case 1:
        {
            //复制
            //            ShowHUDMessage(@"复制成功");
            
            [cell cancleEditeView];
            _isEdite=NO;
            
            [self.dataArray insertObject:@"1.jpg" atIndex:indexPath.row+1];
            [_collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]]];
            __weak FanExampleViewController2 *weakSelf=self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.collectionView setContentOffset:CGPointMake(weakSelf.collectionWidth*(indexPath.row+1), 0) animated:YES];
                weakSelf.customLayout.page=indexPath.row+1;
            });
            
            
        }
            break;
        case 2:
        {
            //重命名
        }
            break;
        case 3:
        {
            //删除
            [cell cancleEditeView];
            _isEdite=NO;
            
            [self.dataArray removeObjectAtIndex:indexPath.row];
            if (self.dataArray.count==0) {
                [self.collectionView reloadData];
                return;
            }
            [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]]];
            
            if (indexPath.row==self.dataArray.count) {
                //不知道为什么reload时候，最后一个下标没有刷新
                self.customLayout.page=indexPath.row-1;
            }else{
            }
            __weak FanExampleViewController2 *weakSelf=self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
            });
        }
            break;
        case 4:
        {
            //完成
            _isEdite=NO;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 其他

-(void)addNewRobot{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
