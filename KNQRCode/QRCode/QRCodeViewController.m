//
//  QRCodeViewController.m
//  KNQRCode
//
//  Created by 刘凡 on 2017/9/19.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeAnimationView.h"
#import "QRCodeBackgroundView.h"
#import "UIViewExt.h"
#import "KNWebViewController.h"
#import "KNLableViewController.h"


#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>


//相机
@property (nonatomic, strong)AVCaptureSession *session;

//动画
@property (nonatomic, strong)QRCodeAnimationView *QRanimationView;

//返回按钮
@property(nonatomic, strong)UIButton *goBackButton;

//提示文字
@property(nonatomic, strong)UILabel *titleLable;

//是否需要重新开启扫码
@property(nonatomic, assign)BOOL IsOpen;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _IsOpen = NO;
    //设置一个扫码区域的Rect
    CGRect areaRect = CGRectMake((kScreenWidth - 218)/2, (kScreenHeight - 218)/2, 218, 218);
    
    //半透明背景
    QRCodeBackgroundView *backGroundView = [[QRCodeBackgroundView alloc]initWithFrame:self.view.bounds];
    backGroundView.scanFrame = areaRect;
    [self.view addSubview:backGroundView];
    
    //设置扫码区域
    _QRanimationView = [[QRCodeAnimationView alloc]initWithFrame:areaRect];
    [self.view addSubview:_QRanimationView];
    
    //添加提示文字
    [self.view addSubview:self.titleLable];
    //y设置成扫描区域的下面加20
    self.titleLable.y = CGRectGetMaxY(_QRanimationView.frame) + 20;
    self.titleLable.center = CGPointMake(_QRanimationView.center.x, self.titleLable.center.y);
    
    //添加返回按钮
    [self.view addSubview:self.goBackButton];
    
    //设置摄影。以及直接开始运行
    [self beginScanning];

}

-(void)beginScanning{
    
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    
    //设置代理在主线程中
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置识别区域
    output.rectOfInterest = CGRectMake(_QRanimationView.y/ kScreenHeight, _QRanimationView.x/kScreenWidth, _QRanimationView.height / kScreenHeight, _QRanimationView.width/kScreenWidth);
    
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    
    //设置采集率
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    //添加输入流
    [_session addInput:input];
    //添加输出流
    [_session addOutput:output];
    
    //设置扫码支持的编码格式
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    //创建视频预览层并将其添加到UI中
    AVCaptureVideoPreviewLayer *layer =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //开始捕获
    [_session startRunning];
 
}

#pragma mark - 二维码扫描的回调
-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //扫描到了数据
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        //停止动画
        [_QRanimationView stopAnimaion];
        
        //在获取到扫描的数据
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        NSLog(@"扫码出来的内容  ---%@",metadataObject.stringValue);
        KNLableViewController  *LableVC = [[KNLableViewController alloc]init];
        LableVC.QRString = metadataObject.stringValue;
        //进入到webView 中显示
        _IsOpen = YES;
        [self.navigationController pushViewController:LableVC animated:YES];
    }
}


-(void)goBackButtonClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIButton *)goBackButton{
    if (!_goBackButton) {
        _goBackButton = [[UIButton alloc]initWithFrame:CGRectMake(25, 44, 40, 40)];
        [_goBackButton setImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(goBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackButton;
}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.text = @"将二维码放入框内，即开始扫描";
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = [UIColor whiteColor];
        [_titleLable sizeToFit];
    }
    return _titleLable;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    if (_IsOpen) {
        [_QRanimationView startAnimaion];
        [_session startRunning];
    }
     self.navigationController.navigationBarHidden = YES;
}
@end
