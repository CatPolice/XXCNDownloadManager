//
//  DownloadProgressTableDataSource.h
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-13.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadProgressTableDataSource : NSObject<UITableViewDataSource>

@property(nonatomic,copy)NSArray *urlStrArray;
@property(nonatomic,copy)NSArray *nameArray;
@property(nonatomic,copy)NSMutableArray *progressArray;
@property(nonatomic,copy)NSMutableArray *statusArray;

+(void)setInstanceCellIdentifier:(NSString *)cellIdentifier;

@end
