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
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _downloadQueue = [[NSOperationQueue alloc] init];
        [_downloadQueue setMaxConcurrentOperationCount:3];
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
    
    [_downloadQueue addOperation:fileDownloader];
    
    return fileDownloader;
    
}

@end
