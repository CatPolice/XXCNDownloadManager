//
//  XXCNFileDownLoader.h
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XXCNFileDownloaderDelegate;


//XXCNFileDownloader类
@interface XXCNFileDownloader : NSOperation<NSURLConnectionDelegate>

//下载进程的标示符
@property(nonatomic,strong)NSString *tag;

//本次应该下载的数据的大小
@property(nonatomic,assign)uint64_t expectedDataLength;
//当前已经下载的数据的大小
@property(nonatomic,assign)uint64_t receivedDataLength;

@property(nonatomic,weak)id<XXCNFileDownloaderDelegate> delegate;

//使用下载地址字符串初始化XXCNFileDownloader
-(id)initWidthURLStr:(NSString *)urlstr;

//开始下载
-(void)startDownload;

-(void)cancelOperation;

@end

//XXCNFileDownloader的委托
@protocol XXCNFileDownloaderDelegate <NSObject>

@optional

//下载失败的委托
-(void)XXCNFileDownloader:(XXCNFileDownloader *)fileDownloader loadFailWithError:(NSError *)error;

//下载进度的委托
-(void)XXCNFileDownloader:(XXCNFileDownloader *)fileDownloader loadWithProgress:(float)progress;

//下载成功的委托
-(void)XXCNFileDownloaderLoadComplete:(XXCNFileDownloader *)fileDownloader;

//暂停的下载任务委托
-(void)XXCNFileDownloaderPaused:(XXCNFileDownloader *)fileDownloader;


@end