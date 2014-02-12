//
//  Example3Cell.h
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Example3Cell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLabel;


@property(nonatomic)BOOL downloading;


-(void)setDownloadProgress:(float)progress;

@end
