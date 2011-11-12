#import "WelcomeController.h"
#import "WelcomeView.h"
#import "TCUIFactory.h"

@implementation WelcomeController

- (void) viewDidLoad{
    [super viewDidLoad];
    self.view = [[[WelcomeView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    self.navigationController.navigationBarHidden = NO; 
    self.navigationItem.hidesBackButton = YES;
    __block WelcomeController *this = self;
    $watch(@"logout:requested", this.view,  ^(NSNotification *notif){
        $navigate(@"/logout");
    });
}

+ (void) load{
    __block Class this = self;
    $routec(@"/welcome");
}

@end
