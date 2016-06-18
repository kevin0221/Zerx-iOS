//
//  SettingsVC.h
//  Zerx
//
//  Created by kevin on 6/18/16.
//  Copyright (c) 2016 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "ApplicationData.h"

@interface SettingsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    ApplicationData *appData;
    IBOutlet UITableView *tblSettings;
    NSMutableArray *arrImages;
    NSMutableArray *arrSections;
    NSMutableArray *arrTitles;
}
@end
