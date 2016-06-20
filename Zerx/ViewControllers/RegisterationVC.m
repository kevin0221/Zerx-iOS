//
//  RegisterationVC.m
//  Zerx
//
//  Created by beauty on 6/17/16.
//  Copyright © 2016 kevin. All rights reserved.
//

#import "RegisterationVC.h"
#import "MBProgressHUD.h"

@interface RegisterationVC ()
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@end

@implementation RegisterationVC

@synthesize txtUsername;
@synthesize txtEmail;
@synthesize txtPassword;
@synthesize txtConfirmPassword;
@synthesize btnBirthdate;
@synthesize txtNameOnCard;
@synthesize txtStreet;
@synthesize txtCity;
@synthesize txtState;
@synthesize txtZip;
@synthesize txtCardNumber;
@synthesize txtSecurityCode;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appData = [ApplicationData sharedInstance];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackPressed)]];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:18.0];
    lblTitle.text = @"Create New Account";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor darkGrayColor];
    [self.navigationItem setTitleView:lblTitle];
    
    m_bEnableLocation = YES;
    [self startGeoLocation];
}

-(void)viewWillLayoutSubviews
{
    self.navigationController.navigationBarHidden = NO;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    float titleFontSize = 72 * screenSize.height / 1920.0f;
    self.lblNavTitle.font = [UIFont systemFontOfSize:titleFontSize weight:0.3f];
    
    float textfieldHeight = 130 * screenSize.height / 1920.0f;
    self.scrollContentHeightConstraint.constant = (textfieldHeight + 12) * 12 + 150;
    
    [self setTextFieldBorders];
    
    float signupButtonFontSize = 56 * screenSize.height / 1920.0f;
    self.btnSignup.titleLabel.font = [UIFont systemFontOfSize:signupButtonFontSize weight:0.2f];
    self.btnSignup.layer.cornerRadius = 3.0f;
        
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
}

-(void)setTextFieldBorders
{
    UIColor *borderColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:120/255.0f alpha:1.0];
    
    self.txtUsername.layer.borderWidth = 1.0f;
    self.txtUsername.layer.borderColor = borderColor.CGColor;
    self.txtUsername.layer.cornerRadius = 3.0f;
    
    self.txtEmail.layer.borderWidth = 1.0f;
    self.txtEmail.layer.borderColor = borderColor.CGColor;
    self.txtEmail.layer.cornerRadius = 3.0f;
    
    self.txtPassword.layer.borderWidth = 1.0f;
    self.txtPassword.layer.borderColor = borderColor.CGColor;
    self.txtPassword.layer.cornerRadius = 3.0f;
    
    self.txtConfirmPassword.layer.borderWidth = 1.0f;
    self.txtConfirmPassword.layer.borderColor = borderColor.CGColor;
    self.txtConfirmPassword.layer.cornerRadius = 3.0f;
    
    self.btnBirthdate.layer.borderWidth = 1.0f;
    self.btnBirthdate.layer.borderColor = borderColor.CGColor;
    self.btnBirthdate.layer.cornerRadius = 3.0f;
    
    self.txtNameOnCard.layer.borderWidth = 1.0f;
    self.txtNameOnCard.layer.borderColor = borderColor.CGColor;
    self.txtNameOnCard.layer.cornerRadius = 3.0f;
    
    self.txtStreet.layer.borderWidth = 1.0f;
    self.txtStreet.layer.borderColor = borderColor.CGColor;
    self.txtStreet.layer.cornerRadius = 3.0f;
    
    self.txtCity.layer.borderWidth = 1.0f;
    self.txtCity.layer.borderColor = borderColor.CGColor;
    self.txtCity.layer.cornerRadius = 3.0f;
    
    self.txtState.layer.borderWidth = 1.0f;
    self.txtState.layer.borderColor = borderColor.CGColor;
    self.txtState.layer.cornerRadius = 3.0f;
    
    self.txtZip.layer.borderWidth = 1.0f;
    self.txtZip.layer.borderColor = borderColor.CGColor;
    self.txtZip.layer.cornerRadius = 3.0f;
    
    self.txtCardNumber.layer.borderWidth = 1.0f;
    self.txtCardNumber.layer.borderColor = borderColor.CGColor;
    self.txtCardNumber.layer.cornerRadius = 3.0f;
    
    self.txtSecurityCode.layer.borderWidth = 1.0f;
    self.txtSecurityCode.layer.borderColor = borderColor.CGColor;
    self.txtSecurityCode.layer.cornerRadius = 3.0f;
    
}

#pragma mark - button events
- (IBAction)onBirthdate:(id)sender
{
    [self showDatePicker:UIDatePickerModeDate];
}

