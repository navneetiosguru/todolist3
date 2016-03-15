//
//  DetailViewController.h
//  ToDoList
//
//  Created by Manish Kumar on 3/9/16.
//  Copyright © 2016 Manish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    NSMutableArray *Contects;
    IBOutlet UILabel *datelabel;
    IBOutlet UILabel *Tasklabel;
    IBOutlet UILabel *startTimelabel;
    IBOutlet UILabel *endTimelabel;
    IBOutlet UILabel *SNlabel;
    NSIndexPath *indexPath1;
  }

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property(nonatomic,strong)IBOutlet UITableView *tableview;
@end
