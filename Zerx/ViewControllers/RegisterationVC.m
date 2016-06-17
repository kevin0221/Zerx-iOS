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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    m_bEnableLocation = YES;
    [self startGeoLocation];
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
    UIColor *selectedLineColor = [UIColor colorWithRed:200/255.0f green:0 blue:0 alpha:1];
    self.btnBirthdate.layer.borderColor = selectedLineColor.CGColor;
    [self showDatePicker:UIDatePickerModeDate];
}

- (IBAction)onGetLocation:(id)sender
{
    if (m_bEnableLocation == NO)
    {
        [self showDefaultAlert:@"Connection Error" message:@"Cannot get your address!"];
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
            
            [self showDefaultAlert:@"Connection Error" message:@"Cannot get your address!"];
            
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

- (IBAction)onSignup:(id)sender {
}

- (IBAction)onBack:(id)sender {
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
                                           UIColor *borderColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:120/255.0f alpha:1];
                                           self.btnBirthdate.layer.borderColor = borderColor.CGColor;
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
        [self showDefaultAlert:@"Error" message:@"you must be 16 years old or older!"];
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

-(void)showDefaultAlert:(NSString*)title message:(NSString*)message
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIColor *selectedLineColor = [UIColor colorWithRed:200/255.0f green:0 blue:0 alpha:1];
    [UIView animateWithDuration:0.5f animations:^{
        textField.layer.borderColor = selectedLineColor.CGColor;
        [self.view layoutIfNeeded];
    }];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    UIColor *lineColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:120/255.0f alpha:1];
    textField.layer.borderColor = lineColor.CGColor;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    UIColor *lineColor = [UIColor colorWithRed:30/255.0f green:60/255.0f blue:120/255.0f alpha:1];
    textField.layer.borderColor = lineColor.CGColor;
    
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
