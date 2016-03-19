//
//  AppDelegate.h
//  ToDoList
//
//  Created by Manish Kumar on 08/03/16.
//  Copyright © 2016 Manish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

// Hirendra Branch
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
-(NSArray*)fetchReportFromDatabse;
- (NSURL *)applicationDocumentsDirectory;


@end

