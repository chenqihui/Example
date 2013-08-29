//
//  FillAffairViewController.h
//  mobileCRM
//
//  Created by chen on 13-4-26.
//  Copyright (c) 2013年 GuangZhouXuanWu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "InputPanel.h"

#define KEYBOARDFRAMEWILLCHANGE         @"KBWFC"

#define BGCOLOR [UIColor colorWithRed:225 green:225 blue:225 alpha:1]

#define SETBORDER(view) view.layer.borderColor = [UIColor colorWithRed:206 green:206 blue:206 alpha:1].CGColor;view.layer.borderWidth = 1;view.layer.masksToBounds = YES;view.layer.cornerRadius = 2.5;

@interface CFillAffairViewController : UIViewController<CInputPanelDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{

    CInputPanel *m_inputPanel;
    NSString *m_szMessageid;
    NSString *m_szCircleid;
    NSString *m_szTitle;
    NSMutableArray *m_arImgpath;
    NSString *m_szStreet;

    NSString *m_szDsname;
}

@end
