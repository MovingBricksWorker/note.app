使用`AVAssetWriter`将Replaykit产生的流存储为mp4文件

```objc
#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <ReplayKit/ReplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReplaykitWriter : NSObject

- (void)startRec;
- (void)stopRec;
- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer
                   withType:(RPSampleBufferType)sampleBufferType;
        
@end

NS_ASSUME_NONNULL_END

#import "ReplaykitWriter.h"

@interface ReplaykitWriter ()

@property (nonatomic,strong) AVAssetWriter *assetWriter;
@property (nonatomic,strong) AVAssetWriterInput *videoInput;
@property (nonatomic,strong) AVAssetWriterInput *micInput;
@property (nonatomic,strong) AVAssetWriterInput *appInput;

@property (nonatomic,assign) BOOL videoStarted;

@end

@implementation ReplaykitWriter

- (AVAssetWriterInput *)appInput{
    if (!_appInput) {
        // 音频参数
        NSDictionary *audioCompressionSettings = @{
            AVEncoderBitRatePerChannelKey:@(28000),
            AVFormatIDKey:@(kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey:@(1),
            AVSampleRateKey:@(22050)
        };
        _appInput  = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioCompressionSettings];
    }
    return _appInput;
}

- (AVAssetWriterInput *)micInput{
    if (!_micInput) {
        // 音频参数
        NSDictionary *audioCompressionSettings = @{
            AVEncoderBitRatePerChannelKey:@(28000),
            AVFormatIDKey:@(kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey:@(1),
            AVSampleRateKey:@(22050)
        };
        _micInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioCompressionSettings];
    }
    return _micInput;
}


- (AVAssetWriterInput *)videoInput{
    if (!_videoInput) {
        
        CGSize size = CGSizeMake(720, 1280);//[UIScreen mainScreen].bounds.size;
        // 视频大小
        NSInteger numPixels = size.width * size.height;
        // 像素比
        CGFloat bitsPerPixel = 7.5;
        NSInteger bitsPerSecond = numPixels * bitsPerPixel;
        // 码率和帧率设置
        NSDictionary *videoCompressionSettings = @{
            AVVideoAverageBitRateKey:@(bitsPerSecond),//码率
            AVVideoExpectedSourceFrameRateKey:@(25),// 帧率
            AVVideoMaxKeyFrameIntervalKey:@(15),// 关键帧最大间隔
            AVVideoProfileLevelKey:AVVideoProfileLevelH264BaselineAutoLevel,
            AVVideoPixelAspectRatioKey:@{
                AVVideoPixelAspectRatioVerticalSpacingKey:@(1),
                AVVideoPixelAspectRatioHorizontalSpacingKey:@(1)
            }
        };
        
        // 视频参数
        NSDictionary *videoOutputSettings = @{
            AVVideoCodecKey:AVVideoCodecTypeH264,
            AVVideoScalingModeKey:AVVideoScalingModeResizeAspectFill,
            AVVideoWidthKey:@(size.width),
            AVVideoHeightKey:@(size.height),
            AVVideoCompressionPropertiesKey:videoCompressionSettings
        };
        
        _videoInput  = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoOutputSettings];
        _videoInput.expectsMediaDataInRealTime = true;
    }
    return _videoInput;
}


- (void)startRec{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ReplayKit_%.f.mp4",[NSDate date].timeIntervalSince1970]];
    self.assetWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:fileName] fileType:(AVFileTypeMPEG4) error:nil];
    if ([self.assetWriter canAddInput:self.videoInput]) {
        [self.assetWriter addInput:self.videoInput];
    }
    if ([self.assetWriter canAddInput:self.micInput]) {
        [self.assetWriter addInput:self.micInput];
    }
    if ([self.assetWriter canAddInput:self.appInput]) {
        [self.assetWriter addInput:self.appInput];
    }
}

- (void)stopRec{
    if (self.assetWriter.status == AVAssetWriterStatusWriting) {
        [self.micInput markAsFinished];
        [self.appInput markAsFinished];
        [self.videoInput markAsFinished];
        [self.assetWriter finishWritingWithCompletionHandler:^{
            
        }];
    }
    self.assetWriter = nil;
    self.videoStarted = NO;
}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer
                   withType:(RPSampleBufferType)sampleBufferType {
    switch (sampleBufferType) {
        case RPSampleBufferTypeVideo:{
            // Handle video sample buffer
            
            AVAssetWriterStatus status = self.assetWriter.status;
            if (status == AVAssetWriterStatusFailed || status == AVAssetWriterStatusCompleted || status == AVAssetWriterStatusCancelled) {
                return;
            }
            if (status == AVAssetWriterStatusUnknown) {
                if (CMSampleBufferIsValid(sampleBuffer)) {
                    self.videoStarted = YES;
                    [self.assetWriter startWriting];
                    CMTime time = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
                    [self.assetWriter startSessionAtSourceTime:time];
                }
            }
            if (status == AVAssetWriterStatusWriting ) {
                if (self.videoInput.isReadyForMoreMediaData) {
                    BOOL success = [self.videoInput appendSampleBuffer:sampleBuffer];
                    if (!success) {
                        [self stopRec];
                    }
                }
            }
            
        }
            break;
        case RPSampleBufferTypeAudioApp:{
            // Handle audio sample buffer for app audio
            if (!self.videoStarted) {
                return;
            }
            if (self.appInput.isReadyForMoreMediaData) {
                BOOL success = [self.appInput appendSampleBuffer:sampleBuffer];
                if (!success) {
                    [self stopRec];
                }
            }
            
        }
            break;
        case RPSampleBufferTypeAudioMic:
            // Handle audio sample buffer for mic audio
        {
            if (!self.videoStarted) {
                return;
            }
            if (self.micInput.isReadyForMoreMediaData) {
                BOOL success = [self.micInput appendSampleBuffer:sampleBuffer];
                if (!success) {
                    [self stopRec];
                }
            }
            
            
        }
            break;
            
        default:
            break;
    }
    
}

@end

```

