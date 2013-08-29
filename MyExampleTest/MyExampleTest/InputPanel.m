//
//  InputPanel.m
//  mobileCRM
//
//  Created by chen on 13-4-27.
//  Copyright (c) 2013年 GuangZhouXuanWu. All rights reserved.
//
#define INPUTPAD_TOOLBAR_HEIGHT 50
#define INPUTPAD_MARGINS 10
#define INPUTPAD_CTRLSPACING 5

#define INPUTPAD_IMAGE_MAX 8

#import "InputPanel.h"

@implementation CInputPanel

@synthesize m_textView, m_delegate, m_posState;
@synthesize m_showImageView;
@synthesize m_mode;
@synthesize m_bGetPhotoFromStorage;

UIKIT_STATIC_INLINE CGRect CGRectrfMake(float nX,float nY,float nWidth,float nHeight)
{
    return CGRectMake(rintf(nX),rintf(nY),rintf(nWidth),rintf(nHeight));
}

- (void)dealloc
{
    [m_textView release];
    [m_btnTakePhoto release];
    [m_btnPosition release];
    [m_labelAddress release];
    [m_progress release];
    [m_addressImage release];
    [m_arImages release];
    
    [m_showImageView release];
    m_addPhoneBtn = nil;
    
    [m_scroll release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        m_textView=[[UITextView alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height - 15)];
//        m_textView.delegate=self;
        m_textView.backgroundColor=[UIColor clearColor];
        m_textView.font=[UIFont systemFontOfSize:15];
        [self addSubview:m_textView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame mode:(EInputPadMode)mode imagecount:(unsigned int)count
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        m_bGetPhotoFromStorage = YES;
        
        m_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        m_scroll.contentSize = CGSizeMake(m_scroll.frame.size.width, m_scroll.frame.size.height);
        [m_scroll setAlwaysBounceVertical:YES];
        m_scroll.delegate = self;
        
        CGSize s = [@"国" sizeWithFont:[UIFont systemFontOfSize:15]];
        
        m_textPlaceholder=[[UILabel alloc] initWithFrame:CGRectMake(8, 3, frame.size.width, s.height + 5)];
        m_textPlaceholder.userInteractionEnabled = NO;
        m_textPlaceholder.backgroundColor=[UIColor clearColor];
        m_textPlaceholder.font=[UIFont systemFontOfSize:15];
        m_textPlaceholder.text = @"请输入内容...";
        m_textPlaceholder.textColor = GRAYCOLOR;
        [self addSubview:m_textPlaceholder];
        
        m_mode=mode;
        m_nImageCountMax=count>INPUTPAD_IMAGE_MAX?INPUTPAD_IMAGE_MAX:count;
        m_textView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, s.height + 5)];
        m_textView.delegate=self;
        m_textView.scrollEnabled = NO;
        m_textView.backgroundColor=[UIColor clearColor];
        m_textView.font=[UIFont systemFontOfSize:15];
//        m_textView.returnKeyType = UIReturnKeyDone;
        [m_scroll addSubview:m_textView];
        
        m_showImageView = [[UIView alloc] initWithFrame:CGRectMake(0, m_textView.frame.origin.y + m_textView.frame.size.height + 10, 0, 0)];
        [m_scroll insertSubview:m_showImageView belowSubview:m_textView];
        
        [self addSubview:m_scroll];
        
        if ((m_mode&EInputPadModePhoto) == EInputPadModePhoto)
        {
            m_btnTakePhoto=[[UIButton alloc] initWithFrame:CGRectMake(10, frame.size.height-(INPUTPAD_TOOLBAR_ITEMSIZE+INPUTPAD_MARGINS), INPUTPAD_TOOLBAR_ITEMSIZE, INPUTPAD_TOOLBAR_ITEMSIZE)];
            [m_btnTakePhoto setImage:[UIImage imageNamed:@"input_btn_photo.png"] forState:UIControlStateNormal];
            [m_btnTakePhoto addTarget:self action:@selector(TakePhoto:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:m_btnTakePhoto];
            m_arImages=[[NSMutableArray alloc] init];
        }
        
        if ((m_mode&EInputPadModePos) == EInputPadModePos)
        {
            m_posState=EInputPadPosStateInit;
            m_btnPosition=[[UIButton alloc] initWithFrame:CGRectMake(m_btnTakePhoto.frame.origin.x + m_btnTakePhoto.frame.size.width + 10, frame.size.height-(INPUTPAD_TOOLBAR_ITEMSIZE+INPUTPAD_MARGINS), INPUTPAD_TOOLBAR_ITEMSIZE, INPUTPAD_TOOLBAR_ITEMSIZE)];
            [m_btnPosition setImage:[UIImage imageNamed:@"img_locate.png"] forState:UIControlStateNormal];
            [m_btnPosition addTarget:self action:@selector(GetPosition:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:m_btnPosition];
            m_progress=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [m_progress setFrame:m_btnPosition.frame];
            m_progress.hidesWhenStopped=YES;
            [self addSubview:m_progress];
            
            m_addressImage=[[UIImageView alloc] initWithFrame:CGRectrfMake(0, CGRectGetMinY(m_btnPosition.frame)-22, 0, 25)];
            m_labelAddress=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
            [m_labelAddress setBackgroundColor:[UIColor clearColor]];
            m_labelAddress.textAlignment=NSTextAlignmentLeft;
            m_labelAddress.font=[UIFont systemFontOfSize:13];
            [m_addressImage addSubview:m_labelAddress];
            [self addSubview:m_addressImage];
            [m_addressImage setHidden:YES];
        }else if ((m_mode&EInputPadModePhoto) == EInputPadModePhoto)
        {
            m_btnPosition=[[UIButton alloc] initWithFrame:CGRectMake(m_btnTakePhoto.frame.origin.x + m_btnTakePhoto.frame.size.width + 10, frame.size.height-(INPUTPAD_TOOLBAR_ITEMSIZE+INPUTPAD_MARGINS), INPUTPAD_TOOLBAR_ITEMSIZE, INPUTPAD_TOOLBAR_ITEMSIZE)];
            m_addressImage=[[UIImageView alloc] initWithFrame:CGRectrfMake(0, CGRectGetMinY(m_btnPosition.frame), 0, 5)];
        }
        
        [m_textView becomeFirstResponder];
    }
    return self;
}

-(void)SetFrameOffset:(CGFloat)offsetHeight
{
    CGRect padFrame=self.frame;
    CGFloat offsetY=offsetHeight;
    padFrame.size.height+=offsetY;
    [self setFrame:padFrame];
    CGRect frame;
    if(nil!=m_btnTakePhoto)
    {
        frame=m_btnTakePhoto.frame;
        frame.origin.y+=offsetY;
        [m_btnTakePhoto setFrame:frame];
    }
    if(nil!=m_btnPosition)
    {
        frame=m_btnPosition.frame;
        frame.origin.y+=offsetY;
        [m_btnPosition setFrame:frame];
        frame=m_addressImage.frame;
        frame.origin.y+=offsetY;
        [m_addressImage setFrame:frame];
        frame=m_progress.frame;
        frame.origin.y+=offsetY;
        [m_progress setFrame:frame];
    }
    [m_scroll setContentSize:CGSizeMake(m_scroll.frame.size.width, padFrame.size.height)];
    [m_textView setContentOffset:CGPointMake(m_textView.frame.origin.x, 0)];
    if (m_showImageView.frame.origin.y + m_showImageView.frame.size.height > padFrame.size.height)
        m_scroll.contentSize = CGSizeMake(m_scroll.contentSize.width, m_showImageView.frame.origin.y + m_showImageView.frame.size.height);
    else
        m_scroll.contentSize = CGSizeMake(m_scroll.contentSize.width, padFrame.size.height);
    
    [self chage:m_textView Height:-offsetHeight];
}

-(void)ClearTextview:(id)sender
{
    [m_delegate DeleteText:self];
}

-(void)GetPosition:(id)sender
{
    [m_delegate GetPosition:self];
}

-(void)SetPositionStatePosing
{
    m_posState=EInputPadPosStatePosing;
    [m_btnPosition setHidden:YES];
    [m_progress startAnimating];
}

-(void)AddImage:(UIImage*)image
{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(m_btnTakePhoto.frame.origin.x, m_btnTakePhoto.frame.origin.y+50, IMAGE_WIDTH, IMAGE_WIDTH);
    
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ImageClick:) forControlEvents:UIControlEventTouchUpInside];
    [m_arImages addObject:btn];
    [m_showImageView addSubview:btn];
    if(m_arImages.count==m_nImageCountMax)
    {
        [m_btnTakePhoto setImage:[UIImage imageNamed:@"input_btn_photo_finish.png"] forState:UIControlStateNormal];
        [m_btnTakePhoto setEnabled:NO];
    }
    int sum = (self.frame.size.width - 10)/(IMAGE_WIDTH + 5);
    int t = (m_arImages.count - 1)/sum;
    int d = fmodf(m_arImages.count - 1, sum);
    CGRect frame = CGRectMake((IMAGE_WIDTH + 10)*d + 5, (IMAGE_WIDTH + 10)*t + 5, IMAGE_WIDTH, IMAGE_WIDTH);
    [UIView animateWithDuration:0.7 animations:^
     {
         [btn setFrame:frame];
         
     } completion:^(BOOL finished) {
         if(t == 0)
         {
             [m_showImageView setFrame:CGRectMake(m_showImageView.frame.origin.x, m_showImageView.frame.origin.y, btn.frame.size.width + btn.frame.origin.x, btn.frame.origin.y + btn.frame.size.height)];
         }
         
         [self addPhoneBtn:frame];
     }];
}

