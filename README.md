# KNQRCode
扫描二维码小工具


### 用系统的api 打造的一个扫码小工具。 用于以后项目需求吧。 先上一张gif看下效果

![](https://github.com/krystalName/KNQRCode/blob/master/KNQRCode.gif)

### 附加只要实现代码如下

``` objc

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

```
## 注意要点

1.要在plist 文件里面开启权限

2.只能在真机上面运行。



