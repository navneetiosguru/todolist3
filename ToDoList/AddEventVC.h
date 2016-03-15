//
//  AddEventVC.h
//  ToDoList
//
//  Created by Manish Kumar on 08/03/16.
//  Copyright © 2016 Manish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDFDatePickerViewController.h"
#import "Report.h"
@interface AddEventVC : UIViewController <CaledarCustomDelegate>
{
    NSDate *startTime;
    NSDate *endTime;
    NSString*calendarDateString;
    NSString *startTimestr;
    NSString *endTimestr;
    NSString *datestr;
    NSString *datestr1;
    NSDate *date;
}
@property(nonatomic,strong) IBOutlet UITextField *tasktext;
@property(nonatomic,strong) IBOutlet UIButton *starttimebutton;
@property(nonatomic,strong) IBOutlet UIButton *endtimebutton;
@property(nonatomic,strong) IBOutlet UIButton *datebutton;
@property(nonatomic,strong) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker1;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@end
