//
//  MainViewController.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "Example1ViewController.h"

#import "XXCNFileDownloader.h"

@interface Example1ViewController ()

@end

@implementation Example1ViewController

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
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    
    XXCNFileDownloader *fDLoader=[[XXCNFileDownloader alloc]initWidthURLStr:@"http://10.129.32.30/mp3s/1.mp3"];
    [fDLoader startDownload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
