//
//  HTTwoLabelView.h
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//  双层文字View (上下一个UILabel)
//  [注意]: UILabel只设置一行默认, 不处理文字多行

#import <UIKit/UIKit.h>
#import "HTView.h"

@interface HTTwoLabelView : HTView

/** 上层: 文字 */
@property(nonatomic,weak) UILabel *topLabel;
/** 下层: 文字 */
@property(nonatomic,weak) UILabel *bottomLabel;

/** 上下之间:分隔线线粗大小 */
@property(nonatomic,assign) CGFloat separationHeight;
/** 上下之间:分隔线宽度比例 (默认1.0是全宽) */
@property(nonatomic,assign) CGFloat separationWScale;
/** 上下之间:分隔线条头样式 */
@property(nonatomic,assign) CGLineCap separationLineCap;
/** 上下之间:分隔线颜色 */
@property(nonatomic,strong) UIColor *separationColor;
/** 上下之间:分隔线是否要计算保留边距 (默认:NO, style.padding无效) */
@property(nonatomic,assign) BOOL isSeparationStylePadding;

@end