- (void)addPhoneBtn:(CGRect)frames
{
    if (m_addPhoneBtn == nil)
    {
        m_addPhoneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        m_addPhoneBtn.frame=CGRectMake(m_btnTakePhoto.frame.origin.x, m_btnTakePhoto.frame.origin.y+50, IMAGE_WIDTH, IMAGE_WIDTH);
        m_addPhoneBtn.frame = frames;
        
        [m_addPhoneBtn setBackgroundImage:[UIImage imageNamed:@"btn_addmember.png"] forState:UIControlStateNormal];
        [m_addPhoneBtn addTarget:self action:@selector(TakePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [m_showImageView insertSubview:m_addPhoneBtn belowSubview:[m_arImages lastObject]];
    }
    
    int sum = (self.frame.size.width - 10)/(IMAGE_WIDTH + 5);
    int t = m_arImages.count/sum;
    int d = fmodf(m_arImages.count, sum);
    CGRect frame = CGRectMake((IMAGE_WIDTH + 10)*d + 5, (IMAGE_WIDTH + 10)*t + 5, IMAGE_WIDTH, IMAGE_WIDTH);
    [UIView animateWithDuration:0.4 animations:^
     {
         [m_addPhoneBtn setFrame:frame];
         
     } completion:^(BOOL finished) {
         if(t == 0)
         {
             [m_showImageView setFrame:CGRectMake(m_showImageView.frame.origin.x, m_showImageView.frame.origin.y, m_addPhoneBtn.frame.size.width + m_addPhoneBtn.frame.origin.x, m_addPhoneBtn.frame.origin.y + m_addPhoneBtn.frame.size.height)];
         }
         
         m_scroll.contentSize = CGSizeMake(m_scroll.contentSize.width, m_showImageView.frame.origin.y + m_showImageView.frame.size.height);
     }];
    
    if(m_arImages.count==m_nImageCountMax)
    {
        [m_addPhoneBtn setAlpha:0];
    }
}

-(void)TakePhoto:(id)sender
{
    if (m_bGetPhotoFromStorage)
    {
        UIActionSheet* sheet=[[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"图库获取",nil]autorelease];
        [sheet showInView:((UIViewController*)m_delegate).view];
        sheet.tag=30000;
    }else
    {
        [m_delegate TakePhoto:self];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag==30000)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                [m_delegate TakePhoto:self];
                break;
            }
            case 1:
            {
                [m_delegate GetPhotoFrom:self];
                break;
            }
            default:
            {
                break;
            }
        }
    }
}

