//
//  XXCNFileDownLoader.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "XXCNFileDownloader.h"

const NSTimeInterval kDefaultTimeoutInterval=30.0;

@implementation XXCNFileDownloader
{
    //下载的文件的url地址字符串
    NSString *_urlStr;
    
    //下载文件的NSURLConnection
    NSURLConnection *_connection;
    
    //本次是否为断点续传
    BOOL _isResume;
    
    //本下载进程是否已经在进行中（进行中和还在等待中的进程，取消操作需要使用不同的方法）
    BOOL _operationStarted;
    
    BOOL finished;
    BOOL executing;
    BOOL cancelled;
}

-(id)initWidthURLStr:(NSString *)urlstr
{
    self=[super init];
    if (self) {
        
        finished=NO;
        executing=NO;
        cancelled=NO;
        
        _urlStr=urlstr;
        
        _expectedDataLength=0;
        
        _receivedDataLength=0;
        
    }
    return self;
}

-(void)startDownload
{
    [self start];
}

#pragma mark --override NSOPeration

//NSOperation的子类，如果并发操作必须重写此方法
-(void)start
{
    
    NSMutableURLRequest *fileRequest =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:kDefaultTimeoutInterval];
    
    if (_receivedDataLength!=0) {
        _isResume=YES;
        NSString *range = [NSString stringWithFormat:@"bytes=%lld-", _receivedDataLength];
        [fileRequest setValue:range forHTTPHeaderField:@"Range"];
    }
    
    _connection=[[NSURLConnection alloc]initWithRequest:fileRequest delegate:self startImmediately:NO];
    
    
    if (_connection) {
        [_connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                   forMode:NSDefaultRunLoopMode];
        
        if ([self isCancelled]){
            [self willChangeValueForKey:@"isFinished"];
            finished = YES;
            [self didChangeValueForKey:@"isFinished"];
            return;
        } else {
            
            [self willChangeValueForKey:@"isExecuting"];
            executing = YES;
            [_connection start];
            
            _operationStarted=YES;
            
            [self didChangeValueForKey:@"isExecuting"];
            
        }
    }
    
    
    NSLog(@"start:%@",_tag);
}

//是否并发操作
-(BOOL)isConcurrent
{
    return YES;
}
//线程是否操释放掉,不重写这个方法，线程内存无法释放
- (BOOL) isFinished{
    
    return finished;
}

//线程是否还在执行操作
- (BOOL) isExecuting{
    
    return executing;
}


//线程是否被取消，不重写这个方法，线程操作无法被取消
-(BOOL)isCancelled
{
    return cancelled;
}




#pragma mark --NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"XXCNFileDownloader didFailWithError");
    if (self.delegate && [self.delegate respondsToSelector:@selector(XXCNFileDownloader:loadFailWithError:)]) {
        [self.delegate XXCNFileDownloader:self loadFailWithError:error];
    }
    [self finishOperation];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _receivedDataLength+=[data length];
    float progressValue=(float)_receivedDataLength/_expectedDataLength*100;
    //NSLog(@"didReceiveData:%llu--%.2f",_receivedDataLength,progressValue);
    if (self.delegate && [self.delegate respondsToSelector:@selector(XXCNFileDownloader:loadWithProgress:)]) {
        [self.delegate XXCNFileDownloader:self loadWithProgress:progressValue];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //本次应该下载的数据大小
    _expectedDataLength = [response expectedContentLength];
    
    //如果是断点续传，文件的总大小应该是已经下载的大小+本次应该下载的大小
    if (_isResume) {
        _expectedDataLength+=_receivedDataLength;
    }
    
    NSLog(@"didReceiveResponse:%llu",_expectedDataLength);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    if (self.delegate && [self.delegate respondsToSelector:@selector(XXCNFileDownloaderLoadComplete:)]) {
        [self.delegate XXCNFileDownloaderLoadComplete:self];
    }
    [self finishOperation];
}



#pragma --mark 自定义的方法

//结束进程
-(void)finishOperation
{
    if (!_operationStarted) {
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    [_connection cancel];
    _connection=nil;
    finished = YES;
    executing = NO;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
    
    
    
}

//取消线程任务(对已经完成的线程任务无效)
-(void)cancelOperation
{
    [self pauseOperation];
}

-(void)pauseOperation
{
    
    if ([self isFinished]) {
        return;
    }
    
    if (!_operationStarted) {
        [self willChangeValueForKey:@"isCancelled"];
        
        [_connection cancel];
        _connection=nil;
        cancelled=YES;
        [self didChangeValueForKey:@"isCancelled"];
    }else
    {
        [self finishOperation];
    }
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(XXCNFileDownloaderPaused:)]) {
        [self.delegate XXCNFileDownloaderPaused:self];
    }
    
}



@end
