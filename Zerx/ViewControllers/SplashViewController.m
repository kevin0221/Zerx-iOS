//
//  SplashViewController.m
//  Zerx
//
//  Created by beauty on 6/18/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import "SplashViewController.h"
#import "LoginVC.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillLayoutSubviews
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    float buttonHeight = 130 * screenSize.height / 1920.0f;
    self.btnReady.layer.cornerRadius = buttonHeight / 2.0f;
    self.btnGetStarted.layer.cornerRadius = buttonHeight / 2.0f;
    
    self.topConstratint.constant = screenSize.height;
    self.bottomConstraint.constant = -screenSize.height;
}

- (IBAction)onReadMore:(id)sender
{
    [self.readMoreView setHidden:NO];
    [self.view bringSubviewToFront:self.readMoreView];
    
    [UIView animateWithDuration:0.5f animations:^{
        self.topConstratint.constant = 0.0f;
        self.bottomConstraint.constant = 0.0f;
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)onReady:(id)sender
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [UIView animateWithDuration:0.5f animations:^{
        [self.readMoreView setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    }];
}

- (IBAction)onGetStarted:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"firstlaunch"];
    
    LoginVC *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController setViewControllers:@[loginVC] animated:YES];
}

@end
