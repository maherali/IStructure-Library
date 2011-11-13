#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    $start(@"app", $dict(@"window", self.window));
    return YES;
}

- (void)dealloc{
    self.window = nil;
    [super dealloc];
}

@end
