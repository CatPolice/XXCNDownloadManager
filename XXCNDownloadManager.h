//
//  XXCNDownloadManager.h
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXCNFileDownloader.h"

@interface XXCNDownloadManager : NSObject

+ (instancetype)sharedDownloadManager;

-(NSInteger)currentOperationCount;

-(XXCNFileDownloader *)downloadURLStr:(NSString *)urlStr withTag:(NSString *)tag withDelegate:(id<XXCNFileDownloaderDelegate>)delegate;



@end
