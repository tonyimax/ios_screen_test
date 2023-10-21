//
//  ViewController.m
//  ios_screen_test
//
//  Created by Hacker X on 2023/10/10.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
-(IBAction)btnGetOrientation:(id)sender;
-(IBAction)btnFixPortrait:(id)sender;
-(IBAction)btnFixLand:(id)sender;
@property(nonatomic) UIInterfaceOrientationMask mask;
@property(nonatomic,strong) AppDelegate* _app;
@end

@implementation ViewController
@synthesize mask;
@synthesize _app;

- (void)viewDidLoad {
    [super viewDidLoad];
    //取应用委托实例
    _app = [UIApplication sharedApplication].delegate;
    mask = UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscape;//支持横竖屏切换
    //注册屏幕旋转监听
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    [ViewController getDeviceOrientation];
}

-(IBAction)btnGetOrientation:(id)sender{
    [ViewController getDeviceOrientation];
}
-(IBAction)btnFixPortrait:(id)sender{
    //访问应用程序委托成员
    _app.mask = UIInterfaceOrientationMaskPortrait;//设置窗口旋转属性
    [self setNeedsUpdateOfSupportedInterfaceOrientations];//使用设置立刻生效
    //mask = UIInterfaceOrientationMaskPortrait;//只支持竖屏
}

-(IBAction)btnFixLand:(id)sender{
    _app.mask = UIInterfaceOrientationMaskLandscape;//设置窗口旋转属性
    [self setNeedsUpdateOfSupportedInterfaceOrientations];//使用设置立刻生效
    //mask = UIInterfaceOrientationMaskLandscape;//只支持横屏
}

+(void)setPortrait:(UIInterfaceOrientationMask) mask{
    mask = UIInterfaceOrientationMaskPortrait;//只支持竖屏
}

+(void)setLandscape:(UIInterfaceOrientationMask) mask{
    mask = UIInterfaceOrientationMaskLandscape;//只支持横屏
}

+(UIDeviceOrientation)getDeviceOrientation{
    NSLog(@"getDeviceOrientation:%ld",[UIDevice currentDevice].orientation);
    return [UIDevice currentDevice].orientation;
}

//屏幕监听事件处理
-(void)deviceOrientationDidChange{
    NSLog(@"%lu",(unsigned long)_app.mask);
    NSLog(@"%lu",[self supportedInterfaceOrientations]);
    switch ([UIDevice currentDevice].orientation) {
        case UIInterfaceOrientationUnknown:
            NSLog(@"Unknown");
            break;
        case UIInterfaceOrientationPortrait:
            NSLog(@"Portrait");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"UpsideDown");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"LandscapeLeft");
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"LandscapeRight");
            break;
        default:
            break;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//设置自动旋转
- (BOOL)shouldAutorotate{
    return YES;
}

//重写基类supportedInterfaceOrientations来设置支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return mask;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return _app.mask;
}

@end
