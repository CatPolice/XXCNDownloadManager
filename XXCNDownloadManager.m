//
//  XXCNDownloadManager.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "XXCNDownloadManager.h"


@implementation XXCNDownloadManager
{
    NSOperationQueue *_downloadQueue;
    
    //所有列队中的线程
    NSMutableDictionary *_operationDictionary;
    
    //所有失败和暂停的任务线程中已经下载到的数据量，用于断点续传
    NSMutableDictionary *_receviedBytesArray;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _downloadQueue = [[NSOperationQueue alloc] init];
        [_downloadQueue setMaxConcurrentOperationCount:2];
        
        _operationDictionary=[[NSMutableDictionary alloc]init];
        _receviedBytesArray=[[NSMutableDictionary alloc]init];
    }
    return self;
}

+ (instancetype)sharedDownloadManager {
    static dispatch_once_t onceToken;
    static id sharedManager = nil;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}


-(NSInteger)currentOperationCount
{
    return [_downloadQueue operationCount];
}

//开始一个下载任务，是否为断点续传根据已经接收到的数据length。  0是新的下载，否则是一个断点续传
-(void)downloadURLStr:(NSString *)urlStr withTag:(NSString *)tag withDelegate:(id<XXCNFileDownloaderDelegate>)delegate
{
    
    XXCNFileDownloader *fileDownloader=[[XXCNFileDownloader alloc]initWidthURLStr:urlStr];
    fileDownloader.delegate=delegate;
    fileDownloader.tag=tag;
    
    uint64_t receivedLength=0.0;
    if ([_receviedBytesArray valueForKey:tag]!=nil) {
        receivedLength=[[_receviedBytesArray valueForKey:tag] longLongValue];
    }
    
    fileDownloader.receivedDataLength=receivedLength;
    
    
    [_operationDictionary setObject:fileDownloader forKey:tag];
    
    [_downloadQueue addOperation:fileDownloader];
}


//停止某一个正在执行的下载进程
-(void)stopDownloadOperationWithTag:(NSString *)tag
{
    XXCNFileDownloader *fileDownloader=(XXCNFileDownloader *)[_operationDictionary objectForKey:tag];
    [_receviedBytesArray setValue:[NSNumber numberWithLongLong:fileDownloader.receivedDataLength] forKey:tag];
    [fileDownloader cancelOperation];
    
   
}

//删除某个已经正确下载完毕的进程
-(void)removeDownloadOperationWithTag:(NSString *)tag
{
    [_operationDictionary removeObjectForKey:tag];
    
    NSLog(@"未完成的下载任务数:%lu",(unsigned long)[_operationDictionary count]);
    
    int taskNum=(int)[_downloadQueue operationCount]-1;
    
    NSLog(@"列队中的下载任务数1:%i",taskNum);
}


@end
