#import "WelcomeController.h"
#import "WelcomeView.h"

@implementation WelcomeController

- (void) viewDidLoad{
    [super viewDidLoad];
    self.view = [[[WelcomeView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
}

+ (void) load{
    __block Class this = self;
    $routec(@"/welcome");
}

@end
