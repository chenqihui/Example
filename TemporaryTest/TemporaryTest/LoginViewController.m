//
//  LoginViewController.m
//  TemporaryTest
//
//  Created by chen on 13-12-10.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "LoginViewController.h"

#import "AsyncSocket.h"

#define PREFIX 10

@interface LoginViewController ()
{
    UITextField *m_name;
    UITextField *m_passworld;
    AsyncSocket *asyncSocket;
}

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    m_name = [[UITextField alloc] initWithFrame:CGRectMake(PREFIX, 10, self.view.width - 20, 30)];
    m_name.placeholder = @"name";
    m_name.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:m_name];
    
    m_passworld = [[UITextField alloc] initWithFrame:CGRectMake(PREFIX, m_name.bottom + 10, m_name.width, m_name.height)];
    m_passworld.placeholder = @"password";
    m_passworld.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:m_passworld];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2.5;
    [btn setTitle:@"LOGIN" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(PREFIX, m_passworld.bottom + 10, m_passworld.width, 30)];
    [btn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    
    [self initSocket];
}

- (void)initSocket
{
    asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *err = nil;
    if(![asyncSocket connectToHost:@"120.132.147.135" onPort:10320 error:&err])
    {
        NSLog(@"Error: %@", err);
    }
}

- (void)login:(UIButton *)btn
{
    NSLog(@"hello");
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu", sock, host, port);
//	NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithCapacity:3];
//	[settings setObject:@"www.paypal.com" forKey:(NSString *)kCFStreamSSLPeerName];
    [sock readDataWithTimeout:1 tag:0];
}

-(void) onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString* aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"===%@",aStr);
    [aStr release];
//    NSData* aData= [@"<xml>我喜欢你<xml>" dataUsingEncoding: NSUTF8StringEncoding];
    NSData* aData= [@"<xml>我喜欢你<xml>" dataUsingEncoding: NSUTF8StringEncoding];
    [sock writeData:aData withTimeout:-1 tag:1];
    [sock readDataWithTimeout:1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didSecure:(BOOL)flag
{
    NSLog(@"onSocket:%p didSecure:YES", sock);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    //断开连接了
    NSLog(@"onSocketDidDisconnect:%p", sock);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewDidUnload
{
    asyncSocket=nil;
}
- (void)dealloc
{
    [asyncSocket release];
    [super dealloc];
}

@end
