//
//  HTButton.h
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

typedef enum : NSUInteger {
    /** 默认居中 */
    HTButtonContentAlignTypeCenter,
    /** 左对 */
    HTButtonContentAlignTypeLeft,
    /** 右对 */
    HTButtonContentAlignTypeRight,
    /** 左右对齐(两边排) (对于上下布局不起用) */
    HTButtonContentAlignTypeLeftRight
    
} HTButtonContentAlignType;

typedef enum : NSUInteger {
    /** 默认,系统方式(图片在左,文字在右) */
    HTButtonContentLayoutTypeDefault,
    /** 图片在右,文字在左 */
    HTButtonContentLayoutTypeImageRight,
    /** 图片在上,文字在下 */
    HTButtonContentLayoutTypeImgTopBottom,
    /** 图片在下,文字在上 */
    HTButtonContentLayoutTypeTextTopBottom
    
} HTButtonContentLayoutType; //布局方式


@interface HTButton : UIButton

@property(nonatomic,strong) HTStyleClass *style;

/** 内容对齐方式 */
@property(nonatomic,assign) HTButtonContentAlignType contentAlign;
/** 布局对齐方式 */
@property(nonatomic,assign) HTButtonContentLayoutType contentLayout;
/** 图片大小 (如果其一为0,自动按比例计算) */
@property(nonatomic,assign) CGSize imageSize;

/** 按钮图片: 圆角度 */
@property(nonatomic,assign) CGFloat imageRoundAngle;
/** 按钮图片: 边宽 */
@property(nonatomic,assign) CGFloat imageBorderWidth;
/** 按钮图片: 边线颜色 */
@property(nonatomic,strong) UIColor *imageBorderColor;

/** 是否显示高亮(默认:YES) */
@property(nonatomic,assign) BOOL isDisplayHighlighted;
/** 是否: 隐藏图片 */
@property(nonatomic,assign) BOOL hiddenImageView;
/** 是否: 隐藏文字 */
@property(nonatomic,assign) BOOL hiddenTitleLabel;

@end
