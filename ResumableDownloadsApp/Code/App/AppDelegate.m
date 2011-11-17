#import "AppDelegate.h"
#import "SimpleTableController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize controller;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.controller  = [[[SimpleTableController alloc] initWithValues:$dict()] autorelease];
    [self.window addSubview:controller.view];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc{
    self.controller     =   nil;
    [_window release];
    [super dealloc];
}

@end
