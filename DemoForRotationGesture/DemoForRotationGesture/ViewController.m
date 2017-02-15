//
//  ViewController.m
//  DemoForRotationGesture
//
//  Created by 林林尤达 on 17/2/8.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "drawAView.h"


#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<AVAudioPlayerDelegate>

@property (nonatomic,strong)singleGestureRecognizer *rspGesture;
@property (nonatomic,strong)drawAView *circleView;
// 背景  圆圈图片  按钮
@property (nonatomic,strong)UIImageView *BgView;
@property (nonatomic,strong)UIButton *Play;
@property (nonatomic,strong)UIImageView *singerImgView;

@property (nonatomic,strong)AVAudioPlayer *avAudioPlayer;
@property(strong,nonatomic)CADisplayLink *link;//定时器
//播放状态
@property (nonatomic,assign)BOOL stopOrPlay;

@property (nonatomic,assign)CGFloat progressNow;
@property (nonatomic,assign)CGFloat showTheQuickOrLow;

@property (nonatomic,strong)UILabel *timeLabel;


@end

@implementation ViewController
#pragma mark -Life cycle
- (void)dealloc {
    //移除定时器
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (CADisplayLink *)link{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeProgress)];
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return _link;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithAvAudioPlayer];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginfuntion) name:@"begin" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endfuntion) name:@"end" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFailfuntion) name:@"endFail" object:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    _BgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *0.68)];
    _BgView.image = [UIImage imageNamed:@"bg"];
    _Play = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    _Play.center = CGPointMake(_BgView.frame.size.width/2, _BgView.frame.size.height/2);
    [_Play setImage:[UIImage imageNamed:@"radio1"] forState:UIControlStateNormal];
    [_Play setImage:[UIImage imageNamed:@"radio2"] forState:UIControlStateSelected];
    [_Play addTarget:self action:@selector(PlayOrPause:) forControlEvents:UIControlEventTouchUpInside];
    
    _singerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,250, 250)];
    _singerImgView.image = [UIImage imageNamed:@"fm920"];
    _singerImgView.layer.masksToBounds = YES;
    _singerImgView.layer.cornerRadius = _singerImgView.frame.size.height/2;
    _singerImgView.center = CGPointMake(_BgView.frame.size.width/2, _BgView.frame.size.height/2);
    
    _circleView = [[drawAView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *0.68)];
    _circleView.backgroundColor = [UIColor clearColor];
    [_circleView sizeToFit];
    
    
    [self.view addSubview:_BgView];
    [self.view addSubview:_circleView];
    [self.view addSubview:_singerImgView];
    [self.view addSubview:_Play];
    
    
    self.link.paused = NO;
    //加入手势传入view来绑定  传入imageView所以要设置
    _singerImgView.userInteractionEnabled = YES;
    [self addGesture:_singerImgView];
    
    
    //添加一个label
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, CGRectGetMaxY(_BgView.frame), 200, 50)];
    _timeLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_timeLabel];
}

//设置播放器初始化
- (void)initWithAvAudioPlayer{
    //播放音乐
    NSString *path = [[NSBundle mainBundle] pathForResource:@"张碧晨 - 时光笔墨" ofType:@"mp3"];
    NSURL *mp3URL = [NSURL fileURLWithPath:path];
    
    _avAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:mp3URL error:nil];
    _avAudioPlayer.delegate =self;
    _avAudioPlayer.numberOfLoops = 0;
}

- (void)PlayOrPause:(UIButton*)sender{

    if (_stopOrPlay ==NO) {
        [_avAudioPlayer play];
        _stopOrPlay = YES;
        sender.selected = YES;
    }else {
        [_avAudioPlayer stop];
        _stopOrPlay = NO;
        sender.selected = NO;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//增加手势旋转
-(void)addGesture:(UIView *)view{
    self.rspGesture = [[singleGestureRecognizer alloc]initWithTarget:self action:@selector(signalHandler:)];
    [view addGestureRecognizer:_rspGesture];
}

//当旋转时调用此方法并且改变值
-(void)signalHandler:(singleGestureRecognizer *)handler
{
    if (_Play.isSelected){
        //值改变时调用
        handler.view.transform = CGAffineTransformRotate(handler.view.transform, handler.rotation);
        NSLog(@"%f",handler.rotation);
        //快进快退的时间比例
         _showTheQuickOrLow = _showTheQuickOrLow+handler.rotation/(2*M_PI);
        NSLog(@"%f",_showTheQuickOrLow);
        CGFloat now = _progressNow+handler.rotation;
        handler.rotation = 0;
        _progressNow = now;
        _circleView.nowProgress =0;
    [_circleView drawProgress:now];
        
    }
}

-(void)beginfuntion
{
    
    [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_link invalidate];
    _link = nil;
   
}


-(void)endfuntion
{
    [self link];
    
    CGFloat showUp =   _avAudioPlayer.currentTime + _showTheQuickOrLow*_avAudioPlayer.duration;
    _avAudioPlayer.currentTime = showUp;
    _showTheQuickOrLow = 0;

}

- (void)endFailfuntion
{
    [self link];
}
/**
定一个规则：1.一个圆代表总提的进度 2.随mp3的播放 首先改变进度 然后圆圈转的度数＝360*百分比
 圆按照自己的节奏转
**/

//改变百分比
- (void)changeProgress
{
    if (_stopOrPlay){
    [self setLabelOfTime];
    _progressNow = _avAudioPlayer.currentTime/_avAudioPlayer.duration*M_PI*2;
    NSInteger nowProgress = _avAudioPlayer.currentTime/_avAudioPlayer.duration*100;
    NSInteger endProgress = 99;
    if (nowProgress >=endProgress){
        _Play.selected = NO;
        _stopOrPlay =NO;
    }
    if (_Play.isSelected){
        //自己转
        CGFloat angle = M_PI_4 / 60;
        self.singerImgView.transform = CGAffineTransformRotate(self.singerImgView.transform, angle);
        
        //显示进度条
        _circleView.nowProgress = 0;
        [_circleView drawProgress:_progressNow];
    }
    }
}

//显示label

- (void)setLabelOfTime{
    int totalSeconds = _avAudioPlayer.currentTime;
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    int totalSeconds1 = _avAudioPlayer.duration;
    int seconds1= totalSeconds1 % 60;
    int minutes1 = (totalSeconds1 / 60) % 60;
    int hours1 = totalSeconds1 / 3600;
    _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d  %02d:%02d:%02d",hours, minutes, seconds,hours1, minutes1, seconds1];
}






@end
