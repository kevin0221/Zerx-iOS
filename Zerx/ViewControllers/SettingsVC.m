//
//  Settings.m
//  Zerx
//
//  Created by kevin on 6/18/16.
//  Copyright (c) 2016 kevin. All rights reserved.
//

#import "SettingsVC.h"
#import "ChangePasswordVC.h"
//#import "AboutUsViewController.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appData = [ApplicationData sharedInstance];
    [tblSettings setSeparatorColor:[UIColor darkGrayColor]];
    
    UIImageView *imgTitleBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    imgTitleBG.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:18.0];
    lblTitle.text = @"Settings";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor darkGrayColor];
    [self.navigationItem setTitleView:lblTitle];
    
    UIImageView *imgSeperator = [[UIImageView alloc] initWithFrame:CGRectMake(0, lblTitle.frame.origin.y+lblTitle.frame.size.height, self.view.frame.size.width, 1)];
    imgSeperator.backgroundColor = [UIColor darkGrayColor];
    
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"googleSignIn"];
    
    if ([str isEqualToString:@"0"]) {
    
        arrTitles = [[NSMutableArray alloc] initWithObjects:@"Profile Settings",@"Change Password", nil];
    }else{
   
        arrTitles = [[NSMutableArray alloc] initWithObjects:@"Profile Settings", nil];
    }
    
    arrSections = [[NSMutableArray alloc] initWithObjects:@"ACCOUNT", nil];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOutClicked:)]];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

-(IBAction)signOutClicked:(id)sender{

    appData.lastSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - UITableViewDataSource

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = [arrSections objectAtIndex:section];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:15.0];
    lblTitle.textColor = [UIColor darkGrayColor];
    
    [sectionHeaderView addSubview:lblTitle];
    return sectionHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrTitles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 200, 25)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = [arrTitles objectAtIndex:indexPath.row];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:15.0];
    lblTitle.textColor =  [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];

    [cell.contentView addSubview:lblTitle];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1 && indexPath.section == 0) {
        
        ChangePasswordVC *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordVC"];
        [self.navigationController pushViewController:lvc animated:YES];

    }
    
}
@end
