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
    NSMutableDictionary *_operationDictionary;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _downloadQueue = [[NSOperationQueue alloc] init];
        [_downloadQueue setMaxConcurrentOperationCount:2];
        
        _operationDictionary=[[NSMutableDictionary alloc]init];
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

-(XXCNFileDownloader *)downloadURLStr:(NSString *)urlStr withTag:(NSString *)tag withDelegate:(id<XXCNFileDownloaderDelegate>)delegate
{
    XXCNFileDownloader *fileDownloader=[[XXCNFileDownloader alloc]initWidthURLStr:urlStr];
    fileDownloader.delegate=delegate;
    fileDownloader.tag=tag;
    
    [_operationDictionary setObject:fileDownloader forKey:tag];
    
    [_downloadQueue addOperation:fileDownloader];
    
    return fileDownloader;
    
}


//停止某一个正在执行的下载进程
-(void)stopDownloadOperationWithTag:(NSString *)tag
{
    XXCNFileDownloader *fileDownloader=(XXCNFileDownloader *)[_operationDictionary objectForKey:tag];
    
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
