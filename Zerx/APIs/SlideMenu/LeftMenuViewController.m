//
//  MenuViewController.m
//  Zerx
//
//  Created by kevin on 6/17/16.
//  Copyright (c) 2016 kevin. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "AppDelegate.h"

@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    appData = [ApplicationData sharedInstance];
	self.tblMenu.separatorColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    self.tblMenu.backgroundView = nil;
    self.tblMenu.backgroundColor = [UIColor clearColor];
    CGRect frameTbl = self.tblMenu.frame;
    frameTbl.size.height = frameTbl.size.height - 50;
    self.tblMenu.frame = frameTbl;
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    aView.backgroundColor = [UIColor clearColor];
    
    
    arrImages = [[NSMutableArray alloc] initWithObjects:@"search.png",@"recommend.png",@"bookmarked.png", @"settings.png", @"talktous.png",nil];
    
    arrTitles = [[NSMutableArray alloc] initWithObjects:@"Find a Mechanic", @"Recommend a Mechanic", @"Billing/Invoices", @"Settings", @"Talk to us", nil];
    
    arrSections = [[NSMutableArray alloc] initWithObjects:@"Zerx", nil];
    [self.tblMenu setTableHeaderView:aView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:@"refresh" object:nil];
    
    appData.lastSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tblMenu selectRowAtIndexPath:appData.lastSelectedIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void)refreshView{

    arrImages = [[NSMutableArray alloc] initWithObjects:@"search.png",@"recommend.png",@"bookmarked.png", @"settings.png", @"talktous.png", nil];
    
    arrTitles = [[NSMutableArray alloc] initWithObjects:@"Find a Mechanic", @"Recommend a Mechanic", @"Billing/Invoices", @"Settings", @"Talk to us", nil];
    
    [self.tblMenu reloadData];
    [self.tblMenu selectRowAtIndexPath:appData.lastSelectedIndex animated:NO scrollPosition:UITableViewScrollPositionNone];

}

#pragma mark - UITableView Delegate & Datasrouce -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [arrTitles count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = [arrSections objectAtIndex:section];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:18.0];
    lblTitle.textColor = [UIColor lightGrayColor];
    
    [sectionHeaderView addSubview:lblTitle];
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	
    UIImageView *imgTitle = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 25, 25)];
    imgTitle.backgroundColor = [UIColor clearColor];
    imgTitle.image= [UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(50,10, 200, 25)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = [arrTitles objectAtIndex:indexPath.row];
    lblTitle.font = [UIFont fontWithName:ROBOTO_REGULAR size:15.0];
    lblTitle.textColor =  [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    
    [cell.contentView addSubview:imgTitle];
    [cell.contentView addSubview:lblTitle];
    
    cell.backgroundColor= [UIColor clearColor];
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appData.lastSelectedIndex = indexPath;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    UIViewController *vc ;
    
    switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            break;
        case 1:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"RecommendMechanicVC"];
            break;
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"RecommendMechanicVC"];
            break;
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SettingsVC"];
            break;
        case 4:
            [[SlideNavigationController sharedInstance] sendMail:@"zerx@test.com"];
            return;
        default:
            break;
    }
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:NO
                                                                     andCompletion:nil];
}


@end
