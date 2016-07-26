//
//  HTButton.m
//  JfeyHTStyle
//
//  Created by jfey on 16/6/15.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import "HTButton.h"
#import "UIView+Using.h"
#import "UIView+HTStyleView.h"


@implementation HTButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.style = [[HTStyleClass alloc] initWithView:self];
        self.myStyle = self.style;
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置内容布局
    [self setupButtonLayout];
}

/** 设置按钮内容布局 */
-(void)setupButtonLayout{
    //有效值尺寸
    CGFloat x = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
    CGFloat y = MAX(self.style.padding, self.style.paddingTop) + self.style.borderWidth;
    CGFloat width = self.width - x - MAX(self.style.padding, self.style.paddingRight);
    CGFloat height = self.height - y - MAX(self.style.padding, self.style.paddingBottom);
    width -= self.style.borderWidth;
    height -= self.style.borderWidth;
    
    if (width<1 || height<1) {
        return;
    }
    
    //间距
    CGFloat interval = self.style.interval;
    
    //取图片原大小与比例
    CGFloat imgWidth, imgHeight;
    CGFloat ti_x=0, ti_y=0, ti_w=0, ti_h=0;
    CGFloat im_x=0, im_y=0, im_w=0, im_h=0;
    
    imgWidth = self.imageView.image.size.width;
    imgHeight = self.imageView.image.size.height;
    im_w = imgWidth;
    im_h = imgHeight;
    
    CGSize size = [self sizeText:self.titleLabel.text WithFont:self.titleLabel.font];
    ti_w = size.width;
    ti_h = size.height;
    
    if (ti_w==0 || ti_h==0 || self.hiddenTitleLabel==YES) {
        interval = 0;
        ti_w = 0;
        ti_h = 0;
    }
    
    if (im_w==0 || im_h==0 || self.hiddenImageView==YES) {
        //没有图片
        ti_x = x;
        ti_y = y + (height - ti_h)*0.5;
        ti_w = width;
        //简单对齐方式
        if (self.contentAlign == HTButtonContentAlignTypeCenter ||
            self.contentAlign == HTButtonContentAlignTypeLeftRight) {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }else if (self.contentAlign == HTButtonContentAlignTypeLeft){
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
        }else if (self.contentAlign == HTButtonContentAlignTypeRight){
            self.titleLabel.textAlignment = NSTextAlignmentRight;
        }
        self.titleLabel.frame = CGRectMake(ti_x, ti_y, ti_w, ti_h);
        return;
    }
    
    //是否设置图片大小
    if (!CGSizeEqualToSize(self.imageSize, CGSizeZero)) {
        if (self.imageSize.width > 0 && self.imageSize.height > 0) {
            im_w = self.imageSize.width;
            im_h = self.imageSize.height;
            
        }else if (self.imageSize.width > 0) {
            im_w = self.imageSize.width;
            CGFloat scale = self.imageSize.width / imgWidth;
            im_h = imgHeight * scale;
            
        }else if (self.imageSize.height > 0) {
            im_h = self.imageSize.height;
            CGFloat scale = self.imageSize.height / imgHeight;
            im_w = imgWidth * scale;
        }
    }
    
    //默认布局方式
    if (self.contentLayout == HTButtonContentLayoutTypeDefault) {
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        //图片高度是否超越
        if (im_h > height) {
            im_h = height;
            CGFloat scale = im_h / imgHeight;
            im_w = scale * imgWidth;
        }
        //图片+文字宽高是否超越
        if ((im_w + ti_w + interval) > width) {
            //对半分
            ti_w = (width-interval) * 0.5;
            im_w = ti_w;
            CGFloat scale = im_w / imgWidth;
            im_h = scale * imgHeight;
            
            if (im_h > height) {
                CGFloat uda = im_h - height;
                im_h -= uda;
                CGFloat scale = im_h / imgHeight;
                im_w = scale * imgWidth;
            }
        }
        //上下居中
        im_y = y + (height - im_h)*0.5;
        ti_y = y + (height - ti_h)*0.5;
        
        if (self.contentAlign == HTButtonContentAlignTypeCenter) {
            im_x = x + (width - im_w - ti_w - interval) * 0.5;
            ti_x = im_x + im_w + interval;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeLeft){
            im_x = x;
            ti_x = im_x + im_w + interval;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeRight){
            ti_x = x + width - ti_w;
            im_x = ti_x - interval - im_w;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeLeftRight){
            im_x = x;
            ti_x = x + width - ti_w;
        }
        //图片在右,文字在左
    }else if (self.contentLayout == HTButtonContentLayoutTypeImageRight) {
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        //图片高度是否超越
        if (im_h > height) {
            im_h = height;
            CGFloat scale = im_h / imgHeight;
            im_w = scale * imgWidth;
        }
        //图片+文字宽高是否超越
        if ((im_w + ti_w + interval) > width) {
            //对半分
            ti_w = (width-interval) * 0.5;
            im_w = ti_w;
            CGFloat scale = im_w / imgWidth;
            im_h = scale * imgHeight;
            
            if (im_h > height) {
                CGFloat uda = im_h - height;
                im_h -= uda;
                CGFloat scale = im_h / imgHeight;
                im_w = scale * imgWidth;
            }
        }
        //上下居中
        im_y = y + (height - im_h)*0.5;
        ti_y = y + (height - ti_h)*0.5;
        
        if (self.contentAlign == HTButtonContentAlignTypeCenter) {
            ti_x = x + (width - im_w - ti_w - interval) * 0.5;
            im_x = ti_x + ti_w + interval;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeLeft){
            ti_x = x;
            im_x = ti_x + ti_w + interval;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeRight){
            im_x = x + width - im_w;
            ti_x = im_x - interval - ti_w;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeLeftRight){
            ti_x = x;
            im_x = x + width - im_w;
        }
        //图片上,下布局
    }else if (self.contentLayout == HTButtonContentLayoutTypeImgTopBottom) {
        //图片宽度是否超越
        if (im_w > width) {
            im_w = width;
            CGFloat scale = im_w / imgWidth;
            im_h = scale * imgHeight;
        }
        //图片高度是否超越
        if (im_h > height) {
            im_h = height;
            CGFloat scale = im_h / imgHeight;
            im_w = scale * imgWidth;
        }
        //图片+文字高度是否超越
        if ((im_h + ti_h + interval) > height) {
            //缩小图片高度 (文字高度不变)
            CGFloat uda = (im_h + ti_h + interval) - height;
            im_h -= uda;
            CGFloat scale = im_h / imgHeight;
            im_w = scale * imgWidth;
        }
        im_y = y;
        ti_x = x;
        ti_w = width;
        ti_y = im_y + im_h + interval;
        
        if (self.contentAlign == HTButtonContentAlignTypeCenter ||
            self.contentAlign == HTButtonContentAlignTypeLeftRight){
            im_x = x + (width - im_w) * 0.5;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeLeft){
            im_x = x;
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeRight){
            im_x = x + width - im_w;
            self.titleLabel.textAlignment = NSTextAlignmentRight;
        }
        //图片下,上布局
    }else if (self.contentLayout == HTButtonContentLayoutTypeTextTopBottom) {
        //图片宽度是否超越
        if (im_w > width) {
            im_w = width;
            CGFloat scale = im_w / imgWidth;
            im_h = scale * imgHeight;
        }
        //图片高度是否超越
        if (im_h > height) {
            im_h = height;
            CGFloat scale = im_h / imgHeight;
            im_w = scale * imgWidth;
        }
        //图片+文字高度是否超越
        if ((im_h + ti_h + interval) > height) {
            //缩小图片高度 (文字高度不变)
            CGFloat uda = (im_h + ti_h + interval) - height;
            im_h -= uda;
            CGFloat scale = im_h / imgHeight;
            im_w = scale * imgWidth;
        }
        ti_y = y;
        ti_x = x;
        ti_w = width;
        im_y = ti_y + ti_h + interval;
        
        if (self.contentAlign == HTButtonContentAlignTypeCenter ||
            self.contentAlign == HTButtonContentAlignTypeLeftRight){
            im_x = x + (width - im_w) * 0.5;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeLeft){
            im_x = x;
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            
        }else if (self.contentAlign == HTButtonContentAlignTypeRight){
            im_x = x + width - im_w;
            self.titleLabel.textAlignment = NSTextAlignmentRight;
        }
    }
    
    self.imageView.frame = CGRectMake(im_x, im_y, im_w, im_h);
    self.titleLabel.frame = CGRectMake(ti_x, ti_y, ti_w, ti_h);
}

/** 取文字大小 */
- (CGSize)sizeText:(NSString *)text WithFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        NSDictionary *attrs = @{NSFontAttributeName:font};
        size = [text sizeWithAttributes:attrs];
    }else{
        size = [text sizeWithFont:font];
    }
    return size;
}

@end
