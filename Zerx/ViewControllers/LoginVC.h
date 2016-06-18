//
//  LoginVC.h
//  Zerx
//
//  Created by beauty on 6/16/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationData.h"

@interface LoginVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>
{
    ApplicationData *appData;
}

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UIView *usernameLine;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIView *passwordLine;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)onLogin:(id)sender;
- (IBAction)onForgotPasswordButton:(id)sender;
- (IBAction)onForgotUsernameButton:(id)sender;

@end
