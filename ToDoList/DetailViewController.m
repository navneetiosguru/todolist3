//
//  DetailViewController.m
//  ToDoList
//
//  Created by Manish Kumar on 3/9/16.
//  Copyright © 2016 Manish Kumar. All rights reserved.
//
#import "DetailViewController.h"
#import "AddEventVC.h"
#import "CoreData/CoreData.h"
#import "Common.h"
#import "AppDelegate.h"
@interface DetailViewController ()
@end
@implementation DetailViewController
NSInteger i=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.managedObjectContext=[kAppDel managedObjectContext];
    Contects=[[kAppDel fetchReportFromDatabse]mutableCopy];
    [self.tableview reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath];
    [self.tableview selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    indexPath1=indexPath;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[Contects objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        // Remove device from table view
        [Contects removeObjectAtIndex:indexPath.row];
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Contects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier=@"System";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    if(cell==nil) {
        cell =[tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UILabel *labelno=(UILabel*)[cell viewWithTag:5];
    UILabel *labeltask=(UILabel*)[cell viewWithTag:1];
    UILabel *labeldate=(UILabel*)[cell viewWithTag:2];
    UILabel *lablest=(UILabel*)[cell viewWithTag:3];
    UILabel *labelend=(UILabel*)[cell viewWithTag:4];
    Report *reportEntity=[Contects objectAtIndex:indexPath.row];
    labelno.text=reportEntity.serialno;
    labeltask.text=reportEntity.task;
    lablest.text=reportEntity.starttime;
    labelend.text=reportEntity.endtime;
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"dd-MM-yy"];
    NSString *str=[dformat stringFromDate:reportEntity.date];
    labeldate.text=str;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label0=[[UILabel alloc] initWithFrame:CGRectMake(2, 5, tableView.frame.size.width, 18)];
    [label0 setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string0 =@"S.N";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(39, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =@"Task";
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, tableView.frame.size.width, 18)];
    //[label1 setFont:[UIFont boldSystemFontOfSize:12]];
    //NSString *string1 =@"Date";
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(180, 5, tableView.frame.size.width, 18)];
    [label2 setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string2 =@"Start time";
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(257, 5, tableView.frame.size.width, 18)];
    [label3 setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string3 =@"End time";
    [label0 setText:string0];
    [label setText:string];
    //[label1 setText:string1];
    [label2 setText:string2];
    [label3 setText:string3];
    [view addSubview:label0];
    [view addSubview:label];
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    return view;
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
//}
@end
