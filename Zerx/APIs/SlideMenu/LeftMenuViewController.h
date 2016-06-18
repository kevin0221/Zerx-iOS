//
//  MenuViewController.h
//  SlideMenu
//
//  Created by kevin on 6/17/16.
//  Copyright (c) 2016 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "ApplicationData.h"

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arrTitles;
    NSMutableArray *arrImages;
    NSMutableArray *arrSections;
    ApplicationData *appData;
}
@property (nonatomic, strong) IBOutlet UITableView *tblMenu;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@end
