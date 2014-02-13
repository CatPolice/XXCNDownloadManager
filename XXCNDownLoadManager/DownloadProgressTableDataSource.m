//
//  DownloadProgressTableDataSource.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-13.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "DownloadProgressTableDataSource.h"

#import "Example3Cell.h"

static NSString *CellIdentifier = @"";

@implementation DownloadProgressTableDataSource

+(void)setInstanceCellIdentifier:(NSString *)cellIdentifier
{
    CellIdentifier=cellIdentifier;
}


-(void)setUrlStrArray:(NSArray *)urlStrArray
{
    _urlStrArray=urlStrArray;
    _progressArray=[[NSMutableArray alloc] init];
    _statusArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[urlStrArray count]; i++) {
        [_progressArray addObject:[NSNumber numberWithFloat:0.0]];
        [_statusArray addObject:[NSNumber numberWithInt:Example3CelldownloadStatusWaiting]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_urlStrArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Example3Cell *cell = (Example3Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell==nil) {
        cell=[[Example3Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.titleLabel.text=_nameArray[indexPath.row];
    cell.tag=indexPath.row;
    float progressValue= [[_progressArray objectAtIndex:indexPath.row] floatValue];
    int downloadStauts=[[_statusArray objectAtIndex:indexPath.row] integerValue];
    [cell setDownloadProgress:progressValue WithStatus:downloadStauts];


    return cell;
}


@end
