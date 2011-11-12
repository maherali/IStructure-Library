#import "AppDelegate.h"
#import "TCRegisterationController.h"
#import "TCUIFactory.h"
#import "TCLoginController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [ISModel setBaseUrl:@"http://gentle-lightning-6506.herokuapp.com/"];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window addSubview:[TCUIFactory backgroundImageView]];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:[[[TCLoginController alloc] initWithValues:$dict()] autorelease]] autorelease];
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc{
    [_window release];
     self.navigationController = nil;
    [super dealloc];
}

@end
