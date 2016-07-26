//
//  HTView.h
//  JfeyHTStyle
//
//  Created by jfey on 16/6/15.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import <UIKit/UIKit.h>
#import "HTStyleClass.h"

@interface HTView : UIView

@property(nonatomic,strong) HTStyleClass *style;

/** 添加一个单击事件 */
-(void)addClickWithTarget:(id)target action:(SEL)sel;

@end
