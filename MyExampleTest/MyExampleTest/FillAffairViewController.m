//
//  FillAffairViewController.m
//  mobileCRM
//
//  Created by chen on 13-4-26.
//  Copyright (c) 2013年 GuangZhouXuanWu. All rights reserved.
//

#import "FillAffairViewController.h"

#import "InputPanel.h"

@interface CFillAffairViewController ()
{
    NSString *m_szFillcontenttype;

    int m_nImgindex;
    
    BOOL m_bGetFromStorage;
    
    NSNumber* m_nCommenttype;
    
    BOOL m_bKbvisible;
    CGFloat m_nKboffset;
}

@end

@implementation CFillAffairViewController

- (void)dealloc
{
    [m_szTitle release];
    [m_szFillcontenttype release];
    [m_arImgpath release];
    [m_szMessageid release];
    [m_szCircleid release];
    [m_inputPanel release];
    [m_szStreet release];
    [m_szDsname release];
    [m_nCommenttype release];
    [super dealloc];
}

- (void)viewDidLoad
{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStyleDone target:self action:@selector(btnClicked:)];
    
    [self AddKeyboardObserver];
    
    m_arImgpath=[NSMutableArray new];
    
    [self.view setBackgroundColor:BGCOLOR];
    
    CGRect frame=self.view.bounds;
    frame.origin.x+=5;
    frame.origin.y+=49;
    frame.size.height-=54;
    frame.size.width -= 10;
    
//    if (m_nTag.m_nInt == EWordRecordTypeCOMMENT)
//    {
//        m_inputPanel = [[CInputPanel alloc] initWithFrame:frame mode:EInputPadModeNotNeed imagecount:10];
//        m_inputPanel.m_delegate=self;
//        [self.view addSubview:m_inputPanel];
//    }else
//    {
//        NSRange range=[m_szFillcontenttype rangeOfString:@"G"];
//        if(range.location==NSNotFound)
//            m_inputPanel = [[CInputPanel alloc] initWithFrame:frame mode:EInputPadModePhoto imagecount:10];
//        else
//            m_inputPanel = [[CInputPanel alloc] initWithFrame:frame mode:EInputPadModeBoth imagecount:10];
//        
//        m_inputPanel.m_delegate=self;
//        
//        if(range.location!=NSNotFound)
//        {
//            [self StartLoation];
//        }
//        
//        NSRange range2=[m_szFillcontenttype rangeOfString:@"L"];//“L”有表示只拍照，没有才可以获取本地
//        if(range2.location==NSNotFound)
//        {
//            m_inputPanel.m_bGetPhotoFromStorage = YES;
//        }else
//        {
//            m_inputPanel.m_bGetPhotoFromStorage = NO;
//        }
//        [self.view addSubview:m_inputPanel];
//    }
    
    m_inputPanel = [[CInputPanel alloc] initWithFrame:frame mode:EInputPadModeBoth imagecount:10];
    m_inputPanel.m_delegate=self;
    [self.view addSubview:m_inputPanel];
    SETBORDER(m_inputPanel);
    [m_inputPanel setBackgroundColor:[UIColor whiteColor]];
}

-(void)btnClicked:(id)sender
{
}

- (void)AddKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NCKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NCKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NCKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    if ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] > 4)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NCKeyboardFrameWillChange:) name:KEYBOARDFRAMEWILLCHANGE object:nil];
    }
}

- (void)NCKeyboardWillShow:(NSNotification *)noti
{
    [self KeyboardWillShow:noti];
}

- (void)NCKeyboardDidShow:(NSNotification *)noti
{
    [self KeyboardDidShow:noti];
}

- (void)NCKeyboardWillHide:(NSNotification *)noti
{
    [self KeyboardWillHide:noti];
}

- (void)NCKeyboardFrameWillChange:(NSNotification *)noti
{
    [self KeyboardFrameWillChange:noti];
}

//- (void)NCKeyboardFrameDidChange:(NSNotification *)noti
//{
//    [self KeyboardFrameDidChange:noti];
//}

- (BOOL)KeyboardWillShow:(NSNotification *)noti
{
    CGRect frame = [(NSValue *) [[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (YES == m_bKbvisible)
    {
        if (frame.size.height != m_nKboffset)
            [[NSNotificationCenter defaultCenter] postNotificationName:KEYBOARDFRAMEWILLCHANGE object:nil userInfo:[noti userInfo]];
        return NO;
    }
    
    m_nKboffset = frame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^
     {
         [m_inputPanel SetFrameOffset:-m_nKboffset];
     }];
    
    return m_bKbvisible = YES;
}

- (BOOL)KeyboardDidShow:(NSNotification *)noti
{
    CGRect frame1 = [(NSValue *) [[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame2 = [(NSValue *) [[noti userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    BOOL bResult = (frame1.origin.y != frame2.origin.y ? YES : NO);
    
    if (YES == bResult)
    {
        if (frame1.size.height != frame2.size.height)
        {
            //   [[NSNotificationCenter defaultCenter] postNotificationName:KEYBOARDFRAMEDIDCHANGE object:nil userInfo:[noti userInfo]];
            return NO;
        }
    }
    return bResult;
}

- (BOOL)KeyboardWillHide:(NSNotification *)noti
{
    if (NO == m_bKbvisible)
        return NO;
    [UIView animateWithDuration:0.3 animations:^
     {
         [m_inputPanel SetFrameOffset:m_nKboffset];
     }];
    return !(m_bKbvisible = NO);
}

- (BOOL)KeyboardFrameWillChange:(NSNotification *)noti
{
    CGRect frame1 = [(NSValue *) [[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame2 = [(NSValue *) [[noti userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (frame1.size.height != frame2.size.height)
    {
        float nOffset=m_nKboffset;
        [UIView animateWithDuration:0.3 animations:^
         {
             [m_inputPanel SetFrameOffset:nOffset-m_nKboffset];
         }];
        return YES;
    }
    return NO;
}

-(void)TakePhoto:(CInputPanel*)pad
{
}

-(void)GetPhotoFrom:(CInputPanel*)pad
{
}

-(void)PreviewImage:(CInputPanel*)pad index:(int)nIndex
{
    [m_inputPanel.m_textView resignFirstResponder];
    
    m_nImgindex=nIndex;
    
    UIActionSheet* sheet=[[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"查看图片",nil]autorelease];
    [sheet showInView:self.view];
    sheet.tag=20000;
}

-(void)DeleteText:(CInputPanel *)pad
{
    [pad.m_textView setText:@""];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag==10000)
    {
        switch(buttonIndex)
        {
            case 0:
            {
                break;
            }
            case 1:
            {
                break;
            }
            default:
            {
                [m_inputPanel.m_textView becomeFirstResponder];
                break;
            }
        }
    }
    else if(actionSheet.tag==20000)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                break;
            }
            case 1:
            {
                break;
            }
            default:
            {
                [m_inputPanel.m_textView becomeFirstResponder];
                break;
            }
        }
    }
}

-(void)ViewBaseViewControllerClose:(UIViewController *)vcl
{
    [m_inputPanel.m_textView becomeFirstResponder];
}

-(void)ImageOperation:(UIImage*)newimage
{
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self ImageOperation:image];
    
    [m_inputPanel.m_textView becomeFirstResponder];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [m_inputPanel.m_textView becomeFirstResponder];
}

@end
