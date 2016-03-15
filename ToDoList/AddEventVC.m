//
//  AddEventVC.m
//  ToDoList
//
//  Created by Manish Kumar on 08/03/16.
//  Copyright © 2016 Manish Kumar. All rights reserved.
//

#import "AddEventVC.h"
#import "RSDFDatePickerViewController.h"
#import "AppDelegate.h"
#import "Common.h"
@interface AddEventVC ()

@end

@implementation AddEventVC
@synthesize tasktext,datebutton,starttimebutton,endtimebutton,submitButton;
@synthesize datepicker;
@synthesize datepicker1;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext=[kAppDel managedObjectContext];
    self.navigationItem.title = @"To do List";
    
    submitButton.layer.cornerRadius=submitButton.frame.size.height/5;
    datepicker.hidden=YES;
    datepicker1.hidden=YES;
    startTime=nil;
    endTime=nil;
}
- (IBAction)DateButtonAction:(id)sendar
{
    datepicker.hidden=YES;
    datepicker1.hidden=YES;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
}
-(void)passSelectedDate:(NSString*)selectedDate{
    [datebutton setTitle:selectedDate forState:UIControlStateNormal];
    calendarDateString=selectedDate;
}
-(IBAction)StartTimeButtonAction:(id)sender
{
    datepicker1.hidden=YES;
    datepicker.hidden=NO;
    datepicker.layer.cornerRadius = 10;
    datepicker.layer.masksToBounds=YES;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    [self.datepicker.layer addAnimation:transition forKey:nil];
    datepicker.date = [NSDate date];
    datepicker.datePickerMode = UIDatePickerModeTime;
    datepicker.backgroundColor = [UIColor purpleColor];
    [datepicker addTarget:self action:@selector(StartButtonChange:)forControlEvents:UIControlEventValueChanged];
    
}
-(void)StartButtonChange:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"h:mm a"];
    [starttimebutton setTitle:[dateFormatter stringFromDate:datepicker.date] forState:UIControlStateNormal];
    startTimestr =[dateFormatter stringFromDate:datepicker.date];
    startTime=[dateFormatter dateFromString:startTimestr];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    datepicker.hidden=YES;
    datepicker1.hidden=YES;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    [self.datepicker.layer addAnimation:transition forKey:nil];
    [self.datepicker1.layer addAnimation:transition forKey:nil];
    }
-(IBAction)endtimebuttonaction:(id)sender
{
    datepicker1.layer.cornerRadius = 10;
    datepicker1.layer.masksToBounds=YES;
    datepicker.hidden=YES;
    datepicker1.hidden = NO;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    [self.datepicker1.layer addAnimation:transition forKey:nil];
    datepicker1.date = [NSDate date];
    datepicker1.datePickerMode = UIDatePickerModeTime;
    datepicker1.backgroundColor = [UIColor purpleColor];
    [datepicker1 addTarget:self action:@selector(EndButtonChange:)forControlEvents:UIControlEventValueChanged];
}
-(void)EndButtonChange:(id)sender
{NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"h:mm a"];
    [endtimebutton setTitle:[dateFormatter2 stringFromDate:datepicker1.date] forState:UIControlStateNormal];
    endTimestr =[dateFormatter2 stringFromDate:datepicker1.date];
    endTime =[dateFormatter2 dateFromString:endTimestr];
    [self localnotification];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(IBAction)SubmitButtonAction:(id)sender
{
    [self checkvalidation];
}
-(void)checkvalidation{
    //format for date
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"dd-MMMM-yyyy"];
    NSDate *today =[[NSDate alloc]init];
    NSString *strToday = [dformat stringFromDate:[NSDate date]];
    today = [dformat dateFromString:strToday];
    NSDate *newDate = [[NSDate alloc] init];
    newDate = [dformat dateFromString:calendarDateString];
    //conditions for task text field
    if (tasktext.text.length==0)
    {
        UIAlertController*aleart=[UIAlertController alertControllerWithTitle:@"To Do List" message:@"Please Enter the Task" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [aleart addAction:ok];
        [self presentViewController:aleart animated:YES completion:nil];
    }
    //condition for date
    else if(newDate==nil)
    {
        UIAlertController*aleart=[UIAlertController alertControllerWithTitle:@"To Do List" message:@"Please Select The Date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [aleart addAction:ok];
        [self presentViewController:aleart animated:YES completion:nil];
    }
    else if(([today compare:newDate]!=NSOrderedSame)&&([today compare:newDate]==NSOrderedDescending))
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"To Do List" message:@"Please select Future date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    //conditions for Time
    else if (startTime==nil)
    {
        UIAlertController*aleart=[UIAlertController alertControllerWithTitle:@"To Do List" message:@"Please Enter the Start Time" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [aleart addAction:ok];
        [self presentViewController:aleart animated:YES completion:nil];
    }
    else if (endTime==nil)
    {
        UIAlertController*aleart=[UIAlertController alertControllerWithTitle:@"To Do List" message:@"Please Enter the End Time" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [aleart addAction:ok];
        [self presentViewController:aleart animated:YES completion:nil];
    }
    else if (([startTime compare:endTime]==NSOrderedDescending)||([startTime isEqual:endTime]))
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"To Do List" message:@"Time is equal Please select Time again" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
        [self saveData];
}
-(void)localnotification{
    NSDate *pickerDate = [self.datepicker1 date];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = pickerDate;
    localNotification.alertBody = self.tasktext.text;
    localNotification.alertAction = @"Show me the item";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)saveData
{
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"dd-MM-yy"];
    date=[dformat dateFromString:calendarDateString];
    NSArray *reportArray=[kAppDel fetchReportFromDatabse];
    Report *reportEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
    reportEntity.serialno=[NSString stringWithFormat:@"%lu",(unsigned long)reportArray.count+1];
    reportEntity.task=tasktext.text;
    reportEntity.date=date;
    reportEntity.starttime=startTimestr;
    reportEntity.endtime=endTimestr;
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@",error);
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"gotocalendar"]) {
        RSDFDatePickerViewController *controller=segue.destinationViewController;
        controller.delegate=self;
    }
}
@end
