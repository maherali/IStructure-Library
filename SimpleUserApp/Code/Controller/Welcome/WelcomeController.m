#import "WelcomeController.h"
#import "WelcomeView.h"
#import "TCUIFactory.h"

@implementation WelcomeController

// Since this controller inherits from ISViewController, no need to define and manage observers and unwatching. It's done in the parent class.
- (void) viewDidLoad{
    [super viewDidLoad];
    self.view = [[[WelcomeView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    self.navigationController.navigationBarHidden = NO; 
    self.navigationItem.hidesBackButton = YES;
    __block WelcomeController *this = self;
    // Watch for logout:requested event
    $watch(@"logout:requested", this.view,  ^(NSNotification *notif){
        $navigate(@"/logout"); // navigate to logout
    });
}

+ (void) load{
    __block Class this = self;
    $routec(@"/welcome"); // here, we register this route.
}

@end
