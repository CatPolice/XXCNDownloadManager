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
    NSString *_urlStr;
    
    NSURLConnection *_connection;
    
    //文件的总大小
    uint64_t _expectedDataLength;
    //当前已经下载的数据的大小
    uint64_t _receivedDataLength;
    
    
    BOOL finished;
    BOOL executing;
}

-(id)initWidthURLStr:(NSString *)urlstr
{
    self=[super init];
    if (self) {
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

-(void)start
{
    
    NSMutableURLRequest *fileRequest =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:kDefaultTimeoutInterval];
    
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
            [self didChangeValueForKey:@"isExecuting"];
            
        }
    }
    
    
    NSLog(@"start:%@",_tag);
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
    _expectedDataLength = [response expectedContentLength];
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



-(void)finishOperation
{
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    [_connection cancel];
    _connection=nil;
    finished = YES;
    executing = NO;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
    
    
}


-(BOOL)isConcurrent
{
    return YES;
}
- (BOOL) isFinished{
    
    return finished;
}
- (BOOL) isExecuting{
    
    return executing;
}


@end
