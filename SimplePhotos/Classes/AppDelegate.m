#import "AppDelegate.h"
#import "Photo.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize photo;

- (void)dealloc{
    self.photo = nil;
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [ISModel setBaseUrl:@"http://localhost:3000/"];
    self.photo = [[[Photo alloc] initWithAttributes:$dict() andOptions:$dict()] autorelease];
    photo.image = [UIImage imageNamed:@"clouds.jpg"];
    [photo save:$dict(SUCCESS_HANDLER_KEY, $block(^(Photo *model, NSData *data){
        [UIAlertView message:$array(@"Success uploading photo to server!")];
    }), FAILURE_HANDLER_KEY, $block(^(Photo *model, NSArray *errors){
        [UIAlertView errors:errors];
    }))];
}

@end
