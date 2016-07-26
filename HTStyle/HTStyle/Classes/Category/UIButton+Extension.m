//
//  UIButton+Ext.m
//  HTML样式类
//
//  Created by jfey on 16/2/10.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>


@interface UIButton ()
@property(nonatomic,copy) buttonClickBlock clickBlock;
@end

@implementation UIButton (Extension)

-(void)setText:(NSString *)text
{
    [self setTitle:text forState:UIControlStateNormal];
}
-(NSString *)text
{
    return self.titleLabel.text;
}

//字体颜色
-(void)setTextColor:(UIColor *)textColor
{
    [self setTitleColor:textColor forState:UIControlStateNormal];
}
-(UIColor *)textColor
{
    return self.titleLabel.textColor;
}

//文字大小
-(void)setTextSize:(CGFloat)textSize
{
    self.titleLabel.font = [UIFont systemFontOfSize:textSize];
}
-(CGFloat)textSize
{
    return self.titleLabel.font.pointSize;
}
//主图片名(默认状态下)
-(void)setImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}
-(UIImage *)image
{
    return self.imageView.image;
}

//主图片名(默认状态下)
-(void)setImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image forState:UIControlStateNormal];
}
-(NSString *)imageName
{
    return nil;
}

//背景图片
-(void)setBackgroundImageName:(NSString *)backgroundImageName
{
    UIImage *image = [UIImage imageNamed:backgroundImageName];
    [self setBackgroundImage:image forState:UIControlStateNormal];
}
-(NSString *)backgroundImageName
{
    return nil;
}

/** 选中时 */
-(void)setSelectImageName:(NSString *)selectImageName
{
    [self setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
}
-(NSString *)selectImageName
{
    return nil;
}

-(void)setSelectBackgroundImageName:(NSString *)selectBackgroundImageName
{
    [self setBackgroundImage:[UIImage imageNamed:selectBackgroundImageName] forState:UIControlStateSelected];
}
-(NSString *)selectBackgroundImageName
{
    return nil;
}

/** 禁止时 */
-(void)setDisabledImageName:(NSString *)DisabledImageName
{
    [self setImage:[UIImage imageNamed:DisabledImageName] forState:UIControlStateDisabled];
}
-(NSString *)DisabledImageName
{
    return nil;
}

-(void)setDisabledBackgroundImageName:(NSString *)DisabledBackgroundImageName
{
    [self setBackgroundImage:[UIImage imageNamed:DisabledBackgroundImageName] forState:UIControlStateDisabled];
}
-(NSString *)DisabledBackgroundImageName
{
    return nil;
}


/** 快捷事件: 单击事件 */
-(void)onClick:(buttonClickBlock)block
{
    self.clickBlock = block;
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonClick
{
    if (self.clickBlock) {
        typeof(self) __weak weakSelf = self;
        self.clickBlock(weakSelf);
    }
}

-(void)setClickBlock:(buttonClickBlock)clickBlock
{
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(buttonClickBlock)clickBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
