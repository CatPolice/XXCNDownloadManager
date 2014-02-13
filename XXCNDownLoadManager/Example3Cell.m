//
//  Example3Cell.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "Example3Cell.h"

@implementation Example3Cell
{
    UILabel *_progressLabel;
    UIProgressView *_loadProgressView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 3, 90, 50)];
        
        _titleLabel.text=@"";
        
        [self addSubview:_titleLabel];
        
        _loadProgressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        _loadProgressView.frame=CGRectMake(100, 25, 100, 50);
        
        [self addSubview:_loadProgressView];
        
        _progressLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 0, 80, 50)];
        
        _progressLabel.text=@"等待中";
        
        [self addSubview:_progressLabel];
        
        
        self.backgroundColor=[UIColor colorWithRed:0.1 green:0.7 blue:0.2 alpha:0.3];
        
    }
    return self;
}




-(void)setDownloadProgress:(float)progress WithStatus:(Example3CelldownloadStatus)downloadStatus
{
    _downloadStatus=downloadStatus;
    if (_downloadStatus==Example3CelldownloadStatusPause) {
        _progressLabel.text=@"下载暂停";
    }
    else if(_downloadStatus==Example3CelldownloadStatusWaiting)
    {
        _progressLabel.text=@"等待中";
    }
    else if(_downloadStatus==Example3CelldownloadStatusError)
    {
        _progressLabel.text=@"下载失败";
    }
    else if(_downloadStatus==Example3CelldownloadStatusComplete)
    {
        _progressLabel.text=@"下载完成";
    }
    else if(_downloadStatus==Example3CelldownloadStatusLoading)
    {
        _progressLabel.text=[@"" stringByAppendingFormat:@"%.2f%@",progress,@"%"];
    }
    
    
    _loadProgressView.progress=progress/100;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
