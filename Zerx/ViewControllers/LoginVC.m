//
//  LoginVC.m
//  Zerx
//
//  Created by beauty on 6/16/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import "LoginVC.h"
#import "HomeVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

@synthesize txtUsername;
@synthesize txtPassword;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    appData = [ApplicationData sharedInstance];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillLayoutSubviews
{
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    txtUsername.text = @"";
    txtPassword.text = @"";
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIColor *lineColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:160/255.0f alpha:1.0];
    self.usernameLine.backgroundColor = lineColor;
    self.passwordLine.backgroundColor = lineColor;
    
    float loginButtonFontSize = 56 * screenSize.height / 1920.0f;
    self.btnLogin.titleLabel.font = [UIFont systemFontOfSize:loginButtonFontSize weight:0.2f];
    self.btnLogin.layer.cornerRadius = 3.0f;
}


#pragma mark - button events

- (IBAction)onLogin:(id)sender
{
    if ([appData connectedToNetwork])
    {
        txtPassword.text = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([txtUsername.text length] == 0 || [txtPassword.text length] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter valid username and password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        else
        {
            [self LoginMethod:txtUsername.text Password:txtPassword.text];
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"googleSignIn"];
        }
    }
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


-(void)LoginMethod:(NSString *)Email Password:(NSString *)password
{
    HomeVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            UITextField *txtField = [alertView textFieldAtIndex:0];
            NSString *strEmail = txtField.text;
            
            if(![appData validateEmail:strEmail])
            {
                [appData ShowAlert:@"Error" andMessage:@"Invalid Email!"];
            } else {
                
            }
        }
    }
    if (alertView.tag == 1002) {
        if (buttonIndex == 0) {
            UITextField *txtField = [alertView textFieldAtIndex:0];
            NSString *strEmail = txtField.text;
            if([strEmail isEqualToString:@""])
            {
                [appData ShowAlert:@"Error" andMessage:@"Invalid Username!"];
            } else {
                
            }
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
