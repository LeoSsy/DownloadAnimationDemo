//
//  ViewController.m
//  DownloadAnimationDemo
//
//  Created by 舒少勇 on 2017/2/21.
//  Copyright © 2017年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "SYDownloadView.h"

@interface ViewController ()
{
    NSTimer *_timer;
    CGFloat _progress;
}
@property (nonatomic, strong) SYDownloadView *downloadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progress = 0.0;
    self.view.backgroundColor = [UIColor grayColor];
    
    self.downloadView = [[SYDownloadView alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    self.downloadView.lineWidth = 1;
    [self.downloadView addTarget:self action:@selector(updateProgress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadView];
    self.downloadView.progressColor = [UIColor redColor];
}

/**模拟网络请求数据进度*/
- (void)downloadData{
    _progress += 0.005;
    self.downloadView.progress  = _progress;
    
    if (_progress >= 1.0) {
        self.downloadView.userInteractionEnabled = YES;
        self.downloadView.progress = 1.f;
        _progress = 0.f;
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)updateProgress{
    self.downloadView.userInteractionEnabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(downloadData) userInfo:nil repeats:YES];
}




@end
