//
//  InputPanel.h
//  mobileCRM
//
//  Created by chen on 13-4-27.
//  Copyright (c) 2013年 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INPUTPAD_TOOLBAR_ITEMSIZE 30

#define IMAGE_WIDTH  40
#define GRAYCOLOR [UIColor colorWithRed:153 green:165 blue:181 alpha:1]

@class CInputPanel;
@protocol CInputPanelDelegate <NSObject>

-(void)GetPosition:(CInputPanel*)pad;
-(void)TakePhoto:(CInputPanel*)pad;
-(void)GetPhotoFrom:(CInputPanel*)pad;
-(void)GetMap:(CInputPanel*)pad;
-(void)PreviewImage:(CInputPanel*)pad index:(int)nIndex;
-(void)DeleteText:(CInputPanel*)pad;
@end

typedef  enum{EInputPadModePos = 1,
            EInputPadModePhoto = 2,
            EInputPadModeNotNeed = 4,
            EInputPadModeBoth = (EInputPadModePos|EInputPadModePhoto)
} EInputPadMode;

typedef  enum{EInputPadPosStateInit=0,EInputPadPosStatePosing,EInputPadPosStateFinish,EInputPadPosStateFail}EInputPadPosState;

@interface CInputPanel : UIView<UITextViewDelegate,UIActionSheetDelegate, UIScrollViewDelegate>
{
    UITextView* m_textView;
    UIButton* m_btnTakePhoto;
    UIButton* m_btnPosition;
    NSMutableArray* m_arImages;
    id<CInputPanelDelegate> m_delegate;
    int m_nImageCountMax;
    EInputPadMode m_mode;
    EInputPadPosState m_posState;
    UIActivityIndicatorView* m_progress;
    UILabel* m_labelAddress;
    UIImageView* m_addressImage;
    
    UIView* m_showImageView;
    UIButton* m_addPhoneBtn;
    
    UIScrollView *m_scroll;
    
    BOOL m_bGetPhotoFromStorage;
    
    UILabel *m_textPlaceholder;
}

@property(nonatomic,assign)id<CInputPanelDelegate> m_delegate;
@property(nonatomic,readonly) UITextView* m_textView;
@property(nonatomic,assign)EInputPadPosState m_posState;

@property(nonatomic,readonly) UIView* m_showImageView;

@property(nonatomic,readonly) EInputPadMode m_mode;

@property(nonatomic,assign)BOOL m_bGetPhotoFromStorage;

- (id)initWithFrame:(CGRect)frame mode:(EInputPadMode)mode imagecount:(unsigned int)count;

-(void)SetFrameOffset:(CGFloat)offsetHeight;

-(void)AddImage:(UIImage*)image;

-(void)DeleteImage:(int)nIndex;

-(void)SetPositionStatePosing;

-(void)PositionFinish:(BOOL)bSuccess address:(NSString*)address;

@end
