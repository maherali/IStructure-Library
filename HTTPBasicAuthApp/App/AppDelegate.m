#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize session, marketing;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    __block AppDelegate *this = self;
    [ISModel setBaseUrl:@"http://10.211.55.4:3000/"];
    self.session = [[[Session alloc] initWithAttributes:$dict(@"user_name", @"alime@me.com", @"password", @"test123 ") andOptions:$dict()] autorelease];
    self.marketing = [[[Marketing alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    [session save:$dict(SUCCESS_HANDLER_KEY, $block(^(Session *model, NSData *data){
        [UIAlertView message:$array(@"Success logging to server!")];
    }), FAILURE_HANDLER_KEY, $block(^(Session *model, NSArray *errors){
        [UIAlertView errors:errors];
        [this.marketing fetch:$dict(SUCCESS_HANDLER_KEY, $block(^(Marketing *model, NSData *data){
            [UIAlertView message:$array(@"Success marketing!")];
        }), FAILURE_HANDLER_KEY, $block(^(Marketing *model, NSArray *errors){
            [UIAlertView errors:errors];
        }))];
    }))];
}

- (void)dealloc{
    [_window release];
    self.session    =   nil;
    self.marketing  =   nil;
    [super dealloc];
}


@end
