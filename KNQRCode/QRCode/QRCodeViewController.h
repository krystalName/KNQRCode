//
//  QRCodeViewController.h
//  KNQRCode
//
//  Created by 刘凡 on 2017/9/19.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeViewController : UIViewController

@property (nonatomic, copy) void (^KNRCodeCancleBlock) (QRCodeViewController *);//扫描取消
@property (nonatomic, copy) void (^KNRCodeSuncessBlock) (QRCodeViewController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^KNRCodeFailBlock) (QRCodeViewController *);//扫描失败


@end
