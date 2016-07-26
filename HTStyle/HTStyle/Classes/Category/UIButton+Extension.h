//
//  UIButton+Ext.h
//  HTML样式类
//
//  Created by jfey on 16/2/10.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButton;

typedef void(^buttonClickBlock)(UIButton *selfButton);

@interface UIButton (Extension)

/** 快捷设置 */
@property(nonatomic,copy) NSString *text;
/** 快捷设置 */
@property(nonatomic,strong) UIColor *textColor;
/** 快捷设置 */
@property(nonatomic,assign) CGFloat textSize;

/** 快捷: 图片 */
@property(nonatomic,strong) UIImage *image;
/** 快捷: 图片名 (无返回值nil) */
@property(nonatomic,copy) NSString *imageName;
/** 快捷: 背景图片 (无返回值nil) */
@property(nonatomic,copy) NSString *backgroundImageName;

/** 快捷: 选中时图片名 (无返回值nil) */
@property(nonatomic,copy) NSString *selectImageName;
/** 快捷: 选中时背景图片 (无返回值nil) */
@property(nonatomic,copy) NSString *selectBackgroundImageName;

/** 快捷: 禁止时图片名 (无返回值nil) */
@property(nonatomic,copy) NSString *DisabledImageName;
/** 快捷: 禁止时背景图片 (无返回值nil) */
@property(nonatomic,copy) NSString *DisabledBackgroundImageName;


/** 快捷事件: 单击事件 (UIControlEventTouchUpInside) */
-(void)onClick:(buttonClickBlock)block;

@end
