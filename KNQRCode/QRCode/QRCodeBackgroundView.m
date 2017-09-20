//
//  QRCodeBackgroundView.m
//  KNQRCode
//
//  Created by 刘凡 on 2017/9/19.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "QRCodeBackgroundView.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface QRCodeBackgroundView()



@end

@implementation QRCodeBackgroundView

-(void)drawRect:(CGRect)rect{
    _scanFrame = CGRectMake((kScreenWidth - 218) /2, (kScreenHeight - 218)/2, 218, 218);
    
    //需要填充的区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //填充颜色
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.65] set];
    
    //扫码区域上面填充
    rect = CGRectMake(0, 0, self.frame.size.width, _scanFrame.origin.y);
    CGContextFillRect(context, rect);
    
    //扫码区域左边填充
    rect = CGRectMake(0, _scanFrame.origin.y, _scanFrame.origin.x, _scanFrame.size.height);
    CGContextFillRect(context, rect);
    
    //扫码区域右边填充
    rect = CGRectMake(CGRectGetMaxX(_scanFrame), _scanFrame.origin.y, _scanFrame.origin.x, _scanFrame.size.height);
    CGContextFillRect(context, rect);
    
    //扫码下面填充
    rect = CGRectMake(0, CGRectGetMaxY(_scanFrame), self.frame.size.width, self.frame.size.height - CGRectGetMaxY(_scanFrame));
    CGContextFillRect(context, rect);
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
