//
//  ChangePasswordVC.m
//  Zerx
//
//  Created by kevin on 6/18/16.
//  Copyright (c) 2016 kevin. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "AppDelegate.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC
@synthesize openUrlID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appData = [ApplicationData sharedInstance];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(btnSumitPressed)]];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(btnCancelPressed)]];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font =  [UIFont fontWithName:ROBOTO_REGULAR size:18.0];
    lblTitle.text = @"Change Password";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor darkGrayColor];
    
    [self.navigationItem setTitleView:lblTitle];
    
    arrCaptions = [[NSMutableArray alloc] init];
    
    if (openUrlID) {
     
        openUrlID = [openUrlID stringByReplacingOccurrencesOfString:@"jaketvpassword://" withString:@""];
        [arrCaptions addObject:@"New Password"];
        [arrCaptions addObject:@"Confirm Password"];
    }
    else{
    
        [arrCaptions addObject:@"Old Password"];
        [arrCaptions addObject:@"New Password"];
        [arrCaptions addObject:@"Confirm Password"];
    }
    
    cellArray=[[NSMutableArray alloc] init];
    for(int i=0;i<[arrCaptions count];i++)
    {
        [cellArray addObject:[NSNull null]];
    }
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tblForgetPwd.frame.size.width, 20)];
    aView.backgroundColor = [UIColor clearColor];
    tblForgetPwd.tableHeaderView = aView;
}

-(void)btnSumitPressed
{
    if (openUrlID.length>0) {
        
        NSIndexPath *aIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell *cell = [tblForgetPwd cellForRowAtIndexPath:aIndexPath];
        UITextField *txtOldPassword = (UITextField *)[cell.contentView viewWithTag:10000];
        
        aIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        cell = [tblForgetPwd cellForRowAtIndexPath:aIndexPath];
        UITextField *txtNewPassword = (UITextField *)[cell.contentView viewWithTag:10000];
        
        
        if ([txtOldPassword.text length] == 0 || [txtNewPassword.text length] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change Password Error" message:@"All field are required to change password " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        if (![txtOldPassword.text isEqualToString:txtNewPassword.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Password and Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        if ([appData connectedToNetwork]) {
            
//            NSArray *keys=[NSArray arrayWithObjects:@"method",@"userid",@"password",nil];
//            NSArray *values=[NSArray arrayWithObjects:@"ChangePassword",openUrlID,txtNewPassword.text,nil];
//            NSDictionary *jsonDict=[NSDictionary dictionaryWithObjects:values forKeys:keys];
//            NSString *json=[jsonDict JSONRepresentation];
//            NSString *request=[NSString stringWithFormat:@"data=%@",json];
//            NSLog(@"%@",request);
//            
//            [appData showLoader];
//            HTTPManager *manager=[HTTPManager managerWithURL:SERVER_ADDRESS delegate:self];
//            manager.requestType=jGeneralQuery;
//            manager.postString=request;
//            [manager startDownload];
        }

    }else{
    
        NSIndexPath *aIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell *cell = [tblForgetPwd cellForRowAtIndexPath:aIndexPath];
        UITextField *txtOldPassword = (UITextField *)[cell.contentView viewWithTag:10000];
        
        aIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        cell = [tblForgetPwd cellForRowAtIndexPath:aIndexPath];
        UITextField *txtNewPassword = (UITextField *)[cell.contentView viewWithTag:10000];
        
        aIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        cell = [tblForgetPwd cellForRowAtIndexPath:aIndexPath];
        UITextField *txtConfirmPassword = (UITextField *)[cell.contentView viewWithTag:10000];
        
        
        if ([txtOldPassword.text length] == 0 || [txtNewPassword.text length] == 0 || [txtConfirmPassword.text length] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forget Password Error" message:@"All field are required to change password " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        NSString *strPwd = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
        if (![strPwd isEqualToString:txtOldPassword.text]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Old Password is incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        if (![txtNewPassword.text isEqualToString:txtConfirmPassword.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Password and Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        if ([appData connectedToNetwork]) {
            
//            NSArray *keys=[NSArray arrayWithObjects:@"method",@"userid",@"password",nil];
//            NSArray *values=[NSArray arrayWithObjects:@"ChangePassword",appData.aUser.UserID,txtNewPassword.text,nil];
//            NSDictionary *jsonDict=[NSDictionary dictionaryWithObjects:values forKeys:keys];
//            NSString *json=[jsonDict JSONRepresentation];
//            NSString *request=[NSString stringWithFormat:@"data=%@",json];
//            NSLog(@"%@",request);
//            
//            [appData showLoader];
//            HTTPManager *manager=[HTTPManager managerWithURL:SERVER_ADDRESS delegate:self];
//            manager.requestType=jGeneralQuery;
//            manager.postString=request;
//            [manager startDownload];
        }

    }
    
}

-(void)btnCancelPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change Password" message:@"Are you sure to cancel change password process? All entered data will be lost by pressing Yes." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag = 10000;
    [alert show];
}


#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000)
    {
        if (buttonIndex == 0)
        {
            openUrlID = nil;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrCaptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[cellArray objectAtIndex:indexPath.row];
    
    if(![[cellArray objectAtIndex:indexPath.row] isEqual:[NSNull null]])
    {
        cell=[cellArray objectAtIndex:indexPath.row];
    }
    
    if([[cellArray objectAtIndex:indexPath.row] isEqual:[NSNull null]])
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"anyCell"];
        
        UITextField *txtValue = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 300, 40)];
        txtValue.borderStyle = UITextBorderStyleNone;
        txtValue.layer.cornerRadius = 0.0;
        txtValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
        txtValue.layer.borderWidth = 1.0;
        txtValue.textColor = [UIColor grayColor];
        txtValue.tag = 10000;
        txtValue.secureTextEntry = YES;
        txtValue.delegate  = self;
        txtValue.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        txtValue.backgroundColor = [UIColor whiteColor];
        txtValue.font = [UIFont fontWithName:@"Avenir Book" size:16];
        
        if (indexPath.row == 3 || indexPath.row == 4)
        {
            txtValue.secureTextEntry = YES;
        }
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        aView.backgroundColor = [UIColor clearColor];
        
        [txtValue setLeftView:aView];
        [txtValue setLeftViewMode:UITextFieldViewModeAlways];
        
        if ([txtValue respondsToSelector:@selector(setAttributedPlaceholder:)]) {
            UIColor *color = [UIColor lightGrayColor];
            txtValue.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[arrCaptions objectAtIndex:indexPath.row] attributes:@{NSForegroundColorAttributeName: color}];
        }
        [cell.contentView addSubview:txtValue];
        [cellArray  replaceObjectAtIndex:indexPath.row withObject:cell];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
