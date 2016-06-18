//
//  ChangePasswordVC.h
//  Zerx
//
//  Created by kevin on 6/18/16.
//  Copyright (c) 2016 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ApplicationData.h"

@interface ChangePasswordVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate,CLLocationManagerDelegate>
{
    ApplicationData *appData;
    IBOutlet UITableView *tblForgetPwd;
    NSMutableArray *arrCaptions;
    
    UITextField *currentTextField;
    
    NSMutableArray *cellArray;
    NSMutableArray *arrData;
    NSString *openUrlID;
    
}

@property(nonatomic, strong) NSString *openUrlID;
@end
