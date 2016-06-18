
#import "ApplicationData.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>

NSString *databaseName=@"Inspections_db.sqlite3";

static ApplicationData *applicationData = nil;

@implementation ApplicationData

@synthesize aViewController;
@synthesize isiPad;
@synthesize isPrivacy,totalPages;
@synthesize aUser;
@synthesize lastSelectedIndex;


-(void)initialize // Initilize Default Values Here
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        isiPad=TRUE;
    }
    else
    {
        isiPad=FALSE;
    }
   
}
+ (ApplicationData*)sharedInstance {
    if (applicationData == nil) {
        applicationData = [[super allocWithZone:NULL] init];
		[applicationData initialize];
    }
    return applicationData;
}

#pragma mark - MBProgressHUD Methods

-(void)showLoader
{
    if(![UIApplication sharedApplication].isNetworkActivityIndicatorVisible)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        if(!hud)
        {
            hud = [[MBProgressHUD alloc] init];
            
            hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
           
        }
        else{
       
            [[UIApplication sharedApplication].keyWindow addSubview:hud];
        }
    }
}

-(void)hideLoader
{
    if([UIApplication sharedApplication].isNetworkActivityIndicatorVisible)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [hud removeFromSuperview];
    }
}

-(void)ShowAlert:(NSString*)title andMessage:(NSString*)messsage
{
    UIAlertView *alrView=[[UIAlertView alloc] initWithTitle:title message:messsage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alrView show];
}

- (BOOL) validateEmail: (NSString *) candidate {
    
    if([[candidate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] length] == 0)
        return YES;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark Internet Connection
- (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    BOOL isconnected = (isReachable && !needsConnection) ? YES : NO;
    
    if (!isconnected) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please check your internet connectivity." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    return isconnected;
}

@end
