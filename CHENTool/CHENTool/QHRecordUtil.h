//
// Created by chen on 13-10-28.
// Copyright (c) 2013 User. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

@class QHRecordUtil;

@protocol QHRecordUtilDelegate <NSObject>

@optional

- (void)startWillRecord:(QHRecordUtil *)recordUtil;

- (void)startEndRecord:(QHRecordUtil *)recordUtil;

- (void)finishWillRecord:(QHRecordUtil *)recordUtil;

- (void)finishEndRecord:(QHRecordUtil *)recordUtil;

- (void)stopWillRecord:(QHRecordUtil *)recordUtil;

- (void)stopEndRecord:(QHRecordUtil *)recordUtil;


- (void)playWillAudio:(QHRecordUtil *)recordUtil;

- (void)playEndAudio:(QHRecordUtil *)recordUtil;

- (void)finishWillPlayAudio:(QHRecordUtil *)recordUtil;

- (void)finishEndPlayAudio:(QHRecordUtil *)recordUtil;

- (void)stopWillAudio:(QHRecordUtil *)recordUtil;

- (void)stopEndAudio:(QHRecordUtil *)recordUtil;

@end

@interface QHRecordUtil : NSObject<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    id<QHRecordUtilDelegate> m_delegate;
    AVAudioRecorder *m_avaudiorecord;
    AVAudioPlayer *m_avaudioplayer;
    
    NSTimer *m_timer;
    NSString *m_recordTempPath;
    NSString *m_recordSavePath;
    
    float recordTime;
}

@property (nonatomic, assign) id<QHRecordUtilDelegate> m_delegate;
@property(nonatomic) float recordTime;

- (void)startRecord:(NSString *)szFileName;

- (void)stopRecord:(NSString *)szPath;

- (void)playAudio:(NSString *)szPath;

- (void)stopAudio:(NSString *)szPath;

@end