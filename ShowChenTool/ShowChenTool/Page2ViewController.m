//
//  Page2ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-9-17.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Page2ViewController.h"

@interface Page2ViewController ()

@end

@implementation Page2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    NSURL *url = [NSURL URLWithString:@"http://120.132.147.135:10320"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"Public Timeline: %@", JSON);
//    } failure:nil];
//    [operation start];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
    AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
//    operation.inputStream = [NSInputStream inputStreamWithFileAtPath:[[NSBundle mainBundle] pathForResource:@"large-image" ofType:@"tiff"]];
    operation.outputStream = [NSOutputStream outputStreamToMemory];
    [operation start];
    NSLog(@"%@", operation.outputStream);
    
    NSString *s = [self test];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:web];
//    [web loadHTMLString:s baseURL:nil];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    [web loadHTMLString:s baseURL:url];//直接读取html，后面的参数是基于什么url，从而进行跳转
//    [web loadRequest:[NSURLRequest requestWithURL:url]];//直接读取url
    
    UITextView *tx = [[UITextView alloc] initWithFrame:self.view.bounds];
    //http://blog.csdn.net/arthurchenjs/article/details/6448193
    /*
     虽然苹果公司正式从UITextView类中删除了HTML支持，但它仍然隐藏在UIKit框架中。当希望添加简单的富文本扩展时，可以访问这项文 档中未记录的特性。显然，苹果公司希望你使用UIWebView而不是UITextView来进行HTML显示，不过UITextView提供了更吸引人的特性。
     
     要访问此HTML显示，需要声明setContentToHTMLString:方法。这个文档中未记录的UITextView方法告知文本视图将一个字符串解释为HTML源。使用UITextView有以下两个好处。
     
     UITextView可以被编辑。你可以使用HTML文本初始化视图，并允许用户编辑结果。文本会选择周围元素的属性作为自己的属性。例如，如果向一个粗体标题行添加文本，新的文本也是粗体的。
     
     第二，UITextView可以很容易地被重新加载。例如，如果你允许用户在基于文本的源的模式中编辑文本，可以在HTML模式中把这些更改重新加载到相同的视图中。
     
     下图显示了相同的UITextView中的文本源和HTML表示。这并不是技术的通常用法 （或实际用法），不过它突出了一项以后会用到的功能。通常，你只希望用一些富文本功能（如粗体的标题行）来初始化文本，然后允许用户直接编辑该文本。
     */
    [tx setContentToHTMLString:s];
    [self.view addSubview:tx];
}

- (NSString *)test
{
    //prepar
    NSString *urlString = [NSString stringWithFormat:@"http://www.baidu.com/"];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
    [request setHTTPMethod:@"GET"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<xml>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<yourcode/>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</xml>"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //post
//    [request setHTTPBody:postBody];
    
    //get response
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %d", [urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);
        
        //here you get the response
    }
    return result;
}

@end
