//
//  Example3ViewController.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "Example3ViewController.h"
#import "Example3Cell.h"

#import "DownloadProgressTableDataSource.h"

@interface Example3ViewController ()

@end


static NSString *CellIdentifier = @"Cell";


@implementation Example3ViewController
{
    NSArray *_urlStrArray;
    NSArray *_nameArray;
    
    DownloadProgressTableDataSource *_dpTableDS;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.2 blue:0.7 alpha:0.4]];
    
    
    _urlStrArray=@[@"http://10.129.32.30/mp3s/1.mp3",
                   @"http://10.129.32.30/mp3s/2.mp3",
                   @"http://10.129.32.30/mp3s/3.mp3",
                   @"http://10.129.32.30/mp3s/4.mp3",
                   @"http://10.129.32.30/mp3s/5.mp3",
                   @"http://10.129.32.30/mp3s/101.mp3"
                   @"http://10.129.32.30/mp3s/6.mp3",
                   @"http://10.129.32.30/mp3s/7.mp3",
                   @"http://10.129.32.30/mp3s/8.mp3",
                   @"http://10.129.32.30/mp3s/9.mp3",
                   @"http://10.129.32.30/mp3s/102.mp3"
                   @"http://10.129.32.30/mp3s/10.mp3",
                   @"http://10.129.32.30/mp3s/11.mp3",
                   @"http://10.129.32.30/mp3s/12.mp3",
                   @"http://10.129.32.30/mp3s/13.mp3",
                   @"http://10.129.32.30/mp3s/14.mp3",
                   @"http://10.129.32.30/mp3s/103.mp3"
                   @"http://10.129.32.30/mp3s/15.mp3",
                   @"http://10.129.32.30/mp3s/16.mp3",
                   @"http://10.129.32.30/mp3s/17.mp3",
                   @"http://10.129.32.30/mp3s/18.mp3",
                   @"http://10.129.32.30/mp3s/19.mp3",
                   @"http://10.129.32.30/mp3s/20.mp3",
                   @"http://10.129.32.30/mp3s/21.mp3",
                   @"http://10.129.32.30/mp3s/22.mp3",
                   @"http://10.129.32.30/mp3s/23.mp3",
                   @"http://10.129.32.30/mp3s/24.mp3",
                   @"http://10.129.32.30/mp3s/25.mp3",
                   @"http://10.129.32.30/mp3s/26.mp3",
                   @"http://10.129.32.30/mp3s/27.mp3",
                   @"http://10.129.32.30/mp3s/28.mp3",
                   @"http://10.129.32.30/mp3s/29.mp3",
                   @"http://10.129.32.30/mp3s/30.mp3",
                   @"http://10.129.32.30/mp3s/31.mp3"];
    
    
    _nameArray=@[@"1.mp3",
                 @"2.mp3",
                 @"3.mp3",
                 @"4.mp3",
                 @"5.mp3",
                 @"101.mp3"
                 @"6.mp3",
                 @"7.mp3",
                 @"8.mp3",
                 @"9.mp3",
                 @"102.mp3"
                 @"10.mp3",
                 @"11.mp3",
                 @"12.mp3",
                 @"13.mp3",
                 @"14.mp3",
                 @"103.mp3"
                 @"15.mp3",
                 @"16.mp3",
                 @"17.mp3",
                 @"18.mp3",
                 @"19.mp3",
                 @"20.mp3",
                 @"21.mp3",
                 @"22.mp3",
                 @"23.mp3",
                 @"24.mp3",
                 @"25.mp3",
                 @"26.mp3",
                 @"27.mp3",
                 @"28.mp3",
                 @"29.mp3",
                 @"30.mp3",
                 @"31.mp3"];

    
    _dpTableDS=[[DownloadProgressTableDataSource alloc]init];
    _dpTableDS.urlStrArray=_urlStrArray;
    _dpTableDS.nameArray=_nameArray;
    
    
    [DownloadProgressTableDataSource setInstanceCellIdentifier:CellIdentifier];
    
    self.tableView.dataSource=_dpTableDS;
    
    [self.tableView registerClass:[Example3Cell class] forCellReuseIdentifier:CellIdentifier];
    
    
    for (int i=0; i<[_urlStrArray count]; i++) {
        NSString *tempTag=[NSString stringWithFormat:@"%i",i];
        [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:_urlStrArray[i] withTag:tempTag withDelegate:self];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//设置单个cell的下载进度和状态
-(void)setCellWithTag:(NSInteger)tagvalue WithStatus:(Example3CelldownloadStatus)downloadStatus WithDownloadProgress:(float)progress
{
    NSInteger tempTag=tagvalue;
    
    //设置对应的cell的下载进度
    [_dpTableDS.progressArray replaceObjectAtIndex:tempTag withObject:[NSNumber numberWithFloat:progress]];
    [_dpTableDS.statusArray replaceObjectAtIndex:tempTag withObject:[NSNumber numberWithInt:downloadStatus]];
    
    //如果对应的cell在可视区域，刷新它
    for(Example3Cell *cell in [self.tableView visibleCells])
    {
        if (cell.tag == tempTag) {
            [cell setDownloadProgress:progress WithStatus:downloadStatus];
            break;
        }
    }
}

//设置单个cell的状态
-(void)setCellWithTag:(NSInteger)tagvalue WithStatus:(Example3CelldownloadStatus)downloadStatus
{
    NSInteger tempTag=tagvalue;
    
    //设置对应的cell的下载进度
    float progress= [[_dpTableDS.progressArray objectAtIndex:tempTag]floatValue];
    [_dpTableDS.statusArray replaceObjectAtIndex:tempTag withObject:[NSNumber numberWithInt:downloadStatus]];
    
    //如果对应的cell在可视区域，刷新它
    for(Example3Cell *cell in [self.tableView visibleCells])
    {
        if (cell.tag == tempTag) {
            [cell setDownloadProgress:progress WithStatus:downloadStatus];
            break;
        }
    }
}



#pragma --mark XXCNFileDownloaderDelegate


-(void)XXCNFileDownloader:(XXCNFileDownloader *)fileDownloader loadWithProgress:(float)progress
{
    
    [self setCellWithTag:[fileDownloader.tag intValue] WithStatus:Example3CelldownloadStatusLoading WithDownloadProgress:progress];
}

-(void)XXCNFileDownloader:(XXCNFileDownloader *)fileDownloader loadFailWithError:(NSError *)error
{
    [self setCellWithTag:[fileDownloader.tag intValue] WithStatus:Example3CelldownloadStatusError];
    
}

-(void)XXCNFileDownloaderLoadComplete:(XXCNFileDownloader *)fileDownloader
{
    NSLog(@"xxxxxxxx:%i",Example3CelldownloadStatusComplete);
    [self setCellWithTag:[fileDownloader.tag intValue] WithStatus:Example3CelldownloadStatusComplete];
    
    [[XXCNDownloadManager sharedDownloadManager]removeDownloadOperationWithTag:fileDownloader.tag];
    
}

-(void)XXCNFileDownloaderPaused:(XXCNFileDownloader *)fileDownloader
{
    [self setCellWithTag:[fileDownloader.tag intValue] WithStatus:Example3CelldownloadStatusPause];
}


#pragma --mark UITableviewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tempTag=[@"" stringByAppendingFormat:@"%li",(long)indexPath.row];
    [[XXCNDownloadManager sharedDownloadManager]stopDownloadOperationWithTag:tempTag];
}


@end
