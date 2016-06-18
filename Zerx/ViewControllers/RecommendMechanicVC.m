//
//  RecommendMechanicVC.m
//  Zerx
//
//  Created by beauty on 6/18/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import "RecommendMechanicVC.h"

@interface RecommendMechanicVC ()

@end

@implementation RecommendMechanicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appData = [ApplicationData sharedInstance];
    self.navigationController.navigationBarHidden = NO;

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:18.0];
    lblTitle.text = @"Recommend a Mechanic";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor darkGrayColor];
    [self.navigationItem setTitleView:lblTitle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
