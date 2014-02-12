//
//  Example3ViewController.m
//  XXCNDownLoadManager
//
//  Created by wang yan on 14-2-12.
//  Copyright (c) 2014年 sogou. All rights reserved.
//

#import "Example3ViewController.h"
#import "Example3Cell.h"

@interface Example3ViewController ()

@end


static NSString *CellIdentifier = @"Cell";


@implementation Example3ViewController
{
    NSArray *_urlStrArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.5 green:0.2 blue:0.7 alpha:0.4]];
    
    
    _urlStrArray=@[@"http://10.129.32.30/mp3s/1.mp3",
                   @"http://10.129.32.30/mp3s/2.mp3",
                   @"http://10.129.32.30/mp3s/88.mp3",
                   @"http://10.129.32.30/mp3s/3.mp3",
                   @"http://10.129.32.30/mp3s/4.mp3",
                   @"http://10.129.32.30/mp3s/5.mp3",
                   @"http://10.129.32.30/mp3s/6.mp3",
                   @"http://10.129.32.30/mp3s/7.mp3"];
    
    [self.tableView registerClass:[Example3Cell class] forCellReuseIdentifier:CellIdentifier];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_urlStrArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    Example3Cell *cell = (Example3Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell==nil) {
        cell=[[Example3Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //
    }
    
    
    //cell.titleLabel.text=_urlStrArray[indexPath.row];
    cell.titleLabel.text=[@"" stringByAppendingFormat:@"%i",indexPath.row];
    
    
    if (!cell.downloading) {
        
        
        
        NSString *tempTag=[NSString stringWithFormat:@"%i",indexPath.row];
        
        NSLog(@"tempTag:%@",tempTag);
        
        cell.tag=indexPath.row;
        
        [[XXCNDownloadManager sharedDownloadManager] downloadURLStr:_urlStrArray[indexPath.row] withTag:tempTag withDelegate:self];
        
        cell.downloading=YES;
    }
    
    
    
    return cell;
}


-(void)XXCNFileDownloader:(XXCNFileDownloader *)fileDownloader loadWithProgress:(float)progress
{
    NSInteger tempTag=[fileDownloader.tag integerValue];
    
    for(Example3Cell *cell in [self.tableView visibleCells])
    {
        if (cell.tag == tempTag) {
            [cell setDownloadProgress:progress];
            break;
        }
    }
}

-(void)XXCNFileDownloader:(XXCNFileDownloader *)fileDownloader loadFailWithError:(NSError *)error
{
    NSLog(@"剩余任务个数为:%i",[[XXCNDownloadManager sharedDownloadManager] currentOperationCount]);
}

-(void)XXCNFileDownloaderLoadComplete:(XXCNFileDownloader *)fileDownloader
{
    NSLog(@"剩余任务个数为:%i",[[XXCNDownloadManager sharedDownloadManager] currentOperationCount]);
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
