//
//  KNLableViewController.m
//  KNQRCode
//
//  Created by 刘凡 on 2017/9/20.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "KNLableViewController.h"
#import "UIViewExt.h"

@interface KNLableViewController ()

@property(nonatomic, strong)UILabel *KNLable;

@end

@implementation KNLableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    [self.view addSubview:self.KNLable];
    
    self.KNLable.text = _QRString;
    
    self.KNLable.frame = CGRectMake(50, 20, self.view.bounds.size.width, 300);
    
    
}


-(UILabel *)KNLable{
    if (!_KNLable) {
        _KNLable = [[UILabel alloc]init];
        _KNLable.textColor = [UIColor orangeColor];
        _KNLable.font = [UIFont systemFontOfSize:15];
        _KNLable.numberOfLines = 0;
    }
    return _KNLable;
}


@end