使用Demo如下:
使用麦克风一起录制的话,音频听起来会有点杂音或者是回声

```objc
#import "WGBSaveMp4VideoViewController.h"
#import <ReplayKit/ReplayKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ReplaykitWriter.h"


@interface WGBSaveMp4VideoViewController ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) ReplaykitWriter *fileWriter;

@end

@implementation WGBSaveMp4VideoViewController

- (ReplaykitWriter *)fileWriter{
    if(!_fileWriter){
        _fileWriter = [ReplaykitWriter new];
    }
    return _fileWriter;
}

- (void)setupButtonWithY:(CGFloat)lastY
                   title:(NSString *)title
                  action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, lastY, 200 , 44);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAudioSession];
    [self setupButtonWithY:120 title:@"开始录屏" action:@selector(startRecord)];
    [self setupButtonWithY:180 title:@"停止录屏" action:@selector(stopRecord)];
    
    [self setupButtonWithY:240 title:@"播放音乐" action:@selector(playAudio)];
    [self setupButtonWithY:300 title:@"停止音乐" action:@selector(stopPlayAudio)];

    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = 3.0;
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;

    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(100, 380, 200, 200)];
    demoView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:demoView];
    [demoView.layer addAnimation:rotationAnimation forKey:@"xxxxxsss"];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 500, 200, 21)];
    timeLabel.textColor = [UIColor redColor];
    timeLabel.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];
    [self.view addSubview:timeLabel];
    self.timeLabel = timeLabel;
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction:)];
    link.preferredFramesPerSecond = 1;
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)timerAction:(CADisplayLink *)link{
    static int count = 0;
    self.timeLabel.text = @(count).stringValue;
    count += 1;
}

///播放音频试试
- (void)playAudioTest{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"abc" ofType:@"mp3"];
    NSData *fileData = [NSData dataWithContentsOfFile:path options:NSDataReadingMapped error:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:fileData
                                                          error:nil];
    player.numberOfLoops = HUGE;
    self.audioPlayer = player;
    
    if (player != nil) {
        if ([player prepareToPlay] == YES &&
            [player play] == YES) {
        }
    }
}

- (void)playAudio{
    if (!self.audioPlayer) {
        [self playAudioTest];
    }else{
        [self.audioPlayer play];
    }
}

- (void)stopPlayAudio{
    [self.audioPlayer pause];
}

- (void)setupAudioSession {
    NSError *error = nil;
    // 1、获取音频会话实例。
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 2、设置分类和选项。
    [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDefaultToSpeaker error:&error];
    if (error) {
        NSLog(@"AVAudioSession setCategory error.");
        error = nil;
        return;
    }
    
    // 3、设置模式。
    [session setMode:AVAudioSessionModeVideoRecording error:&error];
    if (error) {
        NSLog(@"AVAudioSession setMode error.");
        error = nil;
        return;
    }
    // 4、激活会话。
    [session setActive:YES error:&error];
    if (error) {
        NSLog(@"AVAudioSession setActive error.");
        error = nil;
        return;
    }
}


- (void)startRecord{
    [self.fileWriter startRec];//这个初始化得提前 回调里不可靠 偶尔会崩溃
    ///开了麦克风的话 感觉会有点回音
    [RPScreenRecorder sharedRecorder].microphoneEnabled = YES;
    [[RPScreenRecorder sharedRecorder] startCaptureWithHandler:^(CMSampleBufferRef  _Nonnull sampleBuffer, RPSampleBufferType bufferType, NSError * _Nullable error) {
        [self.fileWriter processSampleBuffer:sampleBuffer withType:bufferType];
        } completionHandler:^(NSError * _Nullable error) {
            NSLog(@"录屏开启: %@",error);
        }];
}

- (void)stopRecord{
    if(![RPScreenRecorder sharedRecorder].isRecording){
        return;
    }
    [self.fileWriter stopRec];
    [[RPScreenRecorder sharedRecorder] stopCaptureWithHandler:^(NSError * _Nullable error) {
        NSLog(@"停止录屏 %@",error);
    }];
    
}
@end
```