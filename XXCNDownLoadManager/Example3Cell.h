//
//  Example3Cell.h
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    Example3CelldownloadStatusWaiting,
    Example3CelldownloadStatusPause,
    Example3CelldownloadStatusLoading,
    Example3CelldownloadStatusComplete,
    Example3CelldownloadStatusError
}Example3CelldownloadStatus;

@interface Example3Cell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,assign)Example3CelldownloadStatus downloadStatus;

-(void)setDownloadProgress:(float)progress WithStatus:(Example3CelldownloadStatus)downloadStatus;

@end
