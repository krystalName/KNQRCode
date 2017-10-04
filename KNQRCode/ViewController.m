//
//  ViewController.m
//  KNQRCode
//
//  Created by 刘凡 on 2017/9/19.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeViewController.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property(nonatomic, strong )UIButton * QRButtton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.view addSubview:self.QRButtton];
    
}

-(void)QRButttonClick:(UIButton *)sender{
    QRCodeViewController *vc =  [QRCodeViewController new];
    
    //扫描失败的时候。调用block
    vc.KNRCodeFailBlock = ^(QRCodeViewController * vc) {
       //失败的处理
      // 1.比如说弹窗
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(UIButton *)QRButtton{
    if (!_QRButtton) {
        _QRButtton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 120, 40)];
        [_QRButtton setBackgroundColor:[UIColor blueColor]];
        [_QRButtton setTitle:@"扫描二维码" forState:UIControlStateNormal];
        [_QRButtton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _QRButtton.titleLabel.font = [UIFont systemFontOfSize:13];
        _QRButtton.layer.masksToBounds = YES;
        _QRButtton.layer.cornerRadius = 20;
        [_QRButtton addTarget:self action:@selector(QRButttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _QRButtton;
}

@end
