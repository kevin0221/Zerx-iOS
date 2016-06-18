//
//  SplashViewController.h
//  Zerx
//
//  Created by beauty on 6/18/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *btnReady;

@property (weak, nonatomic) IBOutlet UIView *readMoreView;
@property (weak, nonatomic) IBOutlet UIButton *btnGetStarted;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstratint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)onReadMore:(id)sender;
- (IBAction)onReady:(id)sender;
- (IBAction)onGetStarted:(id)sender;


@end