-(void)ImageClick:(id)sender
{
    int nIndex=[m_arImages indexOfObject:sender];
    [m_delegate PreviewImage:self index:nIndex];
}

-(void)PositionFinish:(BOOL)bSuccess address:(NSString*)address
{
}

- (void)chage:(UITextView *)textView Height:(int)height
{
    CGRect frame = m_textView.frame;
    CGSize size = [m_textView.text sizeWithFont:m_textView.font
                              constrainedToSize:CGSizeMake(m_textView.frame.size.width - 10, INT_MAX)
                                  lineBreakMode:NSLineBreakByTruncatingTail];
    if (size.height + 5 > m_textView.frame.size.height - height && textView.text.length > 0)
    {
        frame.size.height = size.height + 5;
        m_textView.frame = frame;
        [m_showImageView setFrame:CGRectMake(m_showImageView.frame.origin.x, m_textView.frame.origin.y + m_textView.frame.size.height + 10, m_showImageView.frame.size.width, m_showImageView.frame.size.height)];
        if ((m_mode&EInputPadModeNotNeed) == EInputPadModeNotNeed)
        {
            if (m_textView.frame.size.height > m_scroll.frame.size.height)
            {
                m_scroll.contentSize = CGSizeMake(m_scroll.contentSize.width, m_showImageView.frame.origin.y + m_showImageView.frame.size.height);
            }
        }else
        {
            if (m_textView.frame.size.height > m_addressImage.frame.origin.y)
            {
                m_scroll.contentSize = CGSizeMake(m_scroll.contentSize.width, m_showImageView.frame.origin.y + m_showImageView.frame.size.height);
                if([m_textView selectedRange].location < m_textView.text.length)
                    return;
                
                //            [m_scroll setContentOffset:CGPointMake(0, m_textView.height - m_addressImage.top) animated:YES];
                [m_scroll setContentOffset:CGPointMake(0, m_textView.frame.size.height - (m_addressImage.frame.size.height>0 ? m_addressImage.frame.origin.y : (m_btnTakePhoto.frame.size.height>0 ? m_btnTakePhoto.frame.origin.y : 0))) animated:YES];
                m_scroll.bouncesZoom = NO;
            }
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0)
        m_textPlaceholder.alpha = 1;
    else
        m_textPlaceholder.alpha = 0;
    [self chage:textView Height:0];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0)
    {
        m_textPlaceholder.alpha = 1;
    }
}

-(void)DeleteImage:(int)nIndex
{
    [m_btnTakePhoto setImage:[UIImage imageNamed:@"input_btn_photo.png"] forState:UIControlStateNormal];
    [m_btnTakePhoto setEnabled:YES];
    
    if(m_addPhoneBtn.alpha==0)
    {
        [m_addPhoneBtn setAlpha:1];
    }
    UIButton* btn=[m_arImages objectAtIndex:nIndex];
    CGRect frame = btn.frame;
    for (int i=nIndex;i<=m_arImages.count-1;i++)
    {
        UIButton* image=[m_arImages objectAtIndex:i];
        CGRect newFrame = image.frame;
        image.frame = frame;
        frame = newFrame;
    }
    [btn removeFromSuperview];
    [m_arImages removeObjectAtIndex:nIndex];
    [self removePhoneBtn:frame];
}

- (void)removePhoneBtn:(CGRect)frame
{
}

#pragma UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     [m_textView resignFirstResponder];
}

@end
