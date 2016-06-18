#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "User.h"


//#define MAIN_COLOR [UIColor colorFromHexCode:@"389ce8"]
#define BACKGROUND_COLOR [UIColor colorFromHexCode:@"#FFFFFF"] //f5f7fa
#define DETAIL_COLOR [UIColor colorFromHexCode:@"389ce8"]
//#define AuthanticationKey @"1upH3R3"

@interface ApplicationData : NSObject <UIAlertViewDelegate>
{
    User *aUser;
    MBProgressHUD *hud;
    
    BOOL isiPad;
    
    BOOL isForPostTag;
    
    NSIndexPath *lastSelectedIndex;
    BOOL isOpenUrl;
}

@property (nonatomic, strong) NSIndexPath *lastSelectedIndex;

@property (nonatomic, retain) User *aUser;
@property (nonatomic, retain) UIView *aViewController;
@property(nonatomic)BOOL isiPad;
@property (nonatomic, readwrite) BOOL isPrivacy;
@property (nonatomic, readwrite) NSInteger totalPages;

+ (ApplicationData*)sharedInstance;

-(void)showLoader;
-(void)hideLoader;
-(void)ShowAlert:(NSString*)title andMessage:(NSString*)messsage;
-(BOOL)validateEmail: (NSString *) candidate;
- (BOOL)connectedToNetwork;

@end
