//
//  RegisterationVC.h
//  Zerx
//
//  Created by beauty on 6/17/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RegisterationVC : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, CLLocationManagerDelegate>
{
    UIDatePicker *datePicker;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    NSString *m_strLatitude, *m_strLongitude, *m_strStreetAddress, *m_strCity, *m_strState, *m_strCountry, *m_strPostalCode;
    
    BOOL m_bEnableLocation;
}

@property (weak, nonatomic) IBOutlet UILabel *lblNavTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentHeightConstraint;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnBirthdate;
@property (weak, nonatomic) IBOutlet UITextField *txtNameOnCard;
@property (weak, nonatomic) IBOutlet UITextField *txtStreet;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtZip;
@property (weak, nonatomic) IBOutlet UITextField *txtCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtSecurityCode;

@property (weak, nonatomic) IBOutlet UIButton *btnSignup;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)onBirthdate:(id)sender;
- (IBAction)onGetLocation:(id)sender;
- (IBAction)onSignup:(id)sender;

- (IBAction)onBack:(id)sender;
@end
