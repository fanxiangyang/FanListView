//
//  FanExampleViewController.m
//  FanListView
//
//  Created by 向阳凡 on 2018/8/3.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

#import "FanExampleViewController.h"
#import "FanScrollView.h"


@interface FanExampleViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FanExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.dataArray = [@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"12.jpg",@"13.jpg",@"14.jpg",@"15.jpg",@"16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg"] mutableCopy];
    self.title=@"UIScrollView";
}

-(void)createScrollViewUI{
        FanScrollView *listView=[[FanScrollView alloc]initWithFrame:CGRectMake(30, 80, self.view.bounds.size.width-60 , 260)imageArray: self.dataArray];
        [self.view addSubview:listView];
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
