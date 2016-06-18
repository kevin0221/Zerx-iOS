//
//  AppDelegate.h
//  Zerx
//
//  Created by beauty on 6/16/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#define ROBOTO_REGULAR @"Roboto-Regular"
#define ROBOTO_THIN @"Roboto-Thin"
#define ROBOTO_MEDIUM @"Roboto-Medium"

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"
#import "ApplicationData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ApplicationData *appData;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

