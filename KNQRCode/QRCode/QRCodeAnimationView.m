//
//  QRCodeAnimation.m
//  KNQRCode
//
//  Created by 刘凡 on 2017/9/19.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "QRCodeAnimationView.h"
#import "UIViewExt.h"

@interface QRCodeAnimationView()

/**
 记录当前线条绘制的位置
 */
@property(nonatomic, assign)CGPoint position;

/**
 定时器
 */
@property(nonatomic, strong)NSTimer *timer;

@end

@implementation QRCodeAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //画一个框框
        UIImageView *areaview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"frame_icon"]];
        areaview.width = self.width;
        areaview.height = self.height;
        
        [self addSubview:areaview];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
        
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    CGPoint newPostion = self.position;
    //义一个像素一个像素的移动
    newPostion.y +=1;
    
    //如果到了底部。就从新开始下降
    if (newPostion.y > rect.size.height) {
        newPostion.y = 0;
    }
    
    self.position = newPostion;
    
    //绘制图片
    UIImage *image = [UIImage imageNamed:@"line"];
    
    [image drawAtPoint:self.position];
}


-(void)startAnimaion{
    [self.timer setFireDate:[NSDate date]];
}

-(void)stopAnimaion{
    [self.timer setFireDate:[NSDate distantFuture]];
}


@end
