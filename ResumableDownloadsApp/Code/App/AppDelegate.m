#import "AppDelegate.h"
#import "SimpleTableController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:[[[SimpleTableController alloc] initWithNibName:@"SimpleTableController" bundle:nil andValues:$dict()] autorelease]] autorelease];
    [self.window addSubview:navigationController.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc{
    self.navigationController     =   nil;
    [_window release];
    [super dealloc];
}

@end
