//
//  HomeVC.m
//  Zerx
//
//  Created by beauty on 6/17/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appData = [ApplicationData sharedInstance];
    self.navigationController.navigationBarHidden = NO;

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:18.0];
    lblTitle.text = @"Search a Mechanic";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor darkGrayColor];
    [self.navigationItem setTitleView:lblTitle];
   
}

-(void)viewWillLayoutSubviews
{
    self.navigationController.navigationBarHidden = NO;
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


@end
