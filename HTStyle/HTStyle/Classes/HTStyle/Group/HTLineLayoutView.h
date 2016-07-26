//
//  HTLineLayoutView.h
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//  一行内容布局, 左中右对齐 (默认:左对齐)
//  如果子内容高度为0,自动设置为全高 (宽度必须要有)

#import <UIKit/UIKit.h>
#import "HTView.h"

typedef enum : NSUInteger {
    /** 默认左对 */
    HTLineLayoutContentAlignTypeLeft,
    /** 居中 */
    HTLineLayoutContentAlignTypeCenter,
    /** 右对 */
    HTLineLayoutContentAlignTypeRight,
    /** 分散对齐,平均对齐 */
    HTLineLayoutContentAlignTypeScatter
    
} HTLineLayoutContentAlignType;


@interface HTLineLayoutView : HTView

/** 内容对齐方式 */
@property(nonatomic,assign) HTLineLayoutContentAlignType contentAlign;

/** 对象之间:分隔线线粗大小 */
@property(nonatomic,assign) CGFloat separationHeight;
/** 对象之间:分隔线宽度比例 (默认1 是全宽) */
@property(nonatomic,assign) CGFloat separationWScale;
/** 对象之间:分隔线条头样式 */
@property(nonatomic,assign) CGLineCap separationLineCap;
/** 对象之间:分隔线颜色 */
@property(nonatomic,strong) UIColor *separationColor;
/** 对象之间:分隔线是否要计算保留边距 (默认:NO, style.padding无效) */
@property(nonatomic,assign) BOOL isSeparationStylePadding;

@end
