//
//  LoginVC.m
//  Zerx
//
//  Created by beauty on 6/16/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    float titleFontSize = 72 * screenSize.height / 1920.0f;
    self.lblNavTitle.font = [UIFont systemFontOfSize:titleFontSize weight:0.3f];
    
    UIColor *lineColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:160/255.0f alpha:1.0];
    self.usernameLine.backgroundColor = lineColor;
    self.passwordLine.backgroundColor = lineColor;
    
    float loginButtonFontSize = 56 * screenSize.height / 1920.0f;
    self.btnLogin.titleLabel.font = [UIFont systemFontOfSize:loginButtonFontSize weight:0.2f];
    self.btnLogin.layer.cornerRadius = 3.0f;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - button events

- (IBAction)onLogin:(id)sender
{
    
}

- (IBAction)onForgotPasswordButton:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password?" message:@"Please enter your email address to recover password." delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:@"Cancel",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.delegate = self;
    alert.tag = 1001;
    [alert show];
}

- (IBAction)onForgotUsernameButton:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Forgot Username?" message:@"Please enter your email address to recover username." delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:@"Cancel",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.delegate = self;
    alert.tag = 1002;
    [alert show];
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            UITextField *txtField = [alertView textFieldAtIndex:0];
            NSString *strEmail = txtField.text;
        }
    }
    if (alertView.tag == 1002) {
        if (buttonIndex == 0) {
            UITextField *txtField = [alertView textFieldAtIndex:0];
            NSString *strEmail = txtField.text;
        }
    }
    
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIColor *selectedLineColor = [UIColor colorWithRed:200/255.0f green:0 blue:0 alpha:1];
    if(textField == self.txtUsername)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.usernameLine.backgroundColor = selectedLineColor;
            [self.view layoutIfNeeded];
        }];
    }
    if(textField == self.txtPassword)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.passwordLine.backgroundColor = selectedLineColor;
            [self.view layoutIfNeeded];
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    UIColor *lineColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:160/255.0f alpha:1];
    if(textField == self.txtUsername)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.usernameLine.backgroundColor = lineColor;
            [self.view layoutIfNeeded];
        }];
    }
    if(textField == self.txtPassword)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.passwordLine.backgroundColor = lineColor;
            [self.view layoutIfNeeded];
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    UIColor *lineColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:160/255.0f alpha:1];
    if(textField == self.txtUsername)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.usernameLine.backgroundColor = lineColor;
            self.passwordLine.backgroundColor = lineColor;
            [self.view layoutIfNeeded];
        }];
    }
    
    return YES;
}


@end