- (IBAction)onGetLocation:(id)sender
{
    if (m_bEnableLocation == NO)
    {
        [appData ShowAlert:@"Connection Error" andMessage:@"Cannot get your address!"];
        return;
    }
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.dimBackground = YES;
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error == nil && [placemarks count] > 0)
        {
            placemark = [placemarks lastObject];
            
            //NSString *latitude, *longitude, *state, *country;
            
            m_strLatitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
            m_strLongitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
            
            m_strStreetAddress = placemark.subLocality;
            m_strState = placemark.administrativeArea;
            m_strCity = placemark.locality;
            m_strCountry = placemark.country;
            m_strPostalCode = placemark.postalCode;
            
            NSLog(@"%@, %@, %@", m_strCountry, m_strState, placemark.thoroughfare);
            
            [self showAddress];
            
            progressHUD.hidden = YES;
        }
        else
        {
            NSLog(@"%@", error.debugDescription);
            progressHUD.hidden = YES;
            
            [appData ShowAlert:@"Connection Error" andMessage:@"Cannot get your address!"];
        }
    }];
}

-(void)showAddress
{
    self.txtStreet.text = m_strStreetAddress;
    self.txtCity.text = m_strCity;
    self.txtState.text = m_strState;
    self.txtZip.text = m_strPostalCode;
    
}

- (IBAction)onSignup:(id)sender
{
    
    if ([txtUsername.text length] == 0 || [txtEmail.text length] == 0 || [txtPassword.text length] == 0 || [txtConfirmPassword.text length] == 0 || [btnBirthdate.titleLabel.text length] == 0 || [txtNameOnCard.text length] == 0 || [txtStreet.text length] == 0 || [txtCity.text length] == 0 || [txtState.text length] == 0 || [txtZip.text length] == 0 || [txtCardNumber.text length] == 0 || [txtSecurityCode.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:@"All field are required to complete registration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![appData validateEmail:txtEmail.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Invalid" message:@"Please enter valid email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString *trimmed = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!(trimmed.length > 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Please enter valid password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![txtPassword.text isEqualToString:txtConfirmPassword.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Password and Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([btnBirthdate.titleLabel.text isEqualToString:@"Birthdate (16 or older)"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Birthday Error" message:@"Please select valid birthday" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)btnBackPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - datePicker

-(void)showDatePicker:(UIDatePickerMode)modeDatePicker
{
    UIView *viewDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [viewDatePicker setBackgroundColor:[UIColor clearColor]];
    
    // Make a frame for the picker & then create the picker
    CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    datePicker.datePickerMode = modeDatePicker;
    datePicker.hidden = NO;
    [viewDatePicker addSubview:datePicker];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [datePicker setFrame:CGRectMake(0, 0, 300, 200)];
        [viewDatePicker setFrame:CGRectMake(0, 0, 300, 200)];
    }
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"\n\n\n\n\n\n\n\n\n\n"
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController.view addSubview:viewDatePicker];
        
        // if ipad
        alertController.popoverPresentationController.sourceView = self.btnBirthdate;
        alertController.popoverPresentationController.sourceRect = CGRectMake(self.btnBirthdate.bounds.size.width - 100, 22, 1, 1);
        //////
        
        
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {
                                         //Detect particular click by tag and do some thing here
                                         
                                         [self setSelectedDateInField];
                                         NSLog(@"OK action");
                                         
                                     }];
        [alertController addAction:doneAction];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                        }];
        
        
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}


-(void)setSelectedDateInField
{
    NSLog(@"date :: %@",datePicker.date.description);
    
    UIColor *borderColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:120/255.0f alpha:1];
    self.btnBirthdate.layer.borderColor = borderColor.CGColor;
    
    //set Date formatter
    NSDateFormatter *defaultFormatter = [[NSDateFormatter alloc] init];
    [defaultFormatter setDateFormat:@"MM/dd/YYYY"];
    
    NSString *strSelectedDate = [defaultFormatter stringFromDate:datePicker.date];
    if ([self getOld:strSelectedDate] < 16) {
        [appData ShowAlert:@"Error" andMessage:@"you must be 16 years old or older!"];
        return;
    }
    [self.btnBirthdate setTitle:strSelectedDate forState:UIControlStateNormal];
    
}

-(NSInteger)getOld:(NSString*)strDate
{
    NSDateFormatter *defaultFormatter = [[NSDateFormatter alloc] init];
    
    [defaultFormatter setDateFormat:@"YYYY"];
    NSInteger currentYear = [[defaultFormatter stringFromDate:[NSDate date]] integerValue];
    
    strDate = [strDate substringFromIndex:strDate.length - 4];
    NSInteger birthYear = [strDate integerValue];
  
    return currentYear - birthYear;
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - keyboard appears and disappears notification

-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)deregisterFromKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.bottomConstraint.constant = keyboardSize.height;
        [self.view layoutIfNeeded];
    }];
    
}

-(void)keyboardWillBeHidden:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3f animations:^{
        self.bottomConstraint.constant = 0.0f;
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark - Start GeoLocation
-(void)startGeoLocation
{
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    currentLocation = [locations lastObject];
    
    NSLog(@"%f %f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
    
    m_bEnableLocation = YES;
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
    NSLog(@"%@", error.debugDescription);
    
    m_bEnableLocation = NO;
}
@end
