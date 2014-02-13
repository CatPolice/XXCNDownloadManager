//
//  Example2ViewController.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "Example2ViewController.h"

@interface Example2ViewController ()

@end

@implementation Example2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.7 blue:0.3 alpha:0.4]];
    
    
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"1.mp3" withTag:@"1" withDelegate:self];
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"2.mp3" withTag:@"2" withDelegate:self];
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"3.mp3" withTag:@"3" withDelegate:self];
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"88.mp3" withTag:@"4" withDelegate:self];
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"4.mp3" withTag:@"5" withDelegate:self];
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"5.mp3" withTag:@"6" withDelegate:self];
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"6.mp3" withTag:@"7" withDelegate:self];
    
    [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:@"7.mp3" withTag:@"8" withDelegate:self];
    
}


-(void)XXCNFileDownloaderLoadComplete:(XXCNFileDownloader *)fileDownloader
{
    NSLog(@"tag:%@",fileDownloader.tag);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}




@end
