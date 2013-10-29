//
// Created by chen on 13-10-28.
// Copyright (c) 2013 User. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "QHRecordUtil.h"

#define TIME_UPDATE_   1

@implementation QHRecordUtil

@synthesize m_delegate;
@synthesize recordTime;

- (void)dealloc
{
    [m_recordTempPath release];
    [m_recordSavePath release];
    [self finishRecord];
    [self stopAudio];
    [super dealloc];
}

- (void)startRecord:(NSString *)szFileName
{
    if([m_delegate respondsToSelector:@selector(startWillRecord:)])
        [m_delegate startWillRecord:self];
    
    if (szFileName != nil)
    {
        m_recordSavePath = szFileName;
    }else
    {
        m_recordSavePath = @"sound.wav";
    }
    m_recordTempPath = [[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", m_recordSavePath]] retain];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    m_recordSavePath = [[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", m_recordSavePath]] retain];
    
    NSError * err = nil;
    
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setCategory :AVAudioSessionCategoryRecord error:&err];
    
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
    
	[audioSession setActive:YES error:&err];
    
	err = nil;
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
    
    NSMutableDictionary* dicRecordsetting=[[NSMutableDictionary new] autorelease];
    [dicRecordsetting setObject:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    [dicRecordsetting setObject:[NSNumber numberWithInt:16] forKey:AVEncoderBitRateKey];
    [dicRecordsetting setObject:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [dicRecordsetting setObject:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];//8000:22100.0
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:m_recordTempPath])
    {
        [fileManager removeItemAtPath:m_recordTempPath error:nil];
    }
    NSURL* url=[NSURL fileURLWithPath:m_recordTempPath];
    
    if(m_avaudiorecord)
    {
        [m_avaudiorecord stop];
        m_avaudiorecord = nil;
    }
    NSError *error = nil;
    m_avaudiorecord = [[AVAudioRecorder alloc] initWithURL:url settings:dicRecordsetting error:&error];
    m_avaudiorecord.meteringEnabled = YES;
    if ([m_avaudiorecord prepareToRecord] == YES)
    {
        m_avaudiorecord.meteringEnabled = YES;
        [m_avaudiorecord record];
    }
    else
    {
        int errorCode = CFSwapInt32HostToBig ([error code]);
#if DEBUG
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
#endif
    }
    m_avaudiorecord.delegate = self;
	
	[m_avaudiorecord recordForDuration:(NSTimeInterval) 60];
    
    self.recordTime = 0;
    [self resetTimer];
    
	m_timer = [NSTimer scheduledTimerWithTimeInterval:TIME_UPDATE_ target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    
    [self showVoiceHudOrHide:YES];

}

- (void)finishRecord
{
    if(m_avaudiorecord.isRecording)
    {
        [m_avaudiorecord stop];
    }
    if(m_avaudiorecord != nil)
    {
        [m_avaudiorecord release];
        m_avaudiorecord = nil;
    }
    [self resetTimer];
    [self showVoiceHudOrHide:NO];
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (void)stopRecord:(NSString *)szPath
{
    if([m_delegate respondsToSelector:@selector(stopWillRecord:)])
        [m_delegate stopWillRecord:self];
    
    [self finishRecord];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:m_recordTempPath])
    {
        [fileManager removeItemAtPath:m_recordTempPath error:nil];
    }
    
    if([m_delegate respondsToSelector:@selector(stopEndRecord:)])
        [m_delegate stopEndRecord:self];
}

- (void)playAudio:(NSString *)szPath
{
    if([m_delegate respondsToSelector:@selector(playWillAudio:)])
        [m_delegate playWillAudio:self];
    
    [self stopAudio];
    
    m_recordSavePath = szPath;
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    NSURL* url=[NSURL fileURLWithPath:m_recordSavePath];
    m_avaudioplayer=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    m_avaudioplayer.delegate=self;
    m_avaudioplayer.numberOfLoops=0;
    [m_avaudioplayer play];
    
    if([m_delegate respondsToSelector:@selector(playEndAudio:)])
        [m_delegate playEndAudio:self];
}

- (void)stopAudio
{
    if(m_avaudioplayer.isPlaying)
    {
        [m_avaudioplayer stop];
    }
    if(m_avaudioplayer != nil)
    {
        [m_avaudioplayer release];
        m_avaudioplayer = nil;
    }
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (void)stopAudio:(NSString *)szPath
{
    if([m_delegate respondsToSelector:@selector(stopWillAudio:)])
        [m_delegate stopWillAudio:self];
    
    [self stopAudio];
    
    if([m_delegate respondsToSelector:@selector(stopEndAudio:)])
        [m_delegate stopEndAudio:self];
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if([m_delegate respondsToSelector:@selector(finishEndRecord:path:)])
        [m_delegate finishEndRecord:self path:m_recordSavePath];
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self stopAudio];
    
    if([m_delegate respondsToSelector:@selector(finishEndPlayAudio:)])
        [m_delegate finishEndPlayAudio:self];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
#if DEBUG
    NSLog(@"%@", error);
#endif
}

#pragma mark - Timer Update

- (void)updateMeters
{
    recordTime += TIME_UPDATE_;
    
    if (m_recordHud)
    {
        /*  发送updateMeters消息来刷新平均和峰值功率。
         *  此计数是以对数刻度计量的，-160表示完全安静，
         *  0表示最大输入值
         */
        
        if (m_avaudiorecord) {
            [m_avaudiorecord updateMeters];
        }
        
        float peakPower = [m_avaudiorecord averagePowerForChannel:0];
        double ALPHA = 0.05;
        double peakPowerForChannel = pow(10, (ALPHA * peakPower));
        
        [m_recordHud setProgress:peakPowerForChannel];
    }
}

#pragma mark - Helper Function

-(void) showVoiceHudOrHide:(BOOL)yesOrNo{
    
    if (m_recordHud) {
        [m_recordHud hide];
        m_recordHud = nil;
    }
    
    if (yesOrNo) {
        
        m_recordHud = [[QHRecordHud alloc] init];
        [m_recordHud show];
        [m_recordHud release];
        
    }else{
        
    }
}

-(void) resetTimer
{
    if (m_timer)
    {
        [m_timer invalidate];
//        [m_timer release];
        m_timer = nil;
    }
}

@end