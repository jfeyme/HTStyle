//
//  ViewController.m
//  HTStyle
//
//  Created by jfey on 16/6/27.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import "ViewController.h"
#import "HTStyle.h"
#import "UIView+HTStyleView.h"
#import "UIButton+Extension.h"

#import "TwoViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HTView *view = [HTView new];
    view.width = 100;
    view.height = 100;
    view.y = 30;
    //保持在右边 (可旋转屏幕) 不使用约束,请不要用约束对所有的HTView... 如果使用了约束定位,就不要用style相对定位或大小宽高
    view.style.right = 20;
    view.style.borderWidth = 2;
    view.style.borderColor = [UIColor redColor];
    //圆角
    view.style.roundAngle = 10;
    view.style.roundEdge = UIEdgeInsetsMake(1, 1, 0, 0);
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    
    HTButton *button_1 = [HTButton new];
    button_1.imageName = @"user_icon5";
    button_1.text = @"TTYY";
    button_1.textColor = [UIColor redColor];
    button_1.y = 30;
    button_1.width = 100;
    button_1.height = 30;
    button_1.style.borderWidth = 1;
    button_1.style.borderColor = [UIColor redColor];
    button_1.style.roundAngle = 10;
    //上保留空白 边距
    button_1.style.paddingTop = 6;
    [self.view addSubview:button_1];
    
    
    HTButton *button_2 = [HTButton new];
    button_2.imageName = @"user_icon5";
    button_2.text = @"按钮00";
    button_2.textColor = [UIColor redColor];
    button_2.x = 120;
    button_2.y = 30;
    button_2.width = 120;
    button_2.height = 30;
    button_2.style.borderWidth = 1;
    button_2.style.borderColor = [UIColor redColor];
    button_2.style.roundAngle = 10;
    button_2.style.roundEdge = UIEdgeInsetsMake(1, 0, 0, 0);
    //图片 和 文字间距
    button_2.style.interval = 10;
    [self.view addSubview:button_2];
    
    
    HTButton *button_3 = [HTButton new];
    button_3.imageName = @"user_icon5";
    button_3.text = @"按钮Top";
    button_3.textColor = [UIColor redColor];
    button_3.x = 10;
    button_3.y = 80;
    button_3.width = 100;
    button_3.height = 60;
    button_3.style.borderWidth = 1;
    button_3.style.borderColor = [UIColor redColor];
    //圆角度 边样式
    button_3.style.roundAngle = 10;
    button_3.style.roundEdge = UIEdgeInsetsMake(0, 1, 1, 0);
    //图片 和 文字间距
    button_3.style.interval = 10;
    //布局方式 (上下)
    button_3.contentLayout = HTButtonContentLayoutTypeImgTopBottom;
    //上下保留边距
    button_3.style.paddingTop = 4;
    button_3.style.paddingBottom = 4;
    [self.view addSubview:button_3];
    
    
    HTLabel *label_1 = [HTLabel new];
    label_1.style.right = 10;
    label_1.y = 140;
    label_1.font = [UIFont systemFontOfSize:12];
    label_1.text = @"中文中文 可旋转 一直靠右的!123";
    [self.view addSubview:label_1];
    
    
    HTImageView *imageView = [HTImageView new];
    imageView.image = [UIImage imageNamed:@"user_icon5"];
    imageView.width = 80;
    imageView.height = 70;
    imageView.x = 10;
    imageView.y = 150;
    [self.view addSubview:imageView];
    imageView.style.roundAngle = 20;
    imageView.style.roundEdge = UIEdgeInsetsMake(1, 0, 0, 1);
    
    
    HTImageView *imageView2 = [HTImageView new];
    imageView2.image = [UIImage imageNamed:@"user_icon5"];
    imageView2.width = 80;
    imageView2.height = 80;
    imageView2.x = 100;
    imageView2.y = 150;
    [self.view addSubview:imageView2];
    imageView2.style.roundAngle = 40;
    imageView2.style.borderWidth = 4;
    imageView2.style.borderColor = [UIColor orangeColor];
    
    
    HTTextField *textField = [HTTextField new];
    textField.style.widthPCT = 0.8;
    textField.height = 30;
    textField.placeholder = @"有左边距...";
    textField.style.leftPCT = 0.1; // x 比例
    textField.y = 250;
    textField.style.borderWidth = 2;
    textField.style.borderColor = [UIColor orangeColor];
    //左边距,.
    textField.style.paddingLeft = 30;
    [self.view addSubview:textField];
    
    
    
    //scrollView
    HTButton *scrollBut = [HTButton new];
    scrollBut.text = @"HTScrollView 点击进入";
    scrollBut.backgroundColor = [UIColor orangeColor];
    scrollBut.style.widthPCT = 0.8;
    scrollBut.style.leftPCT = 0.1;
    scrollBut.height = 44;
    scrollBut.y = 300;
    [self.view addSubview:scrollBut];
    [scrollBut addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonClick
{
    TwoViewController *twoVc = [TwoViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:twoVc];
    
    UITabBarController *tabbarVc = [UITabBarController new];
    [tabbarVc addChildViewController:nav];
    
    [self presentViewController:tabbarVc animated:YES completion:nil];
}




@end
