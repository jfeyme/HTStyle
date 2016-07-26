//
//  TwoViewController.m
//  HTStyle
//
//  Created by jfey on 16/7/10.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import "TwoViewController.h"
#import "UIView+HTStyleView.h"
#import "UIButton+Extension.h"
#import "HTStyle.h"

@interface TwoViewController ()

@property(nonatomic,weak) HTScrollView *scrollView;

@end

@implementation TwoViewController

-(void)breakBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *breakBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(breakBtn)];
    self.navigationItem.leftBarButtonItem = breakBtn;
    
    
    
    
    HTScrollView *scrollView = [HTScrollView new];
    scrollView.style.widthPCT = 1;
    scrollView.style.heightPCT = 1;
    scrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //设置可弹性
    scrollView.forceBouncesScroll = YES;
    
    //组合
    
    /** 
      * 网格布局
      */
    HTGridLayoutView *gridView = [HTGridLayoutView new];
    gridView.height = 240;
    gridView.gridColumn = 3;
    gridView.gridLeftRSpacing = 8;
    gridView.gridTopBSpacing = 4;
    [scrollView addSubview:gridView];
    //左右两边需要间距
    gridView.isGridLeftRight = YES;
    
    [gridView setGridCellCount:^NSInteger{
        return 9;
    }];
    [gridView setGridCellView:^UIView *(NSInteger index) {
        HTButton *but = [HTButton new];
        
        //如果使用按钮,需要禁止交互功能 [不然事件无法传递]
        but.userInteractionEnabled = NO;
        
        but.text = [NSString stringWithFormat:@"BUT - %ld", index+1];
        but.backgroundColor = [UIColor orangeColor];
        return but;
    }];
    [gridView setGridCellonClick:^(NSInteger index, UIView *subView, HTGridLayoutView *selfView) {
        NSLog(@"单击了第%ld个, %@", index, subView);
    }];

//    //也可以使用简单的添加方式
//    for (int i=0; i<10; i++) {
//        HTButton *but = [HTButton new];
//        but.text = [NSString stringWithFormat:@"BUT - %d", i+1];
//        but.backgroundColor = [UIColor orangeColor];
//        [gridView addSubview:but];
//    }
    
    
    //scrollView
    HTScrollView *horView = [HTScrollView new];
    horView.scrollType = HTScrollViewToTypeHorizontal;
    horView.height = 200;
    horView.backgroundColor = [UIColor purpleColor];
    //
    horView.pagingEnabled = YES;
    [scrollView addSubview:horView];
    
    for (int i=4; i<7; i++) {
        //当前为水平滚动, 只需要宽度.
        HTImageView *imgView = [HTImageView new];
        //imgView.width = 375;
        imgView.style.widthPCT = 1;
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_icon%d", i]];
        [horView addSubview:imgView];
    }
    
    
    //水平布局
    HTHorizLayoutView *horizView = [HTHorizLayoutView new];
    horizView.height = 300;
    //设置间距
    horizView.style.interval = 10;
    //Left
    horizView.style.paddingLeft = 10;
    horizView.style.paddingRight = 10;
    
    [scrollView addSubview:horizView];
    
    for (int i=4; i<7; i++) {
        HTImageView *imgView = [HTImageView new];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"user_icon%d", i]];
        [horizView addSubview:imgView];
    }
    
    
    UIView *oth = [UIView new];
    oth.height = 200;
    oth.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:oth];
    
    
    //双层文字
    HTTwoLabelView *twoLabel = [HTTwoLabelView new];
    twoLabel.topLabel.text = @"上上上";
    twoLabel.bottomLabel.text = @"下下下下";
    twoLabel.topLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.bottomLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.width = 80;
    twoLabel.height = 80;
    twoLabel.style.borderWidth = 4;
    twoLabel.style.borderColor = [UIColor redColor];
    //居中位置
    twoLabel.style.centerX = 0;
    twoLabel.style.centerY = 0;
    
    //圆形
    twoLabel.style.roundAngle = 40;
    
    //间隔,间距
    twoLabel.style.interval = 4;
    
    //分隔线
    twoLabel.separationHeight = 4;
    twoLabel.separationColor = [UIColor redColor];
    
    twoLabel.backgroundColor = [UIColor whiteColor];
    [oth addSubview:twoLabel];
    
    
    
    //双层文字
    HTTwoLabelView *userTwoLabel = [HTTwoLabelView new];
    userTwoLabel.topLabel.text = @"用户:";
    userTwoLabel.bottomLabel.text = @"密码:";
    userTwoLabel.width = 120;
    userTwoLabel.height = 56;
    userTwoLabel.style.borderWidth = 1;
    userTwoLabel.style.borderColor = [UIColor blackColor];
    //居中位置 - 向右移
    userTwoLabel.style.centerX = 120;
    userTwoLabel.style.centerY = 0;
    
    //圆形
    userTwoLabel.style.roundAngle = 10;
    
    //间隔,间距
    userTwoLabel.style.interval = 4;
    userTwoLabel.style.paddingLeft = 4;
    
    //分隔线
    userTwoLabel.separationHeight = 1;
    userTwoLabel.separationColor = [UIColor blackColor];
    
    userTwoLabel.backgroundColor = [UIColor whiteColor];
    [oth addSubview:userTwoLabel];
    
    
    
    
    /**
     *  一行内容布局
     */
    HTLineLayoutView *lineView = [HTLineLayoutView new];
    lineView.height = 120;
    lineView.backgroundColor = [UIColor purpleColor];
    //对齐方式 [右对齐]
    lineView.contentAlign = HTLineLayoutContentAlignTypeRight;
    [scrollView addSubview:lineView];
    
    //
    HTButton *but1 = [HTButton new];
    but1.width = 50;
    but1.text = @"BUT1";
    but1.backgroundColor = [UIColor redColor];
    [lineView addSubview:but1];
    //
    HTButton *but2 = [HTButton new];
    but2.width = 50;
    but2.text = @"BUT2";
    but2.backgroundColor = [UIColor blueColor];
    [lineView addSubview:but2];
    
}



@end
